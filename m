From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Fri, 20 Nov 2015 02:09:48 +0100
Subject: [PATCH] ARM: sunxi: Re-enable SID driver in sunxi_defconfig
In-Reply-To: <20151119234331.GT32142@lukather>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447969715.1730.5.camel@silentcreek.de> <20151119234331.GT32142@lukather>
Message-ID: <1447981788.1404.23.camel@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, sent out the reply first to Maxime only and forgot to include the
rest of the bunch. So, here we go again...


Hi Maxime,

Am Freitag, den 20.11.2015, 00:43 +0100 schrieb Maxime Ripard:
> Hi,
> 
> On Thu, Nov 19, 2015 at 10:48:35PM +0100, Timo Sigurdsson wrote:
> > Hi Maxime,
> > Hi Chen-Yu,
> > 
> > Am Dienstag, den 17.11.2015, 02:42 +0100 schrieb Timo Sigurdsson:
> > > Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the
nvmem
> > > framework") moved the the sunxi SID driver to a new framework, but
left
> > > sunxi_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
> > > instead of the new symbold NVMEM_SUNXI_SID. Hence, re-enable the
driver
> > > in sunxi_defconfig.
> > > 
> > > While at it, clean up sunxi_defconfig by generating a fresh file
via
> > >   make sunxi_defconfig
> > >   make savedefconfig
> > > While this moves around a few lines and removes unnecessary
symbols,
> > > it doesn't introduce any functional changes.
> > > 
> > > Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> > > 
> > > diff --git a/arch/arm/configs/sunxi_defconfig
b/arch/arm/configs/sunxi_defconfig
> > > index 3c36e16..904ea52 100644
> > > --- a/arch/arm/configs/sunxi_defconfig
> > > +++ b/arch/arm/configs/sunxi_defconfig
> > > @@ -11,14 +11,12 @@ CONFIG_SMP=y
> > >  CONFIG_NR_CPUS=8
> > >  CONFIG_AEABI=y
> > >  CONFIG_HIGHMEM=y
> > > -CONFIG_HIGHPTE=y
> > >  CONFIG_ARM_APPENDED_DTB=y
> > >  CONFIG_ARM_ATAG_DTB_COMPAT=y
> > >  CONFIG_CPU_FREQ=y
> > >  CONFIG_CPUFREQ_DT=y
> > >  CONFIG_VFP=y
> > >  CONFIG_NEON=y
> > > -CONFIG_PM=y
> > >  CONFIG_NET=y
> > >  CONFIG_PACKET=y
> > >  CONFIG_UNIX=y
> > > @@ -37,7 +35,6 @@ CONFIG_CAN_SUN4I=y
> > >  # CONFIG_WIRELESS is not set
> > >  CONFIG_DEVTMPFS=y
> > >  CONFIG_DEVTMPFS_MOUNT=y
> > > -CONFIG_EEPROM_SUNXI_SID=y
> > >  CONFIG_BLK_DEV_SD=y
> > >  CONFIG_ATA=y
> > >  CONFIG_AHCI_SUNXI=y
> > > @@ -63,11 +60,10 @@ CONFIG_STMMAC_ETH=y
> > >  # CONFIG_INPUT_MOUSEDEV is not set
> > >  # CONFIG_INPUT_KEYBOARD is not set
> > >  # CONFIG_INPUT_MOUSE is not set
> > > -CONFIG_INPUT_MISC=y
> > > -CONFIG_INPUT_AXP20X_PEK=y
> > >  CONFIG_INPUT_TOUCHSCREEN=y
> > > -CONFIG_KEYBOARD_SUN4I_LRADC=y
> > >  CONFIG_TOUCHSCREEN_SUN4I=y
> > > +CONFIG_INPUT_MISC=y
> > > +CONFIG_INPUT_AXP20X_PEK=y
> > >  CONFIG_SERIAL_8250=y
> > >  CONFIG_SERIAL_8250_CONSOLE=y
> > >  CONFIG_SERIAL_8250_NR_UARTS=8
> > > @@ -123,6 +119,8 @@ CONFIG_PWM=y
> > >  CONFIG_PWM_SUN4I=y
> > >  CONFIG_PHY_SUN4I_USB=y
> > >  CONFIG_PHY_SUN9I_USB=y
> > > +CONFIG_NVMEM=y
> > > +CONFIG_NVMEM_SUNXI_SID=y
> > >  CONFIG_EXT4_FS=y
> > >  CONFIG_VFAT_FS=y
> > >  CONFIG_TMPFS=y
> > 
> > Would you also prefer to see this patch split up into two patches
(one
> > for re-enabling the SID driver and one for the extra cleanup of
> > sunxi_defconfg) as I was asked to do for my other patch for
> > multi_v7_defconfig?
> 
> Yes, please do.

Ok.

> 
> Also why CONFIG_PM CONFIG_KEYBOARD_SUN4I_LRADC and CONFIG_HIGHPTE got
> removed ?

CONFIG_HIGHPTE defaults to yes since 4.4-rc1 in arch/arm/Kconfig, so we
don't need it in sunxi_defconfig anymore. CONFIG_PM is already selected
by CONFIG_ARCH_MULTI_V7, so also no need to set that explicitly.

What's interesting is CONFIG_KEYBOARD_SUN4I_LRADC, because that actually
does _NOT_ get enabled by sunxi_defconfig. I didn't notice earlier,
because before and after my patch, the resulting .config was identical.

The problem with CONFIG_KEYBOARD_SUN4I_LRADC is that keyboard support is
explicitly disabled in sunxi_defconfig which is why
CONFIG_KEYBOARD_SUN4I_LRADC is simply ignored.
So, we need to remove the line
# CONFIG_INPUT_KEYBOARD is not set
in order to actually have CONFIG_KEYBOARD_SUN4I_LRADC enabled.

I'll write another patch for it.

Regards,

Timo
> 
> Thanks,
> Maxime
> 
