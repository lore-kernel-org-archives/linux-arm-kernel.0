From: Russ.Dill@ti.com (Russ Dill)
Date: Wed, 14 Aug 2013 15:21:20 -0700
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
Message-ID: <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 6:38 AM, Jan L?bbe <jlu@pengutronix.de> wrote:
> On Tue, 2013-08-13 at 15:20 -0700, Russ Dill wrote:
>> The purpose and method of executing these sequences is left up to each
>> platform. In the case of the am33xx, the CM3 firmware writes out the
>> simple I2C sequences.
>>
>> Each sequence is a series of I2C write commands. The first byte is the
>> length of the write, the second byte the I2C device to address, and
>> the following bytes are the message.
>
>>         /* Set OPP100 (1.10V) for VDD core */
>>         wake_sequence = /bits/ 8 <
>>                 0x02 0x2d 0x25 0x2b /* Set VDD2 to 1.1V */
>>         >;
>>
>>         tps: tps at 2d {
>>                 reg = <0x2d>;
>>         };
>
>> In the above example, the sequence "0x25 0x1f" is written to the I2C
>> device at address 0x2d (the TPS65910 PMIC). The PMIC interprets that
>> as a write to a register at address 0x25.
>
>> I'd really like to get some feedback on the devicetree bindings.
>
> Shouldn't the TPS driver know how to generate this sequence? It seems
> fragile to do voltage adjustments behind the back of the regulator
> framework and the TPS driver. The wake-sequence values should match the
> (in-memory) regulator configuration on resume (which may have been
> changed by DVFS).

The sequence is both PMIC specific and board specific. Additionally,
the PMICs used aren't am335x specific. It would be nice to have the
regulator framework and the driver write all this out, but the
sequence is written out by the Cortex-M3 processor running some PM
firmware. Even if the code was changed to run on the A8, it'd have to
run from a small piece of SRAM.

As far as DVFS, I'm not aware of any DVFS implementations that muck
with VDD CORE.

> The CM3 driver needs to figure out where the core regulator is connected
> using using either DT or the regulator framework and ask the TPS (via a
> new interface) for register writes for sleep/wake sequences. Then those
> sequences will actually match the correct voltages configured using
> DT/DVFS.

That seems like it'd add a lot of complexity to the regulator
subsystem, as well as all the PMIC and other I2C regulators that any
users of these device tree properties may end up using for not a lot
of gain. There would be two separate code paths for any used
I2C regulator or PMIC for setting voltages.

> Regards,
> Jan
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
