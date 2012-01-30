From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 Jan 2012 13:13:07 -0700
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <4F1E7F36.50505@samsung.com>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de>
 <4F1DC480.4010603@gmail.com> <4F1E5B44.4090200@denx.de>
 <4F1E7F36.50505@samsung.com>
Message-ID: <20120130201307.GV28397@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 10:51:50AM +0100, Sylwester Nawrocki wrote:
> Hello Heiko,
> 
> On 01/24/2012 08:18 AM, Heiko Schocher wrote:
> >> On 01/23/2012 09:56 AM, Heiko Schocher wrote:
> >>> add of support for the davinci i2c driver.
> >>>
> >>> Signed-off-by: Heiko Schocher<hs@denx.de>
> >>> Cc: davinci-linux-open-source at linux.davincidsp.com
> >>> Cc: linux-arm-kernel at lists.infradead.org
> >>> Cc: devicetree-discuss at lists.ozlabs.org
> >>> Cc: linux-i2c at vger.kernel.org
> >>> Cc: Ben Dooks<ben-linux@fluff.org>
> >>> Cc: Wolfram Sang<w.sang@pengutronix.de>
> >>> Cc: Grant Likely<grant.likely@secretlab.ca>
> >>> Cc: Sekhar Nori<nsekhar@ti.com>
> >>> Cc: Wolfgang Denk<wd@denx.de>
> >>> ---
> >>>   .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
> >>>   drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
> >>>   2 files changed, 82 insertions(+), 0 deletions(-)
> >>>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
> >>> new file mode 100644
> >>> index 0000000..94ec670
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
> >>> @@ -0,0 +1,39 @@
> >>> +* Texas Instruments Davinci I2C
> >>> +
> >>> +This file provides information, what the device node for the
> >>> +davinci i2c interface contain.
> >>> +
> >>> +Required properties:
> >>> +- compatible: "ti,davinci-i2c";
> >>> +- reg : Offset and length of the register set for the device
> >>> +- id: id of the controller
> >>
> >> I was wondering whether we're supposed to use "cell-index" property name
> >> for such a device instance index? or doesn't it really matter and "id" is 
> >> fine? Such an IP instance index seems quite common so I thought it could
> >> be easier to follow to use standard name.
> > 
> > I just copied the "name" from "struct davinci_nand_pdata" ... it is
> > used in the davinci_nand driver as chipselect ... maybe it is better
> > I rename this to "chipselect" ?
> 
> From what I can see the 'id' property is used to determine I2C adapter
> number. In that case 'id' seems more correct than "chipselect". Are you
> sure there is a chip select functionality in I2C controller ?
> 
> It seems that your id is just an index of I2C controller in hardware.
> I would personally just use cell-index for that, but I'm not a dt expert,
> someone nay correct me.

The whole 'cell-index' or 'id' thing is a BadIdea(tm).  Don't use it, and tell
others not to do it when you see it.  There are some legacy uses in powerpc,
but those were written before I and others knew better.

The *only* situation where cell-index is acceptable is when the driver
absolutely must know which hardware instance it is driving because it
needs to calculate offsets in a shared register or something, and even
then it should not be used to set the pdev->id field. That situation
does not look to be the case here.

If you're using the DT, then let the core code dynamically assign the
i2c adapter number.

> Moreover you seem to overwrite platform device name and id,
> 
> 		if (!of_property_read_u32(pdev->dev.of_node, "id",
> +			&prop)) {
> +			pdev->id = prop;
> +			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
> +			sprintf((char *)pdev->dev.init_name,
> +				"i2c_davinci.%d", pdev->id);
> 
> I'm not sure if it is a good practice.

No, it is not good practice.  At this point the device is already
registered.  Changing the value of pdev->id will cause problems in the
core code because the /sysfs files will have already been created.

> If you want to pre-define platform
> device name (likely for the clock API to work), it might be more appropriate
> to use OF_DEV_AUXDATA in the machine code, until there are clock bindings
> available.

Yes, use OF_DEV_AUXDATA, but *only* if you need it for hooking up
clocks, regulators, or similar.  Don't use it just because you want
the device to have a different name for cosmetic reasons.  The need
for AUXDATA should go away once the DT clock binding code is merged.

g.
