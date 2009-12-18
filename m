From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 18 Dec 2009 17:01:29 -0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091217193210.GD362@shareable.org>
References: <20091217175416.9317.66257.stgit@e101986-lin>
	<20091217193210.GD362@shareable.org>
Message-ID: <000101ca8003$be6de210$3b49a630$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jamie Lokier [mailto:jamie at shareable.org]
> Sent: 17 December 2009 19:32

> > To correctly deal with copy-on-write, it also modifies
> > cpu_v7_set_pte_ext to change the mappings to priviliged RO when
> > user RO.
> 
> Does this break ptrace writing to RO pages or anything else?

I believe Catalin has answered this question.

> If it doesn't break anything, seems to me it should always be done
> like that, not conditional on CONFIG_SWP_EMULATE.

I agree this should not really be conditional on CONFIG_SWP_EMULATE, but
since Catalin's revised page table format patches have not been merged,
it felt less contentious to leave that behaviour in place unless real
need to change it existed. I'd be happy to drop the ifndef if that
was preferred.

> Ideally it would report the same errors as userspace accesses, as
> calculated in do_page_fault() and passed to __do_user_fault(), for the
> benefit of programs which distinguish SEGV_MAPERR from SEGV_ACCERR.

Good point - I'm adding this and will be submitting an updated patch
shortly.

> These printks look like an easy local denial of service.  They should
> be rate limited.

Ok, I'll replace them with pr_debug().

/
	Leif
