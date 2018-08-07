From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 7 Aug 2018 13:36:23 +0200
Subject: [PATCH v7 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
References: <20180731035143.11942-1-ravi.bangoria@linux.ibm.com>
 <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
 <20180803112455.GA13794@redhat.com>
 <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
Message-ID: <20180807113622.GC19831@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ravi,

On 08/06, Ravi Bangoria wrote:
>
> >> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> >> +{
> >> +	struct delayed_uprobe *du;
> >> +
> >> +	if (delayed_uprobe_check(uprobe, mm))
> >> +		return 0;
> >> +
> >> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
> >> +	if (!du)
> >> +		return -ENOMEM;
> >> +
> >> +	du->uprobe = uprobe;
> >> +	du->mm = mm;
> >
> > I am surprised I didn't notice this before...
> >
> > So
> > 	du->mm = mm;
> >
> > is fine, mm can't go away, uprobe_clear_state() does delayed_uprobe_remove(NULL,mm).
> >
> > But
> > 	du->uprobe = uprobe;
> >
> > doesn't look right, uprobe can go away and it can be freed, its memory can be reused.
> > We can't rely on remove_breakpoint(),
>
>
> I'm sorry. I didn't get this. How can uprobe go away without calling
>     uprobe_unregister()
>     -> rergister_for_each_vma()
>        -> remove_breakpoint()
> And remove_breakpoint() will get called

assuming that _unregister() will find the same vma with the probed insn. But
as I said, the application can munmap the probed page/vma.

No?

> > Also. delayed_uprobe_add() should check the list and avoid duplicates. Otherwise the
> > trivial
> >
> > 	for (;;)
> > 		munmap(mmap(uprobed_file));
> >
> > will eat the memory until uprobe is unregistered.
>
>
> I'm already calling delayed_uprobe_check(uprobe, mm) from delayed_uprobe_add().

Oops ;)

Oleg.
