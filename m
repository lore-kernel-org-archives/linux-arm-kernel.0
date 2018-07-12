From: oleg@redhat.com (Oleg Nesterov)
Date: Thu, 12 Jul 2018 16:58:50 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com>
 <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
Message-ID: <20180712145849.GB15265@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11, Ravi Bangoria wrote:
>
> > However, I still think it would be better to avoid uprobe exporting and modifying
> > set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
> > I'll re-check...
>
> Good that you bring this up. Actually, we can implement same logic
> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
> in uprobe_write_opcode(). No need to export struct uprobe outside,
> no need to change set_swbp() / set_orig_insn() syntax. Just that we
> need to pass arch_uprobe object to uprobe_write_opcode().

Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
arg to uprobe_write_opcode(). OK, this is fine.


> But, I wanted to discuss about making ref_ctr_offset a uprobe property
> or a consumer property, before posting v6:
>
> If we make it a consumer property, the design becomes flexible for
> user. User will have an option to either depend on kernel to handle
> reference counter or he can create normal uprobe and manipulate
> reference counter on his own. This will not require any changes to
> existing tools. With this approach we need to increment / decrement
> reference counter for each consumer. But, because of the fact that our
> install_breakpoint() / remove_breakpoint() are not balanced, we have
> to keep track of which reference counter have been updated in which
> mm, for which uprobe and for which consumer. I.e. Maintain a list of
> {uprobe, consumer, mm}.

Did you explore the UPROBE_KERN_CTR hack I tried to suggest?

If it can work then, again, *ctr_ptr |= UPROBE_KERN_CTR from install_breakpoint()
paths is always fine, the nontrivial part is remove_breakpoint() case, perhaps
you can do something like

		for (each uprobe in inode)
			for (each consumer)
				if (consumer_filter(consumer))
					goto keep_ctr;

		for (each vma which maps this counter)
			*ctr_ptr &= ~UPROBE_KERN_CTR;

	keep_ctr:
		set_orig_insn(...);

but again, I didn't even try to think about details, not sure this
can really work.

And in any case:

> This will make kernel implementation quite
> complex

Yes. So I personally won't insist on this feature.

> Third options: How about allowing 0 as a special value for reference
> counter? I mean allow uprobe_register() and uprobe_register_refctr()
> in parallel but do not allow two uprobe_register_refctr() with two
> different reference counter.

I am not sure I understand how you can do this, and how much complications
this needs, so I have no opinion.


Cough, just noticed the final part below...

> PS: We can't abuse MSB with first approach because any userspace tool
> can also abuse MSB in parallel.

For what?

> Probably, we can abuse MSB in second
> and third approach, though, there is no need to.

Confused... If userspace can change it, how we can use it in 2nd approach?

Oleg.
