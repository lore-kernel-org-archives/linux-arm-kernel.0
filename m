From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 13 Aug 2018 13:23:25 +0200
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180813100327.GF44470@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <20180813100327.GF44470@linux.vnet.ibm.com>
Message-ID: <20180813112324.GA28360@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13, Srikar Dronamraju wrote:
>
> > +
> > +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> > +{
> > +	struct delayed_uprobe *du;
> > +
> > +	if (delayed_uprobe_check(uprobe, mm))
> > +		return 0;
> > +
> > +	du = kzalloc(sizeof(*du), GFP_KERNEL);
> > +	if (!du)
> > +		return -ENOMEM;
> > +
> > +	du->uprobe = uprobe;
> > +	du->mm = mm;
> > +	list_add(&du->list, &delayed_uprobe_list);
> > +	return 0;
> > +}
> > +
>
> Should we keep the delayed uprobe list per mm?
> That way we could avoid the global mutex lock.
> And the list to traverse would also be small.

Plus uprobe_mmap() could simply check list_empty(mm->delayed_list) before
the costly delayed_uprobe_install().

Yes, I mentioned this too. But then I suggested to not do this in the initial
version to make it more simple.

Hopefully we can do this later, but note that this conflicts with the change
in put_uprobe() you commented below.

> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -	if (atomic_dec_and_test(&uprobe->ref))
> > +	if (atomic_dec_and_test(&uprobe->ref)) {
> > +		/*
> > +		 * If application munmap(exec_vma) before uprobe_unregister()
> > +		 * gets called, we don't get a chance to remove uprobe from
> > +		 * delayed_uprobe_list in remove_breakpoint(). Do it here.
> > +		 */
> > +		delayed_uprobe_remove(uprobe, NULL);
>
> I am not getting this part. If unmap happens before unregister,
> why cant we use uprobe_munmap?

How? I mean what exactly can we do in uprobe_munmap() ? Firstly, we will need
to restore build_probe_list/list_for_each_entry_safe(pending_list) in
uprobe_munmap() and this is not nice performance-wise. Then what?

We don't even know if the caller is actually munmap(), it can be vma_adjust()
and in the latter case we can't do delayed_uprobe_remove(uprobe, mm).

Perhaps we can use uprobe_munmap() to cleanup the delayed_uprobe_list, but this
doesn't look simple to me.

In fact I think that we should simply kill uprobe_munmap().

Oleg.
