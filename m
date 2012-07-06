From: wni@nvidia.com (Wei Ni)
Date: Fri, 6 Jul 2012 11:19:44 +0800
Subject: [PATCH 5/5] ARM: tegra: enable wireless in defconfig
In-Reply-To: <4FF5FC39.3090402@wwwdotorg.org>
References: <1341394488-13169-1-git-send-email-wni@nvidia.com>
 <1341394488-13169-6-git-send-email-wni@nvidia.com>
 <4FF5F20F.2050005@wwwdotorg.org> <2114579.sqTp7XiW3H@ax5200p>
 <4FF5FC39.3090402@wwwdotorg.org>
Message-ID: <1341544784.3484.44.camel@tegra-chromium-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-06 at 04:42 +0800, Stephen Warren wrote:
> On 07/05/2012 02:35 PM, Marc Dietrich wrote:
> > On Thursday 05 July 2012 13:59:11 Stephen Warren wrote:
> >> On 07/04/2012 03:34 AM, Wei Ni wrote:
> >>> New options enabled:
> >>> * WIRELESS: (dependency)
> >>> * CFG80211: (dependency)
> >>> * WLAN: (dependency)
> >>> * BRCMFMAC: wlan driver, enable as module.
> >>>
> >>> diff --git a/arch/arm/configs/tegra_defconfig
> >>> b/arch/arm/configs/tegra_defconfig
> >>>
> >>> +CONFIG_BRCMFMAC=m
> >>
> >> Why does this need to be a module? Everything else in tegra_defconfig is
> >> built-in, and it'd be nice to be consistent here. Built-in makes
> >> net-booting new kernels from U-Boot much easier, since there aren't any
> >> modules to copy.
> > 
> > network drivers (especially wifi) are often modules because they need firmwares. 
> 
> So I certainly see that WiFi modules may need firmware.
> 
> But I don't see why that should imply they must be modules; they should
> be able to defer their firmware loading until the firmware is available.

The wifi driver will try to load the firmware form the filesystem in its
initialization. In some board, the filesystem is on the SD/MMC card, and
if the wifi card is initialized before that SD/MMC card, it can't read
the filesystem and can't get the firmware, since the SD/MMC card doesn't
be initialized yet. then the wifi driver's initialization will be
failed.
So the wifi driver are often built as modules.

> 
> > I'm not sure if the kernel can compile them in every case. Our RT2x00 is an 
> > example (which also needs a defconfig entry btw) but brcmfmac also needs it as 
> > modinfo shows. Beside that, I don't think you want to netboot using wifi and u-
> > boot because this needs a huge wireless framework which u-boot doesn't have.
> 
> I net-boot using a USB wired Ethernet adapter. The issue isn't that I
> want to use wireless from U-Boot, but rather than it's easy to download
> the zImage and .dtb using U-Boot since they're just copied to RAM, but
> getting a bunch of modules into a filesystem on the target before
> booting the kernel is more painful.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
