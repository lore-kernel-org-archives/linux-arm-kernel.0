From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Aug 2013 15:51:07 +0800
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
In-Reply-To: <20130823070906.GA2460@b29396-Latitude-E6410>
References: <1376564133-11286-1-git-send-email-b29396@freescale.com>
 <CACxGe6tMm=u1jFKUQ59+cj-rYkLLAZUqMhsXamyi-wwpWaOGvw@mail.gmail.com>
 <20130821123708.GA17748@b29396-Latitude-E6410>
 <20130823070906.GA2460@b29396-Latitude-E6410>
Message-ID: <20130823075102.GA10424@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree mailing list is changed to devicetree at vger.kernel.org.

On Fri, Aug 23, 2013 at 03:09:08PM +0800, Dong Aisheng wrote:
> I tried the uboot way with fdt command to change the node status, it can work.
> However, it seems using fdt command is much complicated than the way i did with kernel
> command line and it also does not support enable/disable multi nodes at the same time.
> e.g, in order to enable ecspi1 and uart3 and disable gpmi:
> with uboot fdt command:
> U-Boot > fdt addr ${dtbaddr}
> U-Boot > fdt set /soc/aips-bus at 02000000/spba-bus at 02000000/ecspi at 02008000 status "okay"
> U-Boot > fdt set /soc/aips-bus at 02100000/serial at 021e8000 status "okay"
> U-Boot > fdt set /soc/gpmi-nand at 00112000 status "disabled"

Oh, you can use the U-Boot environment and scripting function to make
it even easier than your kernel cmdline approach to use.

> with kernel cmdline:
> fdt.enable=ecspi at 02008000,serial at 021e8000 fdt.disable=gpmi-nand at 00112000
> So from the using perspective, kernel command line is much more simple and easy than uboot.

NAK.

It's not about simple or easy.  The approach completely defects the
point of the whole device tree project - moving stuff that kernel does
not care out of kernel.  Choosing device from mutually exclusive ones
(due to pin conflict of board design) should NOT be something that
kernel cares.

Kernel gets device tree blob from firmware/bootloader and instantiates
drivers for devices found in device tree.  That's all what kernel should
do, nothing more.  Asking kernel to manipulate the device availability
property in device tree is plainly wrong to me.

If your board is designed with so many pin conflicts between devices,
you have to do whatever you can do to get the decision made in device
tree blob, before it gets passed to kernel.  Kernel does NOT care about
that decision making.

Shawn
