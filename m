From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Jun 2016 12:50:06 -0700
Subject: [PATCH] ARM: BCM5301X: Specify PHY of USB 2.0 in DT
In-Reply-To: <CACna6ryjSYcxKcCaTtkdkExo0G1qiDMQCUCAgx-bMtnjziAoUQ@mail.gmail.com>
References: <1464808585-14996-1-git-send-email-zajec5@gmail.com>
 <574F35C3.6050004@gmail.com>
 <CACna6ryjSYcxKcCaTtkdkExo0G1qiDMQCUCAgx-bMtnjziAoUQ@mail.gmail.com>
Message-ID: <574F3C6E.4090001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 12:35 PM, Rafa? Mi?ecki wrote:
> On 1 June 2016 at 21:21, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 06/01/2016 12:16 PM, Rafa? Mi?ecki wrote:
>>> Driver for Northstar USB 2.0 PHY was added in 4.7-rc1 by:
>>> commit d3feb4067335 ("phy: bcm-ns-usb2: new driver for USB 2.0 PHY on
>>> Northstar").
>>> It should be used to let EHCI platform driver init PHY.
>>>
>>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/bcm5301x.dtsi | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
>>> index 7d4d29b..9300e19 100644
>>> --- a/arch/arm/boot/dts/bcm5301x.dtsi
>>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>>> @@ -140,6 +140,22 @@
>>>               };
>>>       };
>>>
>>> +     phys {
>>> +             compatible = "simple-bus";
>>> +             ranges = <0x00000000 0x18000000 0x00100000>;
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +
>>> +             usb2_phy2: usb2-phy {
>>> +                     compatible = "brcm,ns-usb2-phy";
>>> +                     reg = <0x0000c000 0x1000>;
>>> +                     reg-names = "dmu";
>>> +                     #phy-cells = <0>;
>>> +                     clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
>>> +                     clock-names = "phy-ref-clk";
>>> +             };
>>
>> You guys need to get everything straigthen up when it comes to busing
>> and child nodes for bcm53101x.dtsi, why do we need a "simple-bus" node
>> here which overlaps in part with the brcm-bus-axi node's range?
> 
> I believed I'm making things cleaner by adding a separated node for
> PHYs (in the future there will be also USB 3.0 PHY and probably a PCIe
> PHY). I'm fine with placing this PHY node somewhere else if you think
> it better fits there.

The intent looks good, but it seems to me (and the datasheet helps here
too) that extending the brcm,bus-axi node to cover a wider register
range size could allow you to put the different PHYs as child nodes of
that bus. That way even if the core is probed with BCMA you still have a
proper of_node refefence that your driver can use.

Maybe as a better immediate solution, something like the NAND controller
node would be more elegant, where it only consumes its register space
and not more?
-- 
Florian
