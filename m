From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 15 Jul 2012 22:49:35 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20479.59525.385001.544046@ipc1.ka-ro>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
Message-ID: <20120715144935.GB2429@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 11:21:09AM +0200, Lothar Wa?mann wrote:
> Shawn Guo writes:
> > Hi Lothar,
> > 
> > On Mon, Jul 09, 2012 at 03:04:53PM +0200, Lothar Wa?mann wrote:
> > > This doesn't work at least because the pins that are used for PHY
> > > strap options need to be reconfigured for their FEC functionality
> > > after releasing the PHY reset. But even after adding the missing
> > > reconfiguration the ethernet PHY does not work.
> > > 
> > Can you please test the branch below to see if ethernet PHY works?
> > 
> No. See bootlog below.
> 
Thanks for testing, Lothar.  But from the boot log below, the kernel
did a non-DT boot rather than a boot from device tree.  More on this
below.  But does that mean ethernet PHY does not work even on non-DT
kernel right now?

> The following patch is required for the kernel to build:

Yes, Marek has reported that.  But I'm not so fond of fixing it right
away like that, since mxs_defconfig has it enabled with board file
support and does not expose the problem.

Instead, I would really like to remove those board files with equivalent
device tree support, and build in mach-mxs.c and ocotp.c all the time.

> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -82,6 +82,7 @@ config MODULE_TX28
>  	select MXS_HAVE_PLATFORM_MXS_MMC
>  	select MXS_HAVE_PLATFORM_MXS_PWM
>  	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
> +	select MXS_OCOTP
>  
>  config MODULE_M28
>  	bool
> 
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt/tx28
> > 
> > I hope I have addressed the issue with pin configuration there.
> > But I'm not sure if "enet_out" clock needs to be enabled on tx28.
> > I have enabled it in the code above.  You need to remove
> > enable_clk_enet_out call from tx28_init, if it's not needed.
> > 
> ENET_CLK is required on the module.
> 
Ok, got it.

> ## Booting kernel from Legacy Image at 40100000 ...
>    Image Name:   Linux-3.5.0-rc6-next-20120712-ka
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2277008 Bytes = 2.2 MiB
>    Load Address: 40008000
>    Entry Point:  40008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0
> Linux version 3.5.0-rc6-next-20120712-karo+ (lothar at ipc1) (gcc version 4.5.3 (GCC) ) #5 PREEMPT Fri Jul 13 11:06
> :19 CEST 2012
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Ka-Ro electronics TX28 module

This line tells that the kernel is doing a traditional non-DT boot.
If the kernel boots from device tree, you should see the following line
instead.

Machine: Freescale i.MX28 (Device Tree), model: Ka-Ro electronics TX28 module

I'm not sure if you have your bootloader passes dtb to kernel or use
append-dtb approach.  In the later case, here are the brief
instructions.

- Enable CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
- Build kernel
- make ARCH=arm imx28-tx28.dtb
- cat arch/arm/boot/zImage arch/arm/boot/imx28-tx28.dtb > arch/arm/boot/zImage_dtb
- Boot zImage_dtb like you boot zImage as usual

-- 
Regards,
Shawn
