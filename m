From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:25:53 +0000
Subject: [PATCH 6/8] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE86172C@HQMAIL01.nvidia.com>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-7-git-send-email-alan@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE86172C@HQMAIL01.nvidia.com>
Message-ID: <201203012025.53560.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Stephen Warren wrote:
> Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The USB_ULPI driver is selected by tegra, but can only be
> > built if at least one of USB or USB_GADGET is enabled.
> > The kernel fails to link if both are off.
> 
> > diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> ...
> > @@ -10,6 +10,7 @@ config ARCH_TEGRA_2x_SOC
> ...
> > +	select USB_GADGET if USB_SUPPORT && !USB
> 
> I don't believe the Tegra USB driver supports gadget mode at present.

ok.

> Would the above be better written as:
> 
>     select USB if USB_SUPPORT

That does not look correct either. There is no reason why USB
can't be disabled with USB_SUPPORT enabled on other platforms.

Maybe it's better to change the 'select USB_ULPI if USB_SUPPORT'
into 'select USB_ULPI if USB' instead? Or maybe just don't select
USB_ULPI to start with and put it into the defconfig instead.

> And this is probably required for Tegra30 too not just Tegra20.

Right. Tegra30 was not there when I did these patches, so it's
probably missing in other places, too.

	Arnd
