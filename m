From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 24 Jan 2012 10:51:50 +0100
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <4F1E5B44.4090200@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de> <4F1DC480.4010603@gmail.com>
 <4F1E5B44.4090200@denx.de>
Message-ID: <4F1E7F36.50505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

On 01/24/2012 08:18 AM, Heiko Schocher wrote:
>> On 01/23/2012 09:56 AM, Heiko Schocher wrote:
>>> add of support for the davinci i2c driver.
>>>
>>> Signed-off-by: Heiko Schocher<hs@denx.de>
>>> Cc: davinci-linux-open-source at linux.davincidsp.com
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> Cc: linux-i2c at vger.kernel.org
>>> Cc: Ben Dooks<ben-linux@fluff.org>
>>> Cc: Wolfram Sang<w.sang@pengutronix.de>
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>> Cc: Sekhar Nori<nsekhar@ti.com>
>>> Cc: Wolfgang Denk<wd@denx.de>
>>> ---
>>>   .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>>>   drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>>>   2 files changed, 82 insertions(+), 0 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>> new file mode 100644
>>> index 0000000..94ec670
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>> @@ -0,0 +1,39 @@
>>> +* Texas Instruments Davinci I2C
>>> +
>>> +This file provides information, what the device node for the
>>> +davinci i2c interface contain.
>>> +
>>> +Required properties:
>>> +- compatible: "ti,davinci-i2c";
>>> +- reg : Offset and length of the register set for the device
>>> +- id: id of the controller
>>
>> I was wondering whether we're supposed to use "cell-index" property name
>> for such a device instance index? or doesn't it really matter and "id" is 
>> fine? Such an IP instance index seems quite common so I thought it could
>> be easier to follow to use standard name.
> 
> I just copied the "name" from "struct davinci_nand_pdata" ... it is
> used in the davinci_nand driver as chipselect ... maybe it is better
> I rename this to "chipselect" ?

>From what I can see the 'id' property is used to determine I2C adapter
number. In that case 'id' seems more correct than "chipselect". Are you
sure there is a chip select functionality in I2C controller ?

It seems that your id is just an index of I2C controller in hardware.
I would personally just use cell-index for that, but I'm not a dt expert,
someone nay correct me.

For instance, this is how "cell-index" semantics is described in case
of MPC5200 Programmable Serial Controllers (from Documentation/devicetree/
bindings/powerpc/fsl/mpc5200.txt):

"fsl,mpc5200-psc nodes
---------------------
The PSCs should include a cell-index which is the index of the PSC in
hardware.  cell-index is used to determine which shared SoC registers to
use when setting up PSC clocking.  cell-index number starts at '0'.  ie:
        PSC1 has 'cell-index = <0>'
        PSC4 has 'cell-index = <3>'"

Moreover you seem to overwrite platform device name and id,

		if (!of_property_read_u32(pdev->dev.of_node, "id",
+			&prop)) {
+			pdev->id = prop;
+			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
+			sprintf((char *)pdev->dev.init_name,
+				"i2c_davinci.%d", pdev->id);

I'm not sure if it is a good practice. If you want to pre-define platform
device name (likely for the clock API to work), it might be more appropriate
to use OF_DEV_AUXDATA in the machine code, until there are clock bindings
available.
Then you would just use your 'id'/'cell-index' property to set an I2C adapter
number.

--
Regards,
Sylwester
