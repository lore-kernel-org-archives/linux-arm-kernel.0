From: jilin@nvidia.com (Jim Lin)
Date: Fri, 20 Dec 2013 10:59:44 +0800
Subject: [PATCH 10/10] ARM: tegra: Enable USB on Venice2
In-Reply-To: <52B36720.8080205@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-11-git-send-email-treding@nvidia.com>
 <52B36720.8080205@wwwdotorg.org>
Message-ID: <1387508384.26603.42.camel@jilin-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

About USB1 issue, for chips after Tegra30 (including Tegra30), BIASPD is
controlled by USB1 controller.
In ehci-tegra.c probe phase, we assert reset and deassert reset on
controller clock.
If initializing sequence follows USB1 and then USB2, we are safe.
If initializing sequence follows USB2 and then USB1, then in
phy-tegra-usb.c a counter utmip_pad_count which has been increased for
USB2 will prevent UTMIP_BIASPD from being cleared while initializing for
USB1 controller (UTMIP_BIASPD will be set again after asserting and
deasserting reset on USB1 controller clock in ehci-tegra.c probe for
USB1 controller).

There are several ways to fix.
The local workaround I use is as following in phy-tegra-usb.c.

static void utmip_pad_power_on(struct tegra_usb_phy *phy)
{
	unsigned long val, flags;
	void __iomem *base = phy->pad_regs;
	struct tegra_utmip_config *config = phy->config;

	clk_prepare_enable(phy->pad_clk);

	spin_lock_irqsave(&utmip_pad_lock, flags);

	val = readl(base + UTMIP_BIAS_CFG0);
	if ((utmip_pad_count++ == 0) || (val & UTMIP_BIASPD)) {
		val &= ~(UTMIP_OTGPD | UTMIP_BIASPD)

On Fri, 2013-12-20 at 05:37 +0800, Stephen Warren wrote:
> On 12/19/2013 09:06 AM, Thierry Reding wrote:
> > USB1 and USB3 are routed to two external connectors, while USB2 is used
> > for the integrated webcam.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Note: connecting a USB mouse to USB3 works properly and lsusb also detects
> > the integrated webcam, though I haven't tested whether the camera actually
> > works.
> > 
> > USB1 doesn't seem to work, but I suspect that might just be because it's
> > used for recovery mode and we can't switch it around at runtime yet.
> 
> The two regulators you added don't actually hook up to any GPIOs for
> control of VBUS, so perhaps this isn't surprising. The regulators added
> for VBUS control by Laxman's patch (which I already applied) *do* have
> some gpio properties. However, testing indicates:
> 
> * With Laxman's patch applied, and your patch 1/10 not applied since
> it's a duplicate, this patch doesn't work, i.e. I see no USB devices.
> 
> * With Laxman's patch reverted and your patch 1/10 replacing it, I do
> see USB devices, and they work. However, then we're not actually
> controlling VBUS, so USB1 doesn't work.
> 
> Can you please rebase this whole series on the latest Tegra for-3.14/dt
> and sort out the issues? Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--nvpublic 
