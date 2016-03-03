From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 14:05:33 +0100
Subject: [rtc-linux] Re: [RFC 09/15] media: platform: Add missing
 MFD_SYSCON dependency on HAS_IOMEM
In-Reply-To: <CAJKOXPe50ira_Qqy7qJ5H_PHa8B_xOinCK6JkncXFYn_eaQFfg@mail.gmail.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <2181866.k24LVvUjTs@wuerfel>
 <CAJKOXPe50ira_Qqy7qJ5H_PHa8B_xOinCK6JkncXFYn_eaQFfg@mail.gmail.com>
Message-ID: <13054519.5feSCc5dgv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 21:40:23 Krzysztof Kozlowski wrote:
> >>         select MFD_SYSCON
> >> diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
> >> index 57d42c6172c5..c4317b99d257 100644
> >> --- a/drivers/media/platform/exynos4-is/Kconfig
> >> +++ b/drivers/media/platform/exynos4-is/Kconfig
> >> @@ -17,6 +17,7 @@ config VIDEO_S5P_FIMC
> >>         tristate "S5P/EXYNOS4 FIMC/CAMIF camera interface driver"
> >>         depends on I2C
> >>         depends on HAS_DMA
> >> +       depends on HAS_IOMEM    # For MFD_SYSCON
> >>         select VIDEOBUF2_DMA_CONTIG
> >>         select V4L2_MEM2MEM_DEV
> >
> > This  is guarded by HAS_DMA, which implies HAS_IOMEM afaik.
> 
> Looking at Kconfigs - no, it is not implied (or am I missing
> something)... and sometimes dependency on HAS_IOMEM is next to
> HAS_DMA.
> 
> 

Ah, you are right: UML has no DMA and no IOMEM, but s390 can
have IOMEM (if PCI is enabled) and always sets HAS_DMA.

In practice, I think the HAS_DMA symbol is not as well-defined
as it should be, it basically refers to the presence of the dma-mapping.h
API, and that only really makes sense when you also have IOMEM,
so there might be an implied dependency between the two, but it's
not enforced or actually true.

	Arnd
