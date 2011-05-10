From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2011 01:15:12 +0200
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <20110510214518.GB5315@n2100.arm.linux.org.uk>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110502225708.GD28001@n2100.arm.linux.org.uk>
	<BANLkTikSwkYEvbQ8XVrB3LUetVqBBUjT2g@mail.gmail.com>
	<20110510214518.GB5315@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinhDWsZuUdeNObSOmsS2_ES9G3Bww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, May 10, 2011 at 11:25:44PM +0200, Linus Walleij wrote:
>> It can, basically:
>>
>> struct pinmux *pmx;
>>
>> pmx = pinmux_get(dev, "irda-uart");
>> pinmux_enable(pmx);
>> (... SIR UART operations ...)
>> pinmux_disable(pmx);
>> pinmux_put(pmx);
>> (... stuff to init FIR silicon ...)
>> pmx = pinmux_get(dev, "irda-fir");
>> pinmux_enable(pmx);
>> (... etc ...)
>
> You really don't want to do this. ?It's not that SIR and FIR are that
> exclusive. ?You only switch to FIR mode when you've negotiated in SIR
> mode, and then there's tight timings for doing that. ?Essentially you
> agree in SIR mode to switch to FIR mode, switch to FIR mode and expect
> a response in FIR mode from the remote end.
>
> Calling out to lots of functions to perform the switch is asking for
> that response to be missed because you've not set things up for it.
>
> You'd want to have SIR and FIR mode 'got', and then switch as quickly
> as possible between them.

Sorry I might have got things backwards here, let me see if I got it:

Either the SIR and FIR modes use the exact same pins albeit pushing
in a differnt silicon block to control them without any side-effects.
In that case from the pinmux API point of view there is no conflict,
since there is no competition for using the same pins, the pinmux API
get/put is about resolving such conflicts.

So if we want to use the pinmux_enable()/disable() to quickly poke
some bit to switch between these two, I could think about things like
encoding the pins in the first setting and not encoding any pins at
all in the second one and then they can both be be get/put without
conflicting, and the only possible conflict would be if you tried
to enable both at the same time and this can be handled by the
specific pinmux driver.

Albeit not elegant, it works for this scenario.

A more elegant way is that I supply the same custom configuration
extension mechanism for pinmux as for GPIO, similar to ioctl()
like so:

pmx = pinmux_get(dev, "irda-sir-fir");
pmx_enable(pmx);
/* Unless the first enablement implies SIR mode */
pmx_config(pmx, PINMUX_CONFIG_CUSTOM_SIR, NULL);
(... negotiated ...)
pmx_config(pmx, PINMUX_CONFIG_CUSTOM_FIR, NULL);
(...)
pmx_disable(pmx);
pmx_put(pmx);

I planned to add this interface anyway (needed for pin biasing and
such fun stuff), so I'll poke it in.

The latter would be analog to suppling an enumerated "what" to
the pinmux_enable() function, if it turns out to be an everyday
thing we can think about a more generic extension like
pinmux_enable_selector(struct pinmux *pmx, unsigned selector);
in the API but I feel the above will cut it just as fine.

Yours,
Linus Walleij
