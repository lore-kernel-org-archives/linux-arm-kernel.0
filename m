From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 2 Mar 2015 21:49:11 +0100
Subject: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210
 regulator quirk
In-Reply-To: <20150302183246.GA25839@katana>
References: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
 <20150302183246.GA25839@katana>
Message-ID: <CAMuHMdUa6H_GYf9p8OS+ne3YvLWzi=CNi44NGmjaWjQ080B7Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Mar 2, 2015 at 7:32 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Mar 02, 2015 at 06:28:43PM +0100, Geert Uytterhoeven wrote:
>> The r8a7791/koelsch development board has da9063 and da9210 regulators.
>> Both regulators have their interrupt request lines tied to the same
>> interrupt pin (IRQ2) on the SoC.
>>
>> After boot-up, both the da9063 and da9210 seem to assert their interrupt
>> request lines.  Hence as soon as one driver requests this irq, it gets
>> stuck in an interrupt storm, as it only manages to deassert its own
>> interrupt request line, and the other driver hasn't installed an
>> interrupt handler yet.
>>
>> To handle this, install a quirk that masks the interrupts in both the
>> da9063 and da9210.  This quirk has to run after the i2c master driver
>> has been initialized, but before the i2c slave drivers are initialized.
>>
>> On koelsch, the following happens:
>>
>>   - Cold boot or reboot using the da9063 restart handler:
>>
>>       IRQ2 is asserted, installing da9063/da9210 regulator quirk
>>       ...
>>       i2c i2c-6: regulator_quirk_notify: 1, IRQC_MONITOR = 0x3fb
>>       i2c 6-0058: regulator_quirk_notify: 1, IRQC_MONITOR = 0x3fb
>>       i2c 6-0058: Detected da9063
>>       i2c 6-0058: Masking da9063 interrupt sources
>>       i2c 6-0068: regulator_quirk_notify: 1, IRQC_MONITOR = 0x3fb
>>       i2c 6-0068: Detected da9210
>>       i2c 6-0068: Masking da9210 interrupt sources
>>       i2c 6-0068: IRQ2 is not asserted, removing quirk
>>
>>   - Warm boot (reset button):
>>
>>       rcar_gen2_regulator_quirk: IRQ2 is not asserted, not installing quirk
>>
>> Not-yet-signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Based on the schematics, I believe r8a7790/lager is also affected.
>
> Boot log from Lager (cold boot & watchdog reboot):
>
> [    0.117037] IRQ2 is asserted, installing da9063/da9210 regulator quirk
> [    0.162803] i2c i2c-4: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.163050] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
> [    0.164283] i2c i2c-5: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.164481] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
> [    0.165836] i2c i2c-6: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.166352] i2c 6-0012: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.166425] i2c 6-0012: Detected ak4643
> [    0.166891] i2c 6-0020: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.166963] i2c 6-0020: Detected adv7180
> [    0.167421] i2c 6-0039: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.167494] i2c 6-0039: Detected adv7511w
> [    0.167630] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
> [    0.168805] i2c i2c-7: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.169343] i2c 7-0058: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.169415] i2c 7-0058: Detected da9063
> [    0.169479] i2c 7-0058: Masking da9063 interrupt sources
> [    0.175641] i2c 7-0068: regulator_quirk_notify: 1, IRQC_MONITOR = 0xb
> [    0.175715] i2c 7-0068: Detected da9210
> [    0.175778] i2c 7-0068: Masking da9210 interrupt sources
> [    0.176757] i2c 7-0068: IRQ2 is not asserted, removing quirk
>
> Reboot using reset:
>
> [    0.117819] rcar_gen2_regulator_quirk: IRQ2 is not asserted, not installing quirk
>
> So, not surprisingly, no difference to Koelsch. For completeness, I disabled
> installing the notifier and got the interrupt storm again. So:
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for testing!

>> +#ifdef CONFIG_I2C
>
> Is it a realistic scenario that I2C and slave drivers are modules?

Yes.

Unfortunately that's more difficult to support, as the code references
i2c_bus_type and i2c_adapter_type.

i2c_bus_type is needed to register the notifier.
i2c_adapter_type is needed to distinguish between i2c adapters and clients,
as the notifier is called for both with action BUS_NOTIFY_ADD_DEVICE.

>> +static int regulator_quirk_notify(struct notifier_block *nb,
>> +                               unsigned long action, void *data);
>
> This forward declaration can be skipped...
>
>> +
>> +static struct notifier_block regulator_quirk_nb = {
>> +     .notifier_call = regulator_quirk_notify
>> +};
>
> ... if you move this after the notfier function.

regulator_quirk_nb and regulator_quirk_notify reference each other.
But regulator_quirk_notify() can probably just use the passed
struct notifier_block pointer. Will fix.

> Other than that the code looks okay to me (given that this is a quirk
> workaround).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
