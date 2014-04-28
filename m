From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 28 Apr 2014 13:43:57 +0300
Subject: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
In-Reply-To: <20140425235348.GH20807@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
 <20140418155107.GB5354@atomide.com> <5358DEEA.1000506@ti.com>
 <20140425235348.GH20807@atomide.com>
Message-ID: <535E30ED.10903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/14 02:53, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140424 02:53]:
>> On 18/04/14 18:51, Tony Lindgren wrote:
>>
>>>> +	gpio = of_get_gpio(node, 0);
>>>> +	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
>>>> +		ddata->enable_gpio = gpio;
>>>> +	} else {
>>>> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
>>>> +		return gpio;
>>>> +	}
>>>
>>> We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW like
>>> gpio_backlight_probe_dt is doing. 
>>
>> Instead of doing it with the old gpio API, and checking the 'active'
>> flag everywhere, I think we can use the new gpiod API which handles the
>> polarity automatically.
>>
>> I attached prototype patches (based on -rc2) for panel dpi using that
>> approach. It's a bit messier than I'd like, because for non-DT boot we
>> need to request the gpio using the old API, and then convert it to
>> gpio_desc. We can remove that code when all the boards use DT.
>>
>> I've compiled tested this only, as I don't have DPI panels I could use.
>> I did try similar approach for TFP410, and it seemed to work fine.
> 
> Got these working by updating my test patch to use enable-gpios instead
> of gpios, and had to change from GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH.
> Are we now also breaking legacy booting by reversing the polarity?

I don't think so. The GPIOs should be active-high by default, if I'm not
mistaken, so the polarities should be the same for legacy boot with or
without those patches. Of course, I don't have the boards so I have no
idea if the polarities have been correct even before.

debugfs/gpio shows the actual value of the gpio, so you could check from
there what it is.

> In any case, looks like we have some duplicate panel code.. Turns
> out most panel dpi users for omap3 board-*.c files are just
> sharp-ls037v7dw01 panels but configured in QVGA mode. At least for
> EVM and and LDP based on looking at the pictures and the configuration

Hmm, true, board-ldp.c's panel looks very much like sharp-ls037v7dw01.

Which EVM are you talking about?

> pins (using the names kernel):
> 
> QVGA = lcd MO
> reset = lcd RESB
> ...
> 
> Then the enable_gpio should be just a GPIO controlled 3.3V regulator
> in most cases. I suggest we move them over to ls037v7dw01 and allow
> configuring them both for VGA and QVGA depending on the orientation.

Looking at the panel spec, it has the following pins:

RESB - reset
MO - VGA/QVGA
UD - vertical scanning direction
LR - horizontal scanning direction
INI - power on control

And it needs 3.3V power.

Are you saying that on some boards the gpio used for enable_gpio is
actually used to switch on a 3.3V regulator?

> I guess you do have some device with ls037v7dw01 since you've been
> patching it?

No, I don't have any boards with that panel.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/5f622a34/attachment.sig>
