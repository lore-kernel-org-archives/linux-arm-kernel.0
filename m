From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Jul 2014 11:12:54 +0100
Subject: [RFC V2] devicetree: Dialog Semiconductor consolidate existing
 vendor prefixes to standardise on 'dlg'
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B2762A@SW-EX-MBX02.diasemi.com>
References: <201407151520.s6FFKcjB009745@swsrvapps-01.diasemi.com>
 <20140722070927.GC28529@lee--X1>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B2762A@SW-EX-MBX02.diasemi.com>
Message-ID: <20140723101254.GH23210@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Jul 2014, Opensource [Steve Twiss] wrote:

> 
> On 22 July 2014 08:09, Lee Jones wrote:
> 
> >-----Original Message-----
> >From: Lee Jones [mailto:lee.jones at linaro.org]
> >> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> >>
> >> This patch series updates the device tree vendor prefix for
> >> Dialog Semiconductor.
> >>
> >> Various methods are currently used throughout the kernel: 'diasemi',
> >> 'dialog' and 'dlg'. Others have also been suggested.
> >>
> >> This patch set aims to consolidate the usage of the vendor prefix to
> >> use a common standard. The prefix 'dlg' is used.
> >>
> >> Here is my working for justifying this change:
> >>
> >> ./arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> >> 	Has the following entry:
> >> 	compatible = "dialog,da9063";
> >> 	However the DA9063 driver does not support device tree yet so
> >> 	it would be safe to rename this.
> >>
> >> ./arch/arm/boot/dts/imx53-smd.dts
> >> 	Has the following entry:
> >> 	compatible = "dialog,da9053", "dialog,da9052";
> >> 	However, the existing driver files for DA9053 define a different
> >> 	compatible string with the "dlg" prefix. See the entries below.
> >> 	None of these would have allowed the "dialog" prefix.
> >> 	{ .compatible = "dlg,da9052", .data = &da9052_i2c_id[0] },
> >> 	{ .compatible = "dlg,da9053-aa", .data = &da9052_i2c_id[1] },
> >> 	{ .compatible = "dlg,da9053-ba", .data = &da9052_i2c_id[2] },
> >> 	{ .compatible = "dlg,da9053-bb", .data = &da9052_i2c_id[3] },
> >> 	{ .compatible = "dlg,da9053-bc", .data = &da9052_i2c_id[4] },
> >> 	In this particular case the change for DA9053 did not match up
> >> 	with the expected compatibility strings and therefore I have
> >> 	retained the more general "dlg,da9053" because I do not know
> >> 	which silicon variant (-aa, -ba, -bb, or -bc) is the correct
> >> 	one to use.
> >>
> >> ./devicetree/bindings/i2c/trivial-devices.txt
> >> 	Has the following entry:
> >> 	dialog,da9053  DA9053: flexible system level PMIC with multicore support
> >> 	Instead of depreciating this "dialog" line I am just replacing it
> >> 	with a "dlg" because the existing driver DA9053 does not support
> >> 	the dialog keyword.
> >>
> >> ./drivers/mfd/da9055-core.c
> >> 	Has the following entries for the mfd cells
> >> 		.of_compatible = "dialog,da9055-gpio", etc...
> >> 	In this case, the driver does not actually pass in any platform data
> >> 	to any of the mfd cells and so they are not actually used
> >> 	yet in the driver. Nobody else references this information.
> >>
> >> ./devicetree/bindings/regulator/da9210.txt
> >> 	Has the following two entries in the binding file:
> >> 	- compatible:	must be "diasemi,da9210"
> >> 	compatible = "diasemi,da9210";
> >> 	However the DA9210 driver does not support device tree.
> >>
> >> ./arch/arm/boot/dts/r8a7790-lager.dts
> >> ./arch/arm/boot/dts/r8a7791-koelsch.dts
> >> 	These two files have the following entries:
> >> 	compatible = "diasemi,da9210";
> >> 	These both reference the "diasemi,da9210" but the device
> >> 	driver does not support device tree
> >>
> >> The remaining files in the kernel I have found correctly references
> >> the driver files compatibility information and so did not need to
> >> be changed.
> >>
> >> ./devicetree/bindings/mfd/da9052-i2c.txt
> >> 	- compatible : Should be "dlg,da9052", "dlg,da9053-aa",
> >> 		 "dlg,da9053-ab", or "dlg,da9053-bb"
> >>
> >> ./devicetree/bindings/mfd/da9055.txt
> >> 	compatible = "dlg,da9055-pmic";
> >>
> >> ./arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
> >> 	compatible = "dlg,da9053-aa", "dlg,da9052";
> >>
> >> ./arch/arm/boot/dts/imx53-qsb.dts
> >> 	compatible = "dlg,da9053-aa", "dlg,da9052";
> >>
> >> ./devicetree/bindings/sound/da9055.txt
> >> 	- compatible: "dlg,da9055-codec"
> >> 	compatible = "dlg,da9055-codec";
> >>
> >>
> >> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> >> ---
> >> Checks performed with linux-next/next-20140715/scripts/checkpatch.pl
> >>  trivial-devices.txt       total: 0 errors, 0 warnings, 89 lines checked
> >>  da9210.txt                total: 0 errors, 0 warnings, 21 lines checked
> >>  vendor-prefixes.txt       total: 0 errors, 0 warnings, 149 lines checked
> >>  imx53-smd.dts             total: 0 errors, 2 warnings, 279 lines checked
> >>  imx6qdl-phytec-pfla02.dtsi total: 0 errors, 2 warnings, 357 lines checked
> >>  r8a7790-lager.dts         total: 0 errors, 3 warnings, 403 lines checked
> >>  r8a7791-koelsch.dts       total: 0 errors, 4 warnings, 461 lines checked
> >>  da9055-core.c             total: 0 errors, 0 warnings, 428 lines checked
> >>
> >> This e-mail is in response to the previous threads here:
> >> https://lkml.org/lkml/2014/6/11/262
> >> http://comments.gmane.org/gmane.linux.ports.arm.kernel/341358
> >>
> >> Changes since RFC V1
> >> - addition of changes to DTS files referencing "diasemi,da9210"
> >>    arch/arm/boot/dts/r8a7790-lager.dts
> >>    arch/arm/boot/dts/r8a7791-koelsch.dts
> >>
> >> This RFC V2 does not answer the response to RFC V1 from Mark Brown:
> >> http://www.spinics.net/lists/arm-kernel/msg347615.html
> >>
> >> This patch applies against linux-next and next-20140715
> >>
> >> Regards,
> >> Steve Twiss, Dialog Semiconductor Ltd.
> >>
> >>
> >>
> >>  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 +-
> >>  .../devicetree/bindings/regulator/da9210.txt       |  4 ++--
> >>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> >>  arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
> >>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-
> >>  arch/arm/boot/dts/r8a7790-lager.dts                |  2 +-
> >>  arch/arm/boot/dts/r8a7791-koelsch.dts              |  2 +-
> >>  drivers/mfd/da9055-core.c                          | 26 ++++++++++----------
> >
> >For the MFD changes:
> >
> >  Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> >Which tree is this patch going into?  Do you want me to take it and
> >supply an IB for the other Maintainers to pull from?
> 
> Hi Lee,
> 
> I'm not sure if this question was for me directly, but I do not have any
> preference who takes this change or how it gets pulled. Thank you.
> 
> There was a request from Rob Herring
> http://www.spinics.net/lists/arm-kernel/msg349289.html
> to reformat the original e-mail content and also to drop the annoying 
> "Opensource" and square brackets from my Signed-off-by:
> signature.

... and Author:

So for me to take this, I need to see DT or Maintainer Acks for the
bindings and DTS(I) changes.

> So, the decision is to take the patch into an immutable branch
> and you need me to re-format the e-mail content -- I will resend 
> with those changes.
> 
> Regards,
> Steve
> 
> >
> >>  8 files changed, 21 insertions(+), 20 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
