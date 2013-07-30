From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 29 Jul 2013 20:30:29 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <1706112.Xn49tiCSKF@thinkpad>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
Message-ID: <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 6:45 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 29 of July 2013 18:23:30 jonsmirl at gmail.com wrote:
>> The schema should enforce some kind of regularity into the description
>> of similar devices.  Take SPI for example. I pulled these SPI
>> controller definitions from the kernel source. Obviously all of these
>> controllers are different, but it seems to me that their definitions
>> could be made more regular. DMA seems like it could use a lot of help.
>
> Well, there is not much in common in bindings for all those SPI controllers,
> other than general device attributes, such as compatible and reg (not even
> interrupts - see spi-gpio).

I went and read a little about some of those SPI controllers. I
suspect everyone of these controllers could be mapped into a common
SPI controller schema.

Things like:
num-cs
ti,spi-num-cs

should have the same name.
The description of hardware SPI CS vs GPIOs being used for CS could be
unified too.

This...
tx-dma-channel = <&pdma0 7>; /* preliminary */
rx-dma-channel = <&pdma0 6>; /* preliminary */

Probably should be
dmas = <&pdma0 7>,<&pdma0 6>;
dma-names = "tx", "rx";

With a generic schema as a guide all of these controllers can be
described using the same syntax.

>
> There is a lot of generic binding templates (as I called this kind of bindings
> in my first mail) involved here, though.
>
> Taking one of the controllers as the example:
>> spi0: spi at f0000000 {
>> #address-cells = <1>;
>> #size-cells = <0>;
>> compatible = "atmel,at91rm9200-spi";
>> reg = <0xf0000000 0x100>;
>> interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
>
> /inherit/ "interrupts.dtss", 1;
>
>> dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(1)>,
>>       <&dma0 1 AT91_DMA_CFG_PER_ID(2)>;
>> dma-names = "tx", "rx";
>
> /inherit/ "dma.dtss", "tx", "rx";
>
>> pinctrl-names = "default";
>> pinctrl-0 = <&pinctrl_spi0>;
>
> /inherit/ "pinctrl.dtss","default";
>
>> status = "disabled";
>> };
>
> Best regards,
> Tomasz
>



-- 
Jon Smirl
jonsmirl at gmail.com
