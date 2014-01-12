From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 14:04:26 +0100
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <52D2064B.3010103@prisktech.co.nz>
References: <Pine.LNX.4.44L0.1401111728150.16586-100000@netrider.rowland.org>
 <52D2064B.3010103@prisktech.co.nz>
Message-ID: <52D292DA.8010709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[Cc'ing DT maintainers directly]

On 12.01.2014 04:04, Tony Prisk wrote:
> On 12/01/14 11:30, Alan Stern wrote:
>> On Fri, 10 Jan 2014, Hans de Goede wrote:
>>
>>> Hi,
>>>
>>> On 01/11/2014 12:50 AM, Sergei Shtylyov wrote:
>>>> Hello.
>>>>
>>>> On 01/11/2014 01:46 AM, Hans de Goede wrote:
>>>>
>>>>> Here is v4 of my ohci and ehci-platform clks, phy and dt support
>>>>> patch-set,
>>>>> this version should be 100% ready for merging upstream.
>>>>      I see you've decided to completely ignore my opinion. NAK, FWIW.
>>> I'm sorry but the whole prefix thing has become a thing of
>>> -ETOOMUCHBIKESHEDDING,
>>> everyone except you seems to be fine with mmio and and one point in
>>> time we
>>> need to make a decision and move forward.
>> If this isn't beating a dead horse...  Maybe everyone can agree on a
>> name like ohci-generic or generic-ohci.  That seems like a pretty good
>> description of the hardware that the platform driver can handle.
>>
>> Alan Stern
> I prefer the -generic option, although generic- is equally fine - Having
> said that, I don't really care if it's called mmio either (although this
> does seem less 'descriptive').

Grepping over existing dts files, I can find several occurrences of 
"usb-ehci" compatible string:

at91sam9g45.dtsi:                       compatible = 
"atmel,at91sam9g45-ehci", "usb-ehci";
at91sam9x5.dtsi:                        compatible = 
"atmel,at91sam9g45-ehci", "usb-ehci";
omap3.dtsi:                             compatible = "ti,ehci-omap", 
"usb-ehci";
omap4.dtsi:                             compatible = "ti,ehci-omap", 
"usb-ehci";
omap5.dtsi:                             compatible = "ti,ehci-omap", 
"usb-ehci";
sama5d3.dtsi:                   compatible = "atmel,at91sam9g45-ehci", 
"usb-ehci";
spear13xx.dtsi:                 compatible = "st,spear600-ehci", "usb-ehci";
spear13xx.dtsi:                 compatible = "st,spear600-ehci", "usb-ehci";
spear3xx.dtsi:                  compatible = "st,spear600-ehci", "usb-ehci";
spear600.dtsi:                  compatible = "st,spear600-ehci", "usb-ehci";
spear600.dtsi:                  compatible = "st,spear600-ehci", "usb-ehci";
tegra114.dtsi:          compatible = "nvidia,tegra30-ehci", "usb-ehci";
tegra114.dtsi:          compatible = "nvidia,tegra30-ehci", "usb-ehci";
tegra20.dtsi:           compatible = "nvidia,tegra20-ehci", "usb-ehci";
tegra20.dtsi:           compatible = "nvidia,tegra20-ehci", "usb-ehci";
tegra20.dtsi:           compatible = "nvidia,tegra20-ehci", "usb-ehci";
tegra30.dtsi:           compatible = "nvidia,tegra30-ehci", "usb-ehci";
tegra30.dtsi:           compatible = "nvidia,tegra30-ehci", "usb-ehci";
tegra30.dtsi:           compatible = "nvidia,tegra30-ehci", "usb-ehci";

Same for "usb-ohci":

arch/arm/boot/dts/at91rm9200.dtsi:                      compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/at91sam9260.dtsi:                     compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/at91sam9263.dtsi:                     compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/at91sam9g45.dtsi:                     compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/at91sam9n12.dtsi:                     compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/at91sam9x5.dtsi:                      compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/lpc32xx.dtsi:                 compatible = 
"nxp,ohci-nxp", "usb-ohci";
arch/arm/boot/dts/omap3.dtsi:                           compatible = 
"ti,ohci-omap3", "usb-ohci";
arch/arm/boot/dts/omap4.dtsi:                           compatible = 
"ti,ohci-omap3", "usb-ohci";
arch/arm/boot/dts/omap5.dtsi:                           compatible = 
"ti,ohci-omap3", "usb-ohci";
arch/arm/boot/dts/sama5d3.dtsi:                 compatible = 
"atmel,at91rm9200-ohci", "usb-ohci";
arch/arm/boot/dts/spear13xx.dtsi:                       compatible = 
"st,spear600-ohci", "usb-ohci";
arch/arm/boot/dts/spear13xx.dtsi:                       compatible = 
"st,spear600-ohci", "usb-ohci";
arch/arm/boot/dts/spear3xx.dtsi:                        compatible = 
"st,spear600-ohci", "usb-ohci";
arch/arm/boot/dts/spear3xx.dtsi:                        compatible = 
"st,spear600-ohci", "usb-ohci";
arch/arm/boot/dts/spear600.dtsi:                        compatible = 
"st,spear600-ohci", "usb-ohci";
arch/arm/boot/dts/spear600.dtsi:                        compatible = 
"st,spear600-ohci", "usb-ohci";

For "usb-ehci" there is even a documentation file [1], while "usb-ohci" 
seems to be undocumented.

[1] Documentation/devicetree/bindings/usb/usb-ehci.txt

Aren't they both something that should be accounted for in this series?

Best regards,
Tomasz
