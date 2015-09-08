From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 08 Sep 2015 12:56:18 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m337yp5gvv.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
Message-ID: <1441709778.13536.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 08.09.2015, 12:45 +0200 schrieb Krzysztof Ha?asa:
> Trying to make some progress... I was missing the etnaviv DRM kernel
> driver. Now I have both IMX and etnaviv drivers, Linux v4.0-stable:
> 
> git://git.pengutronix.de/git/lst/linux.git (etnaviv DRM driver)
> PLL5 DTS patch (enables HDMI with LVDS driver loaded):
> 
> --- a/arch/arm/boot/dts/imx6q-gw54xx.dts
> +++ b/arch/arm/boot/dts/imx6q-gw54xx.dts
> @@ -21,3 +21,11 @@
>  &sata {
>  	status = "okay";
>  };
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};
> +
> 
> also had to apply:
> 
> --- a/drivers/staging/etnaviv/Makefile
> +++ b/drivers/staging/etnaviv/Makefile
> @@ -11,7 +11,6 @@ etnaviv-y := \
>  	etnaviv_gem_submit.o \
>  	etnaviv_gpu.o \
>  	etnaviv_iommu.o \
> -	etnaviv_iommu_v2.o \
>  	etnaviv_mmu.o \
>  	etnaviv_buffer.o
>  
> 
> X.org etc.:
> 	git://github.com/laanwj/etna_viv.git
>         git://ftp.arm.linux.org.uk/~rmk/libdrm-armada.git/
>         git://ftp.arm.linux.org.uk/~rmk/xf86-video-armada.git unstable-devel
> (I can't use master branch of xf86-video-armada.git because it doesn't
> support etnaviv - does it?)
> 
> X log (relevant(?) stuff only):
> 
> [ 18919.848] (II) armada(0): hardware: imx-drm
> [ 18919.923] (--) armada(0): Vivante GC320 GPU revision 5007 (etnaviv) 2d PE2.0
> [ 18919.925] (II) armada(0): [DRI2] Setup complete
> [ 18919.925] (II) armada(0): [DRI2]   DRI driver: etnadrm
> [ 18919.925] (II) armada(0): direct rendering: DRI2 enabled
> [ 18919.925] (II) armada(0): RandR 1.2 enabled, ignore the following RandR disabled message.
> [ 18919.927] (==) armada(0): DPMS enabled
> [ 18919.927] (==) armada(0): hotplug detection enabled
> [ 18919.928] (II) armada(0): etnaviv: Xv: using YUY2 tiled format intermediate YUV target
> [ 18919.971] (EE) AIGLX error: dlopen of /lib/dri/etnadrm_dri.so failed (I don't have this yet)
> [ 18920.072] (II) armada(0): etnaviv: A8 target not supported
> 
> If I try to use pengutronix/etnaviv-4.1-wip branch (etnaviv DRM - for
> v4.2), dmesg contains a lot of:
>  [drm:etnaviv_ioctl_gem_submit [etnaviv]] *ERROR* cmdstream bo has flag ETNA_BO_CMDSTREAM not set
> and it doesn't work. I assume I shouldn't use it yet?
> 
You need changes to the X.Org driver for that to work. I'm currently
working on a new version of the etnaviv-drm driver which will break the
kernel userspace interface another time - hopefully for the last time
now.

I'm almost done and will publish patches for both the kernel and the
X.Org driver today.

> Changing to pengutronix/etnaviv-for-upstream, it works - sort of.
> 
> I now have two Xvideo adapters:
> Adaptor: 0
> Name: Marvell Armada Overlay Video
>  Port: 88
> (which unfortunately doesn't work, the window is black, the XV
> attributes are set to minimums and I can't set them).
> 
> Is it expected?
> 
This is expected, it's the overlay adapter which doesn't really work
with imx-drm yet.

Regards,
Lucas


-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
