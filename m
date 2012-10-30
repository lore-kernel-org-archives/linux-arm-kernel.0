From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 30 Oct 2012 09:56:22 +0100
Subject: [PATCH 2/4] ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of
 Exynos4210 SOC
In-Reply-To: <508EBBB6.2090006@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <1351504796-24788-3-git-send-email-b.zolnierkie@samsung.com>
 <508EBBB6.2090006@samsung.com>
Message-ID: <201210300956.23102.b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday 29 October 2012 18:24:06 Kukjin Kim wrote:
> On 10/29/12 10:59, Bartlomiej Zolnierkiewicz wrote:
> > Commit 8214513 ("ARM: EXYNOS: fix address for EXYNOS4 MDMA1")
> > changed EXYNOS specific setup of PL330 DMA engine to use 'non-secure'
> > mdma1 address instead of 'secure' one (from 0x12840000 to 0x12850000)
> > to fix issue with some Exynos4212 SOCs.  Unfortunately it brakes
> > PL330 setup for revision 0 of Exynos4210 SOC (mdma1 device cannot
> > be found at 'non-secure' address):
> >
> > [    0.566245] dma-pl330 dma-pl330.2: PERIPH_ID 0x0, PCELL_ID 0x0 !
> > [    0.566278] dma-pl330: probe of dma-pl330.2 failed with error -22
> >
> > Fix it by using 'secure' mdma1 address on Exynos4210 revision 0 SOC.
> >
> > Cc: Tomasz Figa<t.figa@samsung.com>
> > Cc: Kukjin Kim<kgene.kim@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz<b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> > ---
> >   arch/arm/mach-exynos/dma.c              | 5 ++++-
> >   arch/arm/mach-exynos/include/mach/map.h | 3 ++-
> >   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > +		if (samsung_rev() == EXYNOS4210_REV_0)
> > +			exynos_mdma1_device.res.start = EXYNOS4_PA_S_MDMA1;
> 
> Hi Bart,
> 
> Hmm...above change and adding definition of EXYNOS_PA_S_MDMA1 address 
> can fix the problem you commented on EXYNOS4210 Rev0 without others?...

The problem is affecting only EXYNOS4210 Rev0 and the fix is applied only
for case when soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0,
or did you mean something else?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung Poland R&D Center

> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
