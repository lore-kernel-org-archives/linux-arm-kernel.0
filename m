From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 28 Nov 2012 14:02:27 +0100
Subject: [PATCH v8 1/2] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <CAD6zSYO77GTqVux7B0wDsrj0+332-jU0ivqKY7ExRSKZuHYjDQ@mail.gmail.com>
References: <1352888836-17192-1-git-send-email-p.paneri@samsung.com>
 <1465375.Xr1CJFmx11@flatron>
 <CAD6zSYO77GTqVux7B0wDsrj0+332-jU0ivqKY7ExRSKZuHYjDQ@mail.gmail.com>
Message-ID: <1843164.6kmf7C00lC@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Praveen,

On Friday 23 of November 2012 09:56:37 Praveen Paneri wrote:
> >> +static void samsung_usbphy_enable(struct samsung_usbphy *sphy)
> >> +{
> >> +     void __iomem *regs = sphy->regs;
> >> +     u32 phypwr;
> >> +     u32 phyclk;
> >> +     u32 rstcon;
> >> +
> >> +     /* set clock frequency for PLL */
> >> +     phyclk = sphy->ref_clk_freq;
> >> +     phypwr = readl(regs + SAMSUNG_PHYPWR);
> >> +     rstcon = readl(regs + SAMSUNG_RSTCON);
> >> +
> >> +     switch (sphy->cpu_type) {
> >> +     case TYPE_S3C64XX:
> >> +             phyclk &= ~PHYCLK_COMMON_ON_N;
> >> +             phypwr &= ~PHYPWR_NORMAL_MASK;
> >> +             rstcon |= RSTCON_SWRST;
> >> +             break;
> >> +     case TYPE_EXYNOS4210:
> >> +             phypwr &= ~PHYPWR_NORMAL_MASK_PHY0;
> >> +             rstcon |= RSTCON_SWRST;
> >> +     default:
> >> +             break;
> >> +     }
> >> +
> >> +     writel(phyclk, regs + SAMSUNG_PHYCLK);
> >> +     /* set to normal of PHY0 */
> > 
> > I don't understand this comment.
> 
> Will change it to " Configure PHY0 for normal operation"
> That should be more clear, I suppose.

Yes, much better.

> >> + */
> >> +
> >> +#ifndef __SAMSUNG_USBPHY_PLATFORM_H
> >> +#define __SAMSUNG_USBPHY_PLATFORM_H
> >> +
> >> +/**
> >> + * samsung_usbphy_data - Platform data for USB PHY driver.
> >> + * @pmu_isolation: Function to control usb phy isolation in PMU.
> >> + */
> >> +struct samsung_usbphy_data {
> >> +     void (*pmu_isolation)(int on);
> > 
> > I believe this should be named in a generic way. This is called PMU
> > isolation on Exynos SoCs, but on S3C64xx it's USB PHY mask.
> 
> Yes! I am aware of it. The fact that this ( MASK or ISOLATION) has
> always been part of the PMU, pmu_isolation seems quite generic that
> way. Though you can suggest a better name.

What do you think about set_isolation(int on) or power_isolation(int on)?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
