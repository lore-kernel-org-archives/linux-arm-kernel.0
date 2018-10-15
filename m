From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Mon, 15 Oct 2018 10:56:41 +0200
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: document Broadcom Northstar
 pin mux controller
In-Reply-To: <20181011222229.GA7470@bogus>
References: <20180926193103.21241-1-zajec5@gmail.com>
 <20181011222229.GA7470@bogus>
Message-ID: <7f08ed7bf11a22163bdfd56ff96a9262@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-10-12 00:22, Rob Herring wrote:
> On Wed, Sep 26, 2018 at 09:31:02PM +0200, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>> 
>> Northstar has mux controller just like Northstar Plus and Northstar2.
>> It's a bit different though (different registers & pins) so it 
>> requires
>> its own binding.
>> 
>> It's needed to allow other block bindings specify required mux setup.
>> 
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> V2: Use "cru_gpio_control"
>>     Add more functions & groups
>>     Include Florian's Reviewed-by
>> V3: Use 3 different bindings as available pins depend on the chipset.
>>     Strings match 
>> Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
>> ---
>>  .../bindings/pinctrl/brcm,bcm4708-pinmux.txt       | 42 
>> ++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt 
>> b/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
>> new file mode 100644
>> index 000000000000..af906f196e8c
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
>> @@ -0,0 +1,42 @@
>> +Broadcom Northstar pins mux controller
>> +
>> +Some of Northstar SoCs's pins can be used for various purposes thanks 
>> to the mux
>> +controller. This binding allows describing mux controller and listing 
>> available
>> +functions. They can be referenced later by other bindings to let 
>> system
>> +configure controller correctly.
>> +
>> +A list of pins varies across chipsets so few bindings are available.
>> +
>> +Required properties:
>> +- compatible: must be one of:
>> +	"brcm,bcm4708-pinmux"
>> +	"brcm,bcm4709-pinmux"
>> +	"brcm,bcm53012-pinmux"
>> +- reg: iomem address range of CRU (Central Resource Unit) pin 
>> registers
> 
> Perhaps 'cru' in the compatible if that's what the h/w is called?
> 
> Also, if this is a sub-block, then it should be a child of the block
> which should be defined here.

It took me some time to do some extra research on the whole CRU thing.

Valuable resources:
[1] bcm5301x_dmu.c (from the SDK)
[2] bcm5301x_pcie.c (from the SDK)
[3] https://patchwork.kernel.org/patch/7888651/
[4] https://patchwork.kernel.org/patch/5051471/

First of all CRU seems to be a sub-block of the DMU (which stands for
"Device Management Unit" according to the [1]). DMU seems to be
independent block at 0x1800c000 with a size of 0x1000.

It isn't actually clear what the CRU stands for. In Broadcom's case:
1. According to the [3] it's "Clock and Reset Unit"
2. According to the [4] it's a "central resource unit"
Other vendors seem to use CRU name for "Clock and Reset Unit".

In any case, you're right Rob, it's a sub-block, a set of random
registers that control SoC.

So I think that:
1) We should have a node for DMU and CRU
2) We should not include "cru" in bindings as pinmuxing seems to be part
    of SoC that just happens to be controlled using CRU registers
