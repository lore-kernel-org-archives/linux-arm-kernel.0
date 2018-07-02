From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 2 Jul 2018 20:01:56 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
Message-ID: <20180702180156.GA31400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02, Ravi Bangoria wrote:
>
> Hi Oleg,
>
> On 07/02/2018 02:39 AM, Oleg Nesterov wrote:
> > On 06/28, Ravi Bangoria wrote:
> >>
> >> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
> >>  	if (ret <= 0)
> >>  		goto put_old;
> >>
> >> +	/* Update the ref_ctr if we are going to replace instruction. */
> >> +	if (!ref_ctr_updated) {
> >> +		ret = update_ref_ctr(uprobe, mm, is_register);
> >> +		if (ret)
> >> +			goto put_old;
> >> +
> >> +		ref_ctr_updated = 1;
> >> +	}
> >
> > Why can't this code live in install_breakpoint() and remove_breakpoint() ?
> > this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
> > and the logic will be more simple.
>
> IMO, it's more easier with current approach. Updating reference counter
> inside uprobe_write_opcode() makes it tightly coupled with instruction
> patching. Basically, reference counter gets incremented only when first
> consumer gets activated and will get decremented only when last consumer
> is going away.
>
> Advantage is, we can get rid of sdt_mm_list patch*, because increment and
> decrement are anyway happening in sync. This makes the implementation lot
> more simpler. If I do it inside install_breakpoit()/ remove_breakpoint(),
> I've to reintroduce sdt_mm_list which makes code more complicated and ugly.

Why? I do not understand. Afaics you can have the same logic, but the resulting
code will be simpler and more clear.

> BTW, is there any harm in exporting struct uprobe outside of uprobe.c?

I think it is always better to avoid the exporting if possible (and avoid
changing the arch-dependant set_swbp/set_orig_insn). But once again, I think
this only complicates the code for no reason.

> > So why do we need a counter but not a boolean? IIRC, because the counter can
> > be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
> > right?
>
> Actually, it's by design. This counter keeps track of current tracers
> tracing on a particular SDT marker. So only boolean can't work here.
> Also, yes, multiple markers can share the same reference counter.

markers or uprobes? OK, I'll assume that multiple uprobes can share the counter.

> > But who else can use this counter and how? Say, can userspace update it too?
>
> There are many different ways user can change the reference counter.
> Ex, systemtap and bcc both uses uprobe to probe on a marker but reference
> counter update logic is different in both of them. Systemtap records all
> exec/mmap events and updates the counter when it finds interested process/
> vma. bcc directly hooks into process's memory (/proc/pid/mem).

OK, and how exactly they update the counter? I mean, can we assume that, say,
bcc or systemtap can only increment or decrement it?

If yes, perhaps we can simplify the kernel code...

Oleg.
