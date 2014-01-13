From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Jan 2014 16:20:12 +0100
Subject: [PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM
In-Reply-To: <20140113134813.GX15937@n2100.arm.linux.org.uk>
References: <E1Vyl3Q-0005Lt-Lo@rmk-PC.arm.linux.org.uk>
 <CAOh2x==c+O9SwaeCOOSDkFUgSYnY=1Y-7C=Ti_5ceiyUUiQw1Q@mail.gmail.com>
 <3792319.Wf518ByjFs@wuerfel>
 <20140113115208.GA22313@ulmo.nvidia.com>
 <20140113134813.GX15937@n2100.arm.linux.org.uk>
Message-ID: <20140113152011.GA15107@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:48:13PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 13, 2014 at 12:52:10PM +0100, Thierry Reding wrote:
> > On Wed, Jan 08, 2014 at 09:20:10AM +0100, Arnd Bergmann wrote:
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -3,7 +3,7 @@ config ARCH_MXC
> > >         select ARCH_REQUIRE_GPIOLIB
> > >         select ARM_CPU_SUSPEND if PM
> > >         select ARM_PATCH_PHYS_VIRT
> > > -       select AUTO_ZRELADDR if !ZBOOT_ROM
> > > +       select AUTO_ZRELADDR
> > >         select CLKSRC_MMIO
> > >         select COMMON_CLK
> > >         select GENERIC_ALLOCATOR
> > 
> > Hi Arnd,
> > 
> > I haven't seen this go into linux-next yet. Do you plan on sending a
> > patch for this?
> 
> Maybe someone should respond to this comment from Arnd:
> 
> | On second thought, we should just remove the 'select AUTO_ZRELADDR' from
> | ARCH_MXC and everything that is multiplatform enabled, since it's already
> | selected by ARCH_MULTIPLATFORM.
> 
> which I think is the right way to go here.  The ARCH_MXC option is
> hidden when multiplatform is not enabled.  When it is enabled,
> AUTO_ZRELADDR is selected by the multiplatform option.  So having a
> "select AUTO_ZRELADDR" of any kind under ARCH_MXC is entirely
> redundant.

It looks like ARCH_MXC is the only one that matches Arnd's requirements.
All other platforms that select AUTO_ZRELADDR seem to not support multi-
platform.

Below is a patch to remove the line completely. Shall I post that to the
patch tracker?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-Remove-redundant-select-AUTO_ZRELADDR.patch
Type: text/x-diff
Size: 1302 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/82d5820b/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/82d5820b/attachment-0001.sig>
