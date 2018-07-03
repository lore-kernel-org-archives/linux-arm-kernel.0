From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 3 Jul 2018 19:12:56 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
Message-ID: <20180703171255.GB23144@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03, Ravi Bangoria wrote:
>
> > OK, and how exactly they update the counter? I mean, can we assume that, say,
> > bcc or systemtap can only increment or decrement it?
>
> I don't think we can assume anything here because this is all in user's
> control. User can even manually go and update the counter by directly
> hooking into the memory.

Then how this all can work? I understand that user-space can do anything with
this counter, but we do not care if it does something wrong, say nullifies the
ctr incremented by kernel.

I don't understand this. I think that if a user registers uprobe with
->ref_ctr_offset != 0 we can safely assume that this is a counter, and we do
not care if userspace corrupts it.

> > If yes, perhaps we can simplify the kernel code...
>
> Sure, let me know if you have any better idea.

Can't we (ab)use the most significant bit in this counter?

To simplify, lets suppose for the moment that 2 different uprobes can't have
the same ->ref_ctr_offset. Then we can do something like

	#define UPROBE_KERN_CTR		(SHRT_MAX + 1)	// MSB

	install_breakpoint:

		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
			*ctr_ptr |= UPROBE_KERN_CTR;

		set_swbp();

and

	remove_breakpoint:

		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
			*ctr_ptr &= ~UPROBE_KERN_CTR;

		set_orig_insn();

IOW, we increment/decrement by UPROBE_KERN_CTR, not by 1. But this way the
"increment" is idempotent, we do not care if "|=" or "&=" was applied more than
once, we do not need to record the fact that the counter was already incremented,
and inc/dec are always balanced.


Now, lets recall that multiple uprobes can share the same counter. install_breakpoint()
is still fine, and we only need to add the additional code into remove_breakpoint:

		for (each uprobe with the same inode and ref_ctr_offset)
			if (filter_chain(uprobe))
				goto keep_ctr;

		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
			*ctr_ptr &= ~UPROBE_KERN_CTR;

	keep_ctr:
		set_orig_insn();
				

Just an idea.

What do you think?

Oleg.
