From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 11 Apr 2012 10:38:50 -0700
Subject: [PATCH v2 3/4] ARM: mm: truncate memory banks to fit in 4GB
 space for classic MMU
In-Reply-To: <20120411162730.GB24211@n2100.arm.linux.org.uk>
References: <1334154639-13869-1-git-send-email-will.deacon@arm.com>
 <1334154639-13869-4-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1204111038130.16314@xanadu.home>
 <20120411155232.GA24211@n2100.arm.linux.org.uk>
 <20120411162730.GB24211@n2100.arm.linux.org.uk>
Message-ID: <20120411173849.GA8114@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 05:27:30PM +0100, Russell King - ARM Linux wrote:
> Of course, what prevents us doing that conversion sanely is all the
> shite platform code doing crap stuff like this:
> 
> arch/arm/mach-msm/board-halibut.c:      mi->bank[0].start = PHYS_OFFSET;
> arch/arm/mach-msm/board-halibut.c:      mi->bank[0].size = (101*1024*1024);
> 
> which I went through everything a few years ago and eliminated all this
> crap.  It's back now.  Sod it, we'll stick with the current 4GiB limited
> way as long as we have platform maintainers who do this kind of crappy
> hack.
> 
> While here, I propose to delete these:
> 
> arch/arm/mach-msm/board-mahimahi.c:     mi->bank[0].start = PHYS_OFFSET;
> arch/arm/mach-msm/board-mahimahi.c:     mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
> arch/arm/mach-msm/board-mahimahi.c:     mi->bank[0].size = (219*1024*1024);
> arch/arm/mach-msm/board-mahimahi.c:     mi->bank[1].start = MSM_HIGHMEM_BASE;
> arch/arm/mach-msm/board-mahimahi.c:     mi->bank[1].node = PHYS_TO_NID(MSM_HIGHMEM_BASE);
> arch/arm/mach-msm/board-mahimahi.c:     mi->bank[1].size = MSM_HIGHMEM_SIZE;
> arch/arm/mach-msm/board-sapphire.c:     mi->bank[0].start = PHYS_OFFSET;
> arch/arm/mach-msm/board-sapphire.c:     mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
> arch/arm/mach-msm/board-sapphire.c:             mi->bank[0].size = (84*1024*1024);
> arch/arm/mach-msm/board-sapphire.c:             mi->bank[0].size = (101*1024*1024);
> arch/arm/mach-msm/board-sapphire.c:             mi->bank[0].size = (101*1024*1024);
> 
> because they haven't been buildable since 7th May 2010 (that's 23 months
> ago), and no one has reported any build errors with them.  They're only
> receiving updates from other sweeps and nothing more.  This all means no
> one is even attempting to build this code.  It's pointless having
> unbuildable code in the kernel, and it's nothing more than a useless
> maintanence burden.


It can't be that hard to fix.. I'll look into cleaning it up.

Daniel
