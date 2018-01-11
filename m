From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 11 Jan 2018 01:13:57 +0000
Subject: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
In-Reply-To: <5fbe8626-63be-02c4-b3e5-ba6c99a8d67c@arm.com>
References: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
 <5fbe8626-63be-02c4-b3e5-ba6c99a8d67c@arm.com>
Message-ID: <DM2PR0201MB07678276DA8938F5BF5E0A34B8160@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,
Thanks for the review,

> -----Original Message-----
> From: Julien Thierry [mailto:julien.thierry at arm.com]
> Sent: Tuesday, January 09, 2018 6:07 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly
> Shah <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
> 
> Hi Jolly,
> 
> On 08/01/18 22:07, Jolly Shah wrote:
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
> >   .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   16 +
> >   arch/arm64/Kconfig.platforms                       |    1 +
> >   drivers/firmware/Kconfig                           |    1 +
> >   drivers/firmware/Makefile                          |    1 +
> >   drivers/firmware/xilinx/Kconfig                    |    4 +
> >   drivers/firmware/xilinx/Makefile                   |    4 +
> >   drivers/firmware/xilinx/zynqmp/Kconfig             |   23 +
> >   drivers/firmware/xilinx/zynqmp/Makefile            |    5 +
> >   drivers/firmware/xilinx/zynqmp/firmware-debug.c    |  540 +++++++++++
> >   drivers/firmware/xilinx/zynqmp/firmware-ggs.c      |  298 ++++++
> >   drivers/firmware/xilinx/zynqmp/firmware.c          | 1024
> ++++++++++++++++++++
> >   .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |   32 +
> >   include/linux/firmware/xilinx/zynqmp/firmware.h    |  573 +++++++++++
> >   13 files changed, 2522 insertions(+)
> >   create mode 100644
> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> >   create mode 100644 drivers/firmware/xilinx/Kconfig
> >   create mode 100644 drivers/firmware/xilinx/Makefile
> >   create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
> >   create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
> >   create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
> >   create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> >   create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
> >   create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-
> debug.h
> >   create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
> >
> 
> > +
> > +static u32 pm_api_version;
> > +
> > +/**
> > + * zynqmp_pm_get_api_version - Get version number of PMU PM firmware
> > + * @version:	Returned version value
> > + *
> > + * Return:	Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_get_api_version(u32 *version)
> > +{
> > +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > +
> > +	if (!version)
> > +		return zynqmp_pm_ret_code(XST_PM_CONFLICT);
> > +
> > +	/* Check is PM API version already verified */
> > +	if (pm_api_version > 0) {
> > +		*version = pm_api_version;
> > +		return XST_PM_SUCCESS;
> > +	}
> > +	invoke_pm_fn(GET_API_VERSION, 0, 0, 0, 0, ret_payload);
> > +	*version = ret_payload[1];
> > +
> 
> I think you forgot to save the result to pm_api_version, unless I am
> missing something.
> 

Pm_api_version is initialized in init routine. So no need to save it again as version will remain same.

Rest all comments will be fixed in next version.

Thanks,
Jolly Shah
