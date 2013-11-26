From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 26 Nov 2013 18:55:52 +0100
Subject: [PATCH 5/9] ARM: at91/dt: add mmc0 slot0 support to at91rm9200ek
 board
In-Reply-To: <CACRpkdZdweyWJefttiuiYAJ9qhahLbnj7eHUiLV_83UA41X_uQ@mail.gmail.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>	<1377687995-10758-1-git-send-email-b.brezillon@overkiz.com>	<20131120145926.GE14627@ns203013.ovh.net>	<528CDFFB.1020601@overkiz.com>	<CACRpkdboBg4YOnMNiar0DDBVnoky=zNky+Pzyp1=P_POtH15qQ@mail.gmail.com>	<528DE1C4.6060900@overkiz.com>
 <CACRpkdZdweyWJefttiuiYAJ9qhahLbnj7eHUiLV_83UA41X_uQ@mail.gmail.com>
Message-ID: <5294E0A8.20303@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

Sorry for the noise, my mail was filtered by several ML because of some 
HTML contents.

Le 26/11/2013 14:46, Linus Walleij a ?crit :
> On Thu, Nov 21, 2013 at 11:34 AM, boris brezillon
> <b.brezillon@overkiz.com>  wrote:
>> On 21/11/2013 10:48, Linus Walleij wrote:
>>> No matter whether it's a switch or a GPIO regulator it seems we
>>> are in violent agreement that it should not be controlled by the
>>> pin control states at least.
>>>
>>> Start with making it a GPIO then you can figure out whether
>>> a GPIO regulator or drivers/extcon/extcon-gpio.c should be
>>> used.
>> Thanks for pointing this out. I wasn't aware of the extcon subsystem.
>>
>> Actually, I think it's a little bit more tricky.
> Hm, yeah extcon is for things like audio jacks on phones that
> userspace need to detect.
>
> drivers/input/keyboard/gpio_keys* is for things that actually
> input characters to userspace stuff.
>
> None of it is applicable here it seems ...
>
>> The switch connected to gpio PB22 is used to enable one device or the other:
>>   - PB22 set to high level enables slot0 of mmc0 (connect mmc signals to the
>> mmc
>>     connector)
>>   - PB22 set to low level enables the dataflash (connect to the SPI0 signals
>> to the
>>     dataflash device)
> So this is something like a "jumper" of the old type, configuring
> the entire system?
>
> Something like that:
> http://www.mignonette-game.com/images/v2/21-arduino-com-jumper.jpg
>
> But in this case it is a mechanical switch rather than a jumper?
Not exactly.
The functionnaly selection (spi device or mmc slot) is done by the 
software using to the
PB22 pin:
  - set PB22 pin to 1 if you want to enable the mmc slot
  - set PB22 pin to 0 if you want to enable the spi device

This is the rm9200ek board datasheet 
http://www.alliedelec.com/images/products/datasheets/bm/ATMEL/70123901.pdf, 
and you'll find the switch schematic at page 26.
Here is the switch datasheet : 
http://pdf1.alldatasheet.fr/datasheet-pdf/view/90971/PERICOM/PI5A100Q.html

If I understand correctly, you're suggesting to retrieve the PB22 pin 
value to decide
wether the mmc slot or the spi device is enabled. Is that right ?

In this case the bootstrap and/or bootloader would have to properly 
configure the P22 pin
before executing the linux kernel, and I'm pretty sure this is not the case.

> This is not much different from the GPIOs people use to e.g. encode
> the board type, just that it can change.
>
> Do people switch this thing at runtime?

In the board version this was configured in the init_machine function 
(or board init
function) depending on the MTD_AT91_DATAFLASH_CARD
( 
http://lxr.free-electrons.com/source/arch/arm/mach-at91/board-rm9200ek.c#L173).
As a result it was not reconfigurable at runtime.

But Jean-Christophe suggested to make it configurable at runtime (using 
dt fragments).

>> The pinctrl approach has the benefit of providing a transparent way (no
>> existing
>> drivers modifications) to enable one device or the other.
>>
>> But if you think this is better done (or cleaner) with an extcon or a
>> regulator device,
>> I'll try to find a way to do it this way.
> I'm uncertain. If this is something that changes at runtime, the
> input from the switch should be read through GPIO and used
> to select the "default" state of one device and something like
> "sleep" on the other (I suspect more things than pin control
> may be affected by that!)
>
> If this is a switch that you want to take the simple shortcut
> of just reading at boot, the approach would still be similar, just
> less code.
>
> So use gpio_get() to read the value, and then select which
> *entire device* goes active depending on the setting would
> be the right approach I guess?

I'm not sure these suggestions apply according to my previous answers,
but tell me if I'm wrong.

Thanks for your time and suggestions.

Best Regards,

Boris

> Yours,
> Linus Walleij
