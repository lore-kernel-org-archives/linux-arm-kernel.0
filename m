From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 9 Nov 2015 17:00:46 +0100
Subject: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
In-Reply-To: <20151109144030.GD15706@odux.rfo.atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
 <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
 <20151109132305.GC15706@odux.rfo.atmel.com>
 <CAPDyKFrTTEnSFNvmx3e__Ap9gOGpA2-bz+yrq7ibz0wXGSWCXA@mail.gmail.com>
 <20151109144030.GD15706@odux.rfo.atmel.com>
Message-ID: <CAPDyKFquZ+_Rf07gX+i-=_bzSa7KJ5+xQ8N21kK2mvfMGdVQMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2015 at 15:40, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Mon, Nov 09, 2015 at 03:12:46PM +0100, Ulf Hansson wrote:
>> On 9 November 2015 at 14:23, Ludovic Desroches
>> <ludovic.desroches@atmel.com> wrote:
>> > On Fri, Nov 06, 2015 at 04:59:29PM +0100, Ludovic Desroches wrote:
>> >> When there is a vmmc regulator, only SD Bus Power is set to 1 in the
>> >> Power Control Register. It means SD Bus Voltage Select field is set to 0
>> >> that is a reserved value. The SD Host Controller specification says:
>> >> 'SD Bus Power: Before setting this bit, the SD Host Driver shall set SD
>> >> Bus Voltage Select.' and 'If the Host Driver selects an unsupported
>> >> voltage in the SD B?us Voltage Select field, the Host Controller may
>> >> ignore writes to SD Bus Power and keep its value at zero."
>> >>
>> >> Having an external regulator means the SD Bus Voltage Select is useless
>> >> but if the Host Controller strictly follows the specification then we
>> >> need to set a valid value.
>> >
>> > Ulf,
>> >
>> > What is your opinion about this patch?
>> >
>> > If the 'no regulator found' message is turned in debug message, I can get
>> > rid of my vmmc regulator but I really think that writing only
>>
>> I expect you mean vqmmc?
>
> I don't mean vmmc. In the sdhci_set_power function, we are using vmmc.
> I feel not confortable with it because the power control register
> contains 'SD Bus' fields so it should depend on vqmmc not vmmc.
>
>>
>> > SDHCI_POWER_ON is opposite to the sdhci spec. I would say that not
>> > setting the bus voltage is a quirk!
>>
>> I don't really follow.
>>
>> I read the SDHCI spec and the section for the Power Control Register.
>> Bit 0 needs to be set when communicating with the card as it will for
>> example enables the clock. Before setting bit0 you must decide what
>> signal level to use, which is done by writing to bit 1->3.
>>
>
> Right. But when having vmmc supply we do:
> sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL) or
> sdhci_writeb(host, 0, SDHCI_POWER_CONTROL) so we loose the signal level,
> isn't it?
>
>> If SDHCI monitors the power state (MMC_POWER_UP|ON|OFF) when its
>> ->set_ios() callback are invoked and in combination of using the
>> ->start_signal_voltage_switch() callback to change the signal voltage
>> level, this *should* work out nicely.
>>
>
> It is my turn to not follow! We write into the Power Control Register
> only in sdhci_set_power(). May I miss a callback or something else?
> sdhci_do_start_signal_voltage_switch doesn't modify the Power Control
> Register.
>
>> Now, looking at the related code in sdhci, I am kind of surprised that
>> it works. :-) Though, again I don't have the in-depth knowledge about
>> sdhci.
>>
>
> Me too, I am starting to dig into the sdhci spec and some points are
> not crystal clear.
>

Okay, I am finally starting to understand some of your concern.

According to the spec, the Power Control Register should control the
signal voltage/bus voltage. As UHS mode was added to the spec, it
seems like the Power Control Register couldn't cover all new cases, as
why Host Control 2 register needed to be added. The Host Control 2
register, is what sdhci_do_start_signal_voltage_switch() uses to
change the signal voltage level, which all makes sense to me.

For sdhci_set_power(); it seems to use the Power Control Register to
control the power to the card (VDD/VMMC). Indeed this looks *really*
weird/wrong. I wonder if it's working because of luck, intentional
violation of the SDHCI spec or because of special variants.

Especially when looking into the case when you *don't* have a VMMC
regulator several strange quirks exists in sdhci_set_power().

In the case when you *have* a VMMC, I think just setting/clearing bit
0 (SDHCI_POWER_ON) and then bail out, is probably working with modern
HW because it's likely the only thing needed.

Now, this discussion was interesting, but I forgot what problem you
actually where trying to solve? :-)

Kind regards
Uffe
