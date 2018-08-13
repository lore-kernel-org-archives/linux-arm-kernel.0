From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 13 Aug 2018 13:50:19 +0200
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
Message-ID: <20180813115019.GB28360@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13, Ravi Bangoria wrote:
>
> On 08/11/2018 01:27 PM, Song Liu wrote:
> >> +
> >> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
> >> +{
> >> +       if (!du)
> >> +               return;
> > Do we really need this check?
>
> Not necessary though, but I would still like to keep it for a safety.

Heh. I tried to ignore all minor problems in this version, but now that Song
mentioned this unnecessary check...

Personally I really dislike the checks like this one.

	- It can confuse the reader who will try to understand the purpose

	- it can hide a bug if delayed_uprobe_delete(du) is actually called
	  with du == NULL.

IMO, you should either remove it and let the kernel crash (to notice the
problem), or turn it into

	if (WARN_ON(!du))
		return;

which is self-documented and reports the problem without kernel crash.

> >> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
> >> +
> >> +       if (rc_vma) {
> >> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
> >> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
> >> +
> >> +               if (is_register)
> >> +                       return ret;
> >> +       }
> > Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
> > function is a little confusing (at least for me). How about we always use
> > delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?
>
>
> No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
> between uprobe_register() and process creation.

Yes.

But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
hook and avoid delayed_uprobe_install() in uprobe_mmap().

Afaics, the really problematic case is dlopen() which can race with _register()
too, right?

Oleg.
