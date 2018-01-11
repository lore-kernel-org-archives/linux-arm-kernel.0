From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 11 Jan 2018 00:35:43 +0000
Subject: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
In-Reply-To: <cbe4ccad-993b-76d7-bf7a-9ef0eb284459@arm.com>
References: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
 <cbe4ccad-993b-76d7-bf7a-9ef0eb284459@arm.com>
Message-ID: <DM2PR0201MB076772D0D335A1C6A9F07CB2B8160@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,
Thanks for the review,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Tuesday, January 09, 2018 6:40 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com
> Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
> 
> 
> 
> On 08/01/18 22:07, Jolly Shah wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> > Firmware-debug provides debugfs interface to all APIs.
> > Firmware-ggs provides read/write interface to global storage
> > registers.
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
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware
> > .txt  create mode 100644 drivers/firmware/xilinx/Kconfig  create mode
> > 100644 drivers/firmware/xilinx/Makefile  create mode 100644
> > drivers/firmware/xilinx/zynqmp/Kconfig
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
> >  create mode 100644
> > include/linux/firmware/xilinx/zynqmp/firmware-debug.h
> >  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > new file mode 100644
> > index 0000000..ace111c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.txt
> > @@ -0,0 +1,16 @@
> > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > +
> > +The zynqmp-firmware node describes the interface to platform firmware.
> > +
> > +Required properties:
> > + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> > + - method:	The method of calling the PM-API firmware layer.
> > +		Permitted values are:
> > +		 - "smc" : To be used in configurations without a hypervisor
> > +		 - "hvc" : To be used when hypervisor is present
> > +
> 
> If we are having a mailbox using smc/hvc, then it can be made generic rather
> than xilinx specific. I can see other user of the same. As Jassi pointed out in
> some other thread, Andre has some generic implementation.
> Please see how it can be reused.
> 

Andre's mailbox implementation in not in kernel yet. We can change later if it 
satisfies our use case.

> Also please keep any bindings separate from the driver changes so that it can be
> reviewed separately.

Sure. Will do it in next version.

> 
> > +Examples:
> > +	firmware: firmware {
> > +		compatible = "xlnx,zynqmp-firmware";
> > +		method = "smc";
> 
> Ideally this should point to mailbox if we move to using smc/hvc based mailbox.
> 
> [...]
> 
> > +
> > +config ZYNQMP_FIRMWARE_DEBUG
> > +	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
> > +	depends on ARCH_ZYNQMP && DEBUG_FS
> 
> Do you need a separate Kconfig option, can't you just use DEBUG_FS ?
> 
> [...]
> 

As its zynqmp specific, we wanted to keep an option to enable/disable it separately.
It can be combined as ZYNQMP FIRMWARE+DEBUG_FS instead of a separate Kconfig.


> > +
> > +	if (strncasecmp(pm_api_req, "REQUEST_SUSPEND", 15) == 0)
> > +		pm_id = REQUEST_SUSPEND;
> > +	else if (strncasecmp(pm_api_req, "SELF_SUSPEND", 12) == 0)
> > +		pm_id = SELF_SUSPEND;
> > +	else if (strncasecmp(pm_api_req, "FORCE_POWERDOWN", 15) == 0)
> > +		pm_id = FORCE_POWERDOWN;
> > +	else if (strncasecmp(pm_api_req, "ABORT_SUSPEND", 13) == 0)
> > +		pm_id = ABORT_SUSPEND;
> 
> 
> Can this be changed to a loop with a static structure array containing {pm_id,
> pm_string, strlen(pm_string)} ?

Will fix it in next version

> 
> Also I see hard-coded string length is wrong in some cases like IOCTL.
> Isn't it better to just use strlen("..") instead ?
> 

Will fix it in next version

> I will stop here as the patch can be easily split and several features can be added
> incrementally making the base patch simpler and shorter.

Sure. Will break it into a few patches in next version

Thanks,
Jolly Shah

> 
> --
> Regards,
> Sudeep
