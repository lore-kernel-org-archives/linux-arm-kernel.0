From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 21 Oct 2016 17:24:36 +0200
Subject: [PATCH 0/4] ARM: boot: mxs: Add On-Chip RAM
In-Reply-To: <20161021150336.GJ30578@tiger>
References: <1473789066-8955-1-git-send-email-stefan.wahren@i2se.com>
 <20161021135343.GI30578@tiger>
 <9bf7c925-bdc2-d0b8-9886-70d46383d1e0@i2se.com>
 <20161021150336.GJ30578@tiger>
Message-ID: <e472fb62-00d2-359d-2126-ce2727fe3bed@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.10.2016 um 17:03 schrieb Shawn Guo:
> On Fri, Oct 21, 2016 at 04:05:59PM +0200, Stefan Wahren wrote:
>> Am 21.10.2016 um 15:53 schrieb Shawn Guo:
>>> On Tue, Sep 13, 2016 at 05:51:02PM +0000, Stefan Wahren wrote:
>>>> The i.MX23 / i.MX28 have a small amount of On-Chip RAM which is also necessary
>>>> for suspend to RAM and standby mode. But before we need to remove the fake reg
>>>> properties of all internal bus nodes as discussed in this thread [1].
>>>>
>>>> This patch series requires Fabio Estevam's recent series "ARM: dts: imx23:
>>>> Remove skeleton.dtsi inclusion" [2].
>>>>
>>>> [1] - https://marc.info/?l=devicetree&m=146139948426520&w=2
>>> The page cannot be reached.  I would like to understand the
>>> background for this change.
>> Strange, because i don't have any problems while clicking on the URL.
>>
>> It's an older discussion on the devicetree / kernel newbie mailing list
>> with subject "strange dtc errors after adding sram node". Arnd suggested
>> in the discussion to remove the reg property from the ahb node.
>>
>> Please try this one: http://www.spinics.net/lists/newbies/msg57652.html
> If you go through 'Table 4-1. Address Map for i.MX28' of MCIMX28RM, you
> should be able to find there are 3 AHB buses: ahb at 0, ahb at 80080000 and
> ahb at c0000000.  The ocram goes to ahb at 0.  The following change should be
> the right one for ocram addition.

Correct me if i'm wrong, but there is only one AHB bus and only the
connected peripheral devices like ocram or USB controller have a memory
mapped start address not the bus itself.

>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 0ad893bf5f43..8e5718df06b2 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -47,6 +47,19 @@
>                 };
>         };
>  
> +       ahb at 0 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0x0 0x80000000>;
> +               ranges;
> +
> +               ocram: sram at 0 {
> +                       compatible = "mmio-sram";
> +                       reg = <0x0 0x20000>;
> +               };
> +       };
> +
>         apb at 80000000 {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
>
