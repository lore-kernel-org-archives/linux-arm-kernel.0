From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jul 2014 14:12:24 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <6510599.Qoc205T3v7@wuerfel>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140717102425.34fe0181@free-electrons.com>
 <20140717083342.GS21766@n2100.arm.linux.org.uk> <6510599.Qoc205T3v7@wuerfel>
Message-ID: <20140717131224.GW21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 02:39:42PM +0200, Arnd Bergmann wrote:
> On Thursday 17 July 2014 09:33:42 Russell King - ARM Linux wrote:
> > No - the problem is that we're running from the page table in question
> > with global mappings, and we need to switch all these mappings, including
> > the ones we're currently using to execute from.
> > 
> > We can't even create a new page table and switch to it because the
> > mappings in question are global mappings.
> > 
> > The only way to do that safely from an architectural point of view would
> > be to turn the MMU off, and drop back to assembly code to change the
> > page tables, and re-enable the MMU.  For something as obscure as Marvell's
> > coherency stuff, that's not something I want to see in core code.
> 
> Is this different from what we do in the LPAE version of
> early_paging_init()? That code already adjusts all the page
> table entries on a per-platform setting and should be very
> easy to extend for a modified procinfo->__cpu_mm_mmu_flags,
> and possibly able to extend for traditional (non-LPAE)
> page tables without a lot of duplication.

I'm going to have to profess no knowledge of how the LPAE stuff works.
LPAE is something I can't run, and something that I was not involved
in its creation.  Therefore, I know very little about it and zero
experience thereof.

>From a glance over that function, I think that is unsafe for all the
reasons I've stated.  However, I'll pass this over to Will Deacon
to comment further on.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
