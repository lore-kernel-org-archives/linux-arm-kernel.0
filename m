From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 24 Jan 2018 23:30:43 +0000
Subject: [PATCH v2 3/4] drivers: firmware: xilinx: Add sysfs interface
In-Reply-To: <20180123083732.GA21463@kroah.com>
References: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
 <1516220434-22204-4-git-send-email-jollys@xilinx.com>
 <20180123083732.GA21463@kroah.com>
Message-ID: <DM2PR0201MB076735ACCF46914F426ACA2AB8E20@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review Greg,

> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Tuesday, January 23, 2018 12:38 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 3/4] drivers: firmware: xilinx: Add sysfs interface
> 
> On Wed, Jan 17, 2018 at 12:20:33PM -0800, Jolly Shah wrote:
> > Add Firmware-ggs sysfs interface which provides read/write interface
> > to global storage registers.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../ABI/stable/sysfs-driver-zynqmp-firmware        |  33 +++
> >  drivers/firmware/xilinx/zynqmp/Makefile            |   2 +-
> >  drivers/firmware/xilinx/zynqmp/firmware-ggs.c      | 298
> +++++++++++++++++++++
> >  drivers/firmware/xilinx/zynqmp/firmware.c          |  26 ++
> >  include/linux/firmware/xilinx/zynqmp/firmware.h    |   2 +
> >  5 files changed, 360 insertions(+), 1 deletion(-)  create mode 100644
> > Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> >
> > +
> > +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> 
> That's crazy deep nesting, why?

It needs to be in include/linux to be used by other drivers and as it is Xilinx specific, we have it in subdirectory.

> 
> > +
> > +static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg) {
> > +       int ret;
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > +       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> > +
> > +       if (!eemi_ops || !eemi_ops->ioctl)
> > +               return 0;
> 
> Not an error?

Fixed in v3 patch series.

> 
> > +
> > +       ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return snprintf(buf, PAGE_SIZE, "0x%x\n", ret_payload[1]);
> 
> Minor nit, you never need to use snprintf() for a sysfs file, as you "know" the size
> and you can't overflow it with just a single value.
> 
> Yeah, some tool-checkers hate to see a "raw" sprintf() call, but really, ignore
> them here :)

Changed to sprint in v3 patch series.

> > +
> > +       /* Read the write value */
> > +       tok = strsep(&inbuf, " ");
> > +       if (!tok) {
> > +               ret = -EFAULT;
> > +               goto err;
> > +       }
> > +
> > +       ret = kstrtol(tok, 16, &value);
> > +       if (ret) {
> > +               ret = -EFAULT;
> > +               goto err;
> > +       }
> 
> What exactly is the format for the data to be written here?  You do not
> document it in the ABI/ file above, and it looks to be non-trivial to understand
> from the code :(
> 

Updated documentation in v3 patch series.

> > +
> > +#define CREATE_PGGS_DEVICE(dev, N) \
> > +do { \
> > +       if (device_create_file(dev, &dev_attr_pggs##N)) \
> > +               dev_err(dev, "unable to create pggs%d attribute\n",
> > +N); \
> 
> Ick, no, just use an attribute group please.  Handles all of this mess for you
> automatically, and will unwind properly if you have an error (which this macro
> does not do.)
> 
> thanks,
> 
> greg k-h

Fixed in v3 patch series.

Thanks,
Jolly Shah
