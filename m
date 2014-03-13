From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 19:32:09 +0100
Subject: [PATCH v5 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <CAPdUM4McDh5gqk2Z=-n5XTZqsLLVe18rO4s810Zrk0vHQu-M2A@mail.gmail.com>
References: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
 <1394637394-3960-3-git-send-email-rahul.sharma@samsung.com>
 <532102CE.708@samsung.com>
 <CAPdUM4McDh5gqk2Z=-n5XTZqsLLVe18rO4s810Zrk0vHQu-M2A@mail.gmail.com>
Message-ID: <5321F9A9.9030904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.03.2014 06:06, Rahul Sharma wrote:
> On 13 March 2014 06:28, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>> On 03/13/2014 12:16 AM, Rahul Sharma wrote:

[snip]

>>> +               clocks {
>>> +                       compatible = "simple-bus";
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>
>>
>> Even though you added  #address-cells property I can not see "reg" property
>> in any of "fixed-clock".
>> Isn't it better either we can remove this or add "reg" property?
>> Also all these fixed-clock are missing #clock-cells property.
>>
>
> Since it is a soc level addition, I enabled provision for adding reg
> property for
> fixed clocks in boards files (or in SoC file).
>

All sub-nodes should follow the same pattern.

After recent discussion with DT people, the conclusion is that 
simple-bus should be used only for MMIO platform devices with "reg" 
values mapped directly into address space in which the simple-bus node 
resides.

So for now I'd remove the grouping and keep the clocks in "soc" node 
directly.

[snip]

>>> +
>>> +                       dptx_phy_ch0: phyclk_dptx_phy_ch0_txd {
>>> +                               compatible = "fixed-clock";
>>> +                               clock-frequency = <270000000>;
>>> +                               clock-output-names =
>>> "phyclk_dptx_phy_ch0_txd_clk";
>>> +                       };

I'm not sure whether these clocks are really fixed clocks. They are 
output from certain PHY blocks which are not always-on, while using the 
fixed clock binding would suggest otherwise. IMHO they should be hidden 
inside the clock driver, without DT IDs assigned as a temporary hack, 
until proper support gets added for them (e.g. proper clock provider 
from appropriate PHY).

Best regards,
Tomasz
