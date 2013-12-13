From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Fri, 13 Dec 2013 11:21:56 +0100
Subject: [PATCH 07/10] ARM: dts: sun7i: cubietruck: Enable the GMAC
In-Reply-To: <CAGVrzcaxV88dU3vEVGUiEQihUHLxq+QvQVQ6VvmOFVRsqbbX7w@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-8-git-send-email-wens@csie.org>
 <CAGVrzcb_r9_p4urz4XkE2A-G85KAHJa4PJ=Gt9a4RPYQNJ6j0g@mail.gmail.com>
 <CAGb2v64yFhkTXvdq=1VpemULhXew-5fvmSoTBzEb6iFDiSqy1Q@mail.gmail.com>
 <CAGVrzcaxV88dU3vEVGUiEQihUHLxq+QvQVQ6VvmOFVRsqbbX7w@mail.gmail.com>
Message-ID: <52AADFC4.1070003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/7/2013 2:57 AM, Florian Fainelli wrote:
> 2013/12/6 Chen-Yu Tsai <wens@csie.org>:
>> On Sat, Dec 7, 2013 at 5:09 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> 2013/12/6 Chen-Yu Tsai <wens@csie.org>:
>>>> The CubieTruck uses the GMAC with an RGMII phy.
>>>>
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> ---
>>>>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> index 8a1009d..af212a2 100644
>>>> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> @@ -33,6 +33,14 @@
>>>>                          pinctrl-0 = <&uart0_pins_a>;
>>>>                          status = "okay";
>>>>                  };
>>>> +
>>>> +               gmac: ethernet at 01c50000 {
>>>> +                       pinctrl-names = "default";
>>>> +                       pinctrl-0 = <&gmac_pins_rgmii>;
>>>> +                       snps,phy-addr = <1>;
>>>
>>> What is this snps,phy-addr property? Why is not a standard device tree
>>> node for an Ethernet PHY node used?
>>
>> This property is implemented by stmmac and documented in the DT
>> bindings. stmmac has not been updated to use Ethernet PHY nodes.
>
> This driver property should be removed and deprecated since there is
> an ePAPR standardized Ethernet PHY node. What I am worried here is the
> loss of information, the standard Ethernet DT node allows to specify
> much more information (clause, maximum speed, compatible string
> etc...).


yes Florian you are right and I have already started updating the
driver. I do not sure that I'll be able to send all the patches soon
but for sure I can re-base them.

>>
>> Removing this property will not affect the function of the driver.
>> The driver probes its MDIO bus and selects the lowest available
>> address if not specified.
>
> So if this is just giving the driver a hint on where to  probe for a
> PHY on the MDIO bus, then let's drop it and use the standard DT node
> no?
>
>>
>>>> +                       phy-mode = "rgmii";
>>>
>>> Especially since you use the relatively standard "phy-mode" property here?
>>
>> Used as specified in stmmac DT bindings.
>
> That one is kind of okay because of_get_phy_mode() knows about it,
> even though ePAPR states this should be "phy-connection-type", so I am
> okay with keeping that one because current practice and helpers are
> here.
>
