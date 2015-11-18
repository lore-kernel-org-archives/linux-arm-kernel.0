From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Nov 2015 18:04:35 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <564CB1DA.4090304@arm.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
Message-ID: <20151118180434.GB13355@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >We also need to figure out what's happening with the code as it is.
> 
> Well, I'm suspect what is happening is that there are conflicting
> TLB's hanging around, one for a cont range that is overlapping a stale
> non cont one. This sort of implies that this has been happening all
> along, AKA RO regions were being "lazy" activated if you will. Its
> only on a core that aborts when it detects that (which i assume
> requires differing size entries for this core) does it cause problems.

I suspect that we may have believed that the TLB maintenance at the end
of paging_init was sufficient, as we evidently  id not consider TLB
conflicts.

> The break-before-make issue, seems like it won't cause a big problem
> here as long as there is some way to assure valid TLBs before the
> update, and then assure they are cleared following it.

If at any instant in time you have a valid TLB entry for an address, and
the page tables hold a value that would give rise to a conflicting TLB
entry, you can encounter a TLB conflict abort.

It's a race against the hardware.

> Hence the overly aggressive change works because it
> flushes following every cont block update. Which would bother me
> more if the code were run more than once per boot (or in the future
> per module load/unload if someone gets around to updating the no
> execute reliably).

You're racing against other parts of the CPU (the page table walker(s),
I-caches, etc). The flushing only minimises the window for a race, and
does not prevent the race from being possible.

Given that the envelope is constantly pushing forward w.r.t. how
aggressive CPUs may be in this area, we need to fix the issue by
reasoning against what the architecture guarantees us.

We're almost certainly going to have to revisit this code in future, and
sprinkling TLB maintenance over it will only make it harder to reason
about in future.

Mark.
