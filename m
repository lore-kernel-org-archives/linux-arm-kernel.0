From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 3 Dec 2015 17:55:17 -0500
Subject: [PATCH v4 5/5] ARM: BCM: Add SMP support for Broadcom 4708
In-Reply-To: <20151203210836.GI18950@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
 <1448987049-17041-6-git-send-email-kapilh@broadcom.com>
 <565F0827.4000406@hauke-m.de> <20151203210836.GI18950@broadcom.com>
Message-ID: <20151203225517.GJ18950@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:08:36PM -0500, Jon Mason wrote:
> On Wed, Dec 02, 2015 at 04:03:03PM +0100, Hauke Mehrtens wrote:
> > On 12/01/2015 05:24 PM, Kapil Hali wrote:
> > > From: Jon Mason <jonmason@broadcom.com>
> > > 
> > > Add SMP support for Broadcom's 4708 SoCs.
> > > 
> > > Signed-off-by: Jon Mason <jonmason@broadcom.com>
> > > Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> > > Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
> > > Signed-off-by: Kapil Hali <kapilh@broadcom.com>
> > > ---
> > >  arch/arm/boot/dts/bcm4708.dtsi | 2 ++
> > >  arch/arm/mach-bcm/Kconfig      | 1 +
> > >  arch/arm/mach-bcm/Makefile     | 3 +++
> > >  3 files changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> > > index 31141e8..eed4dd1 100644
> > > --- a/arch/arm/boot/dts/bcm4708.dtsi
> > > +++ b/arch/arm/boot/dts/bcm4708.dtsi
> > > @@ -15,6 +15,7 @@
> > >  	cpus {
> > >  		#address-cells = <1>;
> > >  		#size-cells = <0>;
> > > +		enable-method = "brcm,bcm-nsp-smp";
> > >  
> > >  		cpu at 0 {
> > >  			device_type = "cpu";
> > > @@ -27,6 +28,7 @@
> > >  			device_type = "cpu";
> > >  			compatible = "arm,cortex-a9";
> > >  			next-level-cache = <&L2>;
> > > +			secondary-boot-reg = <0xffff0400>;
> > >  			reg = <0x1>;
> > >  		};
> > >  	};
> > > diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> > > index 83765a0..e85246f 100644
> > > --- a/arch/arm/mach-bcm/Kconfig
> > > +++ b/arch/arm/mach-bcm/Kconfig
> > > @@ -54,6 +54,7 @@ config ARCH_BCM_NSP
> > >  config ARCH_BCM_5301X
> > >  	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
> > >  	select ARCH_BCM_IPROC
> > > +	select HAVE_SMP
> > >  	help
> > >  	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
> > >  
> > 
> > When applying this patch please make sure it is correctly applied this
> > patch causes some problems here:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg462137.html
> > 
> > > diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> > > index 5193a25..7d66515 100644
> > > --- a/arch/arm/mach-bcm/Makefile
> > > +++ b/arch/arm/mach-bcm/Makefile
> > > @@ -43,6 +43,9 @@ obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
> > >  
> > >  # BCM5301X
> > >  obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
> > > +ifeq ($(CONFIG_ARCH_BCM_5301X),y)
> > > +obj-$(CONFIG_SMP)		+= platsmp.o
> > > +endif
> > >  
> > >  # BCM63XXx
> > >  ifeq ($(CONFIG_ARCH_BCM_63XX),y)
> > > 
> > 
> > I am getting this on a Northstar 1 / BCM4708:
> > 
> > [ 0.137634] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > [ 0.143643] Setting up static identity map for 0x82a0 - 0x82d4
> > [ 0.189772] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > [ 0.189861] Brought up 2 CPUs
> > [ 0.198845] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
> > [ 0.205446] CPU: WARNING: CPU(s) started in wrong/inconsistent modes
> > (primary CPU mode 0x13)
> > [ 0.214167] CPU: This may indicate a broken bootloader or firmware.
> > 
> > I assume that this is correct and the bootloader is just broken, it uses
> > this bootloader: "CFE for Foxconn Router version: v1.0.14", I haven't
> > noticed any problems, so it is ok for me.
> 
> On my 4708 SVK, I see the same issue
> 
> [    0.090877] CPU: Testing write buffer coherency: ok
> [    0.091231] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.091377] Setting up static identity map for 0x82a0 - 0x82f8
> [    0.130146] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.130251] Brought up 2 CPUs
> [    0.130323] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
> [    0.130345] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x13)
> [    0.130374] CPU: This may indicate a broken bootloader or firmware.
> 
> I'll investigate it more and see if I can bottom out on the cause.

I looked at previous versions of this patch, and the issue appears to
be present there as well.  I'm not sure why I didn't notice it before.

I don't think "fixing" CFE is an option.  Should we investigate the
possibility of setting the CPU mode of CPU1 in the early_boot of
Linux?

Thanks,
Jon

> 
> Thanks,
> Jon
> 
> 
> > 
> > Hauke
