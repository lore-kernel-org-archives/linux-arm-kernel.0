From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 15 Dec 2015 21:50:13 +0300
Subject: [PATCH v5 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <87a8pbio2u.fsf@belgarion.home>
References: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
 <7496839.vMjVcqPe8Q@wuerfel> <1450197727.21989.9.camel@gmail.com>
 <1843454.zCnLJtF7B6@wuerfel> <1450200281.21989.24.camel@gmail.com>
 <87a8pbio2u.fsf@belgarion.home>
Message-ID: <1450205413.21989.44.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-15 at 19:06 +0100, Robert Jarzmik wrote:
>?
> > > Maybe we can have a pxa_defconfig file that enables lots of boards
> > > and then we remove the individual configs? We don't have to remove
> > > them all at once, but it would make me very happy if we could at
> > > least kill off some of the ones that are not used regularly.
> Yeah, I'd be happy too, that would simplify also my life.
> 
> Actually I was thinking of 2 defconfigs :
> ?- one for platform_data based boards pxa2xx
> ?- one for DT only boards pxa2xx

I sincerely hope that dealing with ancient platform_data defconfigs is
out of the scope this patch.

> > lp8x4x seems to be the first pxa board which requires DT.
> Most probably AFAIK.
> 
> > We can create pxa27x-dt_defconfig which selects:
> > 1. PXA27X_DT
> > 2. PXA_FB and 8250_PXA to enable console
> > 3. MMC, MMC_PXA and EXT4_FS to enable boot from MMC
> If you put MMC_PXA, one can argue why not any MTD device used on pxa
> devices,
> such as pxa2xx-flash or docg3/docg4, etc ... I won't argue, I'm just
> pondering
> about the right choice.

Great point. We should enable MTD for sure. There is no PXA-specific MTD
drivers, however. That's why MTD failed the grep test.

> > 4. all optional pxa stuff as modules
> > 5. all stuff on supported pxa boards as modules
> 
> > If #5 is extended when support for new boards is added, it should be
> > possible to run any supported pxa27x board with pxa27x_defconfig.
> 
> I'm very eager to see a patch on that. I can feed my Jenkins with it,
> it would
> greatly help me catch issues earlier. Moreover it would for free test
> it on
> lubbock, mainstone and mioa701. If there was one also for pxa3xx, I
> would launch
> it on zylonite cm-x300 ... (that's a bonus, I know :))
> 

Updated plan:
1. MACH_PXA27X_DT
2. PXA_FB and 8250_PXA to enable console
3. MMC, MMC_PXA and EXT4_FS to enable boot from MMC
3.1. MTD, MTD_CFI, MTD_PHYSMAP_OF and JFFS2_FS to enable boot from MTD
4. all optional pxa stuff as modules
5. all stuff on supported pxa boards as modules
6. supported boards should boot the kernel built with
`pxa27x-dt_defconfig` after `make olddefconfig`

It is probably a good idea to put this plan somewhere in Documentation/
and to have a comment about that in the defconfig itself.

Is the plan acceptable?
