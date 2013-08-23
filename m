From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Aug 2013 17:36:02 +0800
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
In-Reply-To: <20130823084954.GC2460@b29396-Latitude-E6410>
References: <1376564133-11286-1-git-send-email-b29396@freescale.com>
 <CACxGe6tMm=u1jFKUQ59+cj-rYkLLAZUqMhsXamyi-wwpWaOGvw@mail.gmail.com>
 <20130821123708.GA17748@b29396-Latitude-E6410>
 <20130823070906.GA2460@b29396-Latitude-E6410>
 <20130823075102.GA10424@S2101-09.ap.freescale.net>
 <20130823084954.GC2460@b29396-Latitude-E6410>
Message-ID: <20130823093559.GA10662@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 04:49:55PM +0800, Dong Aisheng wrote:
> On Fri, Aug 23, 2013 at 03:51:07PM +0800, Shawn Guo wrote:
> > The device tree mailing list is changed to devicetree at vger.kernel.org.
> > 
> > On Fri, Aug 23, 2013 at 03:09:08PM +0800, Dong Aisheng wrote:
> > > I tried the uboot way with fdt command to change the node status, it can work.
> > > However, it seems using fdt command is much complicated than the way i did with kernel
> > > command line and it also does not support enable/disable multi nodes at the same time.
> > > e.g, in order to enable ecspi1 and uart3 and disable gpmi:
> > > with uboot fdt command:
> > > U-Boot > fdt addr ${dtbaddr}
> > > U-Boot > fdt set /soc/aips-bus at 02000000/spba-bus at 02000000/ecspi at 02008000 status "okay"
> > > U-Boot > fdt set /soc/aips-bus at 02100000/serial at 021e8000 status "okay"
> > > U-Boot > fdt set /soc/gpmi-nand at 00112000 status "disabled"
> > 
> > Oh, you can use the U-Boot environment and scripting function to make
> > it even easier than your kernel cmdline approach to use.
> > 
> 
> Hmm?
> Can you give an example to make it easier than kernel cmdline?

For imx6q-sabreauto example,

setenv loadaddr 0x12000000
setenv fdtaddr 0x18000000
setenv fdt_file imx6q-sabreauto.dtb

setenv bootcmd 'tftpboot zImage; tftpboot ${fdtaddr} ${fdt_file}; fdt addr ${fdtaddr}; run select_${devsel}; bootz ${loadaddr} - ${fdtaddr}'

setenv select_gpmi 'fdt set /soc/aips-bus at 02000000/spba-bus at 02000000/ecspi at 02008000 status disabled; fdt set /soc/aips-bus at 02100000/serial at 021e8000 status disabled; fdt set /soc/gpmi-nand at 00112000 status okay'
setenv select_ecspi '...'
setenv select_serial '...'

You can have all above environments defined in U-Boot mx6qsabreauto.h
at compile time.  Then at runtime, you only need the following two
commands to boot kernel with the device that you want.

U-Boot > setenv devsel gpmi
U-Boot > boot

Shawn
