From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 17 Feb 2013 11:03:35 +0800
Subject: [PATCH 2/2] of: use platform_device_add
In-Reply-To: <1358473200-17886-2-git-send-email-grant.likely@secretlab.ca>
References: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
 <1358473200-17886-2-git-send-email-grant.likely@secretlab.ca>
Message-ID: <20130217030331.GA15048@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 01:40:00AM +0000, Grant Likely wrote:
> This allows platform_device_add a chance to call insert_resource on all
> of the resources from OF. At a minimum this fills in proc/iomem and
> presumably makes resource tracking and conflict detection work better.
> However, it has the side effect of moving all OF generated platform
> devices from /sys/devices to /sys/devices/platform/. It /shouldn't/
> break userspace because userspace is not supposed to depend on the full
> path (because userspace always does what it is supposed to, right?).
> 
> This may cause breakage if either:
> 1) any two nodes in a given device tree have overlapping & staggered
>    regions (ie. 0x80..0xbf and 0xa0..0xdf; where one is not contained
>    within the other). In this case one of the devices will fail to
>    register and an exception will be needed in platform_device_add() to
>    complain but not fail.

Grant,

The patch introduce a regression on imx6q boot.  The IOMUXC block on
imx6q is special.  It acts not only a pin controller but also a system
controller with a bunch of system level registers in there.  That's why
we currently have the following two nodes in imx6q device tree with the
same start "reg" address, which work with drivers/mfd/syscon.c and
drivers/pinctrl/pinctrl-imx6q.c respectively.

	gpr: iomuxc-gpr at 020e0000 {
		compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
		reg = <0x020e0000 0x38>;
	};

	iomuxc: iomuxc at 020e0000 {
		compatible = "fsl,imx6q-iomuxc";
		reg = <0x020e0000 0x4000>;
	};

With the patch in place, pinctrl-imx6q fails to register like below.

syscon 20e0000.iomuxc: syscon regmap start 0x20e0000 end 0x20e3fff registered
imx6q-pinctrl 20e0000.iomuxc: can't request region for resource [mem 0x020e0000-0x020e3fff]
imx6q-pinctrl: probe of 20e0000.iomuxc failed with error -16

Shawn

> 2) any device calls request_mem_region() on a region larger than
>    specified in the device tree. In this case the device node may be
>    wrong, or the driver is overreaching. In either case I'd like to know
>    about any problems and fix them.
