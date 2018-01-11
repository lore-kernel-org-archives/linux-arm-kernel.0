From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 11 Jan 2018 00:39:47 +0000
Subject: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
In-Reply-To: <20180109121911.GA18770@mordor.localdomain>
References: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
 <20180109121911.GA18770@mordor.localdomain>
Message-ID: <DM2PR0201MB0767D0A01778BB21BC33A87CB8160@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Aishwarya for the review,

> -----Original Message-----
> From: Aishwarya Pant [mailto:aishpant at gmail.com]
> Sent: Tuesday, January 09, 2018 4:19 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org;
> gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
> 
> On Mon, Jan 08, 2018 at 02:07:07PM -0800, Jolly Shah wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> > Firmware-debug provides debugfs interface to all APIs.
> > Firmware-ggs provides read/write interface to
> > global storage registers.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   16 +
> >  arch/arm64/Kconfig.platforms                       |    1 +
> >  drivers/firmware/Kconfig                           |    1 +
> >  drivers/firmware/Makefile                          |    1 +
> >  drivers/firmware/xilinx/Kconfig                    |    4 +
> >  drivers/firmware/xilinx/Makefile                   |    4 +
> >  drivers/firmware/xilinx/zynqmp/Kconfig             |   23 +
> >  drivers/firmware/xilinx/zynqmp/Makefile            |    5 +
> >  drivers/firmware/xilinx/zynqmp/firmware-debug.c    |  540 +++++++++++
> >  drivers/firmware/xilinx/zynqmp/firmware-ggs.c      |  298 ++++++
> >  drivers/firmware/xilinx/zynqmp/firmware.c          | 1024
> ++++++++++++++++++++
> >  .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |   32 +
> >  include/linux/firmware/xilinx/zynqmp/firmware.h    |  573 +++++++++++
> >  13 files changed, 2522 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> >  create mode 100644 drivers/firmware/xilinx/Kconfig
> >  create mode 100644 drivers/firmware/xilinx/Makefile
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
> >  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-debug.h
> >  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
> >
> > +static ssize_t ggs_store(struct device *dev,
> > +			 struct device_attribute *attr,
> > +			 const char *buf,
> > +			 size_t count,
> > +			 u32 reg)
> > +{
> > +	if (!dev || !attr || !buf || !count || reg >= GSS_NUM_REGS)
> > +		return -EINVAL;
> > +
> > +	return write_register(buf, count, IOCTL_WRITE_GGS, reg);
> > +}
> > +
> > +/* GGS register show functions */
> > +#define GGS0_SHOW(N) \
> > +	ssize_t ggs##N##_show(struct device *dev, \
> > +			 struct device_attribute *attr, \
> > +			 char *buf) \
> > +	{ \
> > +		return ggs_show(dev, attr, buf, N); \
> > +	}
> > +
> > +static GGS0_SHOW(0);
> > +static GGS0_SHOW(1);
> > +static GGS0_SHOW(2);
> > +static GGS0_SHOW(3);
> > +
> > +/* GGS register store function */
> > +#define GGS0_STORE(N) \
> > +	ssize_t ggs##N##_store(struct device *dev, \
> > +				   struct device_attribute *attr, \
> > +				   const char *buf, \
> > +				   size_t count) \
> > +	{ \
> > +		return ggs_store(dev, attr, buf, count, N); \
> > +	}
> > +
> > +static GGS0_STORE(0);
> > +static GGS0_STORE(1);
> > +static GGS0_STORE(2);
> > +static GGS0_STORE(3);
> > +
> > +/* GGS register device attributes */
> > +static DEVICE_ATTR_RW(ggs0);
> > +static DEVICE_ATTR_RW(ggs1);
> > +static DEVICE_ATTR_RW(ggs2);
> > +static DEVICE_ATTR_RW(ggs3);
> 
> Hi
> 
> You added some files to the sysfs ABI. These interfaces should be documented in
> Documentation/ABI.
> 
Sure. Will add it in next version.

Thanks,
Jolly Shah
