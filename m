From: martinwguy@gmail.com (Martin Guy)
Date: Sat, 20 Mar 2010 18:07:50 +0000
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
Message-ID: <56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/18/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> Added a new function: ep93xx_chip_revision() which reads chip revision from the
>  sysconfig register.
>
>  diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>  index 90fb591..07572bb 100644
>  --- a/arch/arm/mach-ep93xx/core.c
>  +++ b/arch/arm/mach-ep93xx/core.c
>  @@ -222,6 +222,20 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
>   }
>   EXPORT_SYMBOL(ep93xx_devcfg_set_clear);
>
>  +/**
>  + * ep93xx_chip_revision() - returns the EP93xx chip revision
>  + *
>  + * See <mach/platform.h> for more information.
>  + */
>  +unsigned int ep93xx_chip_revision(void)
>  +{
>  +       unsigned int v;
>  +
>  +       v = __raw_readl(EP93XX_SYSCON_SYSCFG);
>  +       v &= EP93XX_SYSCON_SYSCFG_REV_MASK;
>  +       v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
>  +       return v;
>  +}

  The chip revision is normally placed in the global unsigned int
"system_rev", which is also reported by /proc/cpuinfo.
  It normally seems to be set from the atags passed by the bootloader
but uboot on this platform doesn't provide that, so it remains 0.
  The same applies to the very similar variables system_serial_low and
system_serial_high (which also remain 0 on this u-boot platform).
Shall we also set these from the hardware on ep93xx during thus giving
them non-zero values in /proc/cpuinfo too?
  As to where...? The other platforms that set these variables from
hardware queries do it in the board-specific files' MACHINE_START
function, but we'd have to do this in every board file, or have some
comon routine and modify every mach-ep93xx board file. The only common
routine all ep93xx board inits seem to have is ep93xx_init_devices.
This seems the least-resistance place to do this, but has nothing to
do with initlalizing devices of course. Is making another function in
toe core file and modifying every board's init function preferable?

Also, I have the simpler
    system_rev = *((unsigned int *)EP93XX_SYSCON_CHIP_ID) >> 28;
    system_serial_low = *((unsigned int *)EP93XX_SECURITY_UNIQID);
but maybe explicit readl and use of long defines are preferable.

Sorry, I'm not familiar with linux kernel best practice...

    M
