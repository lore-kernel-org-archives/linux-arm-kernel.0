From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 30 Jun 2011 20:40:40 +0300
Subject: kernel panic in spi_complete() on spitz (PXA270)
In-Reply-To: <1309450406.4406.59.camel@oct.suse.cz>
References: <1308845380.4533.54.camel@oct.suse.cz>	
	<201106301352.21684.marek.vasut@gmail.com>	
	<1309445118.4406.47.camel@oct.suse.cz>
	<4E0C957F.8080807@compulab.co.il>
	<1309450406.4406.59.camel@oct.suse.cz>
Message-ID: <4E0CB518.2080703@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/11 19:13, Stanislav Brabec wrote:

> Igor Grinberg wrote:
>> On 06/30/11 17:45, Stanislav Brabec wrote:
>> I want to
>>> add .needs_regulator bool to ads7846.c and send the patch again to the
>>> list.
>> Please, don't...
>> I thought we've finished discussing the regulator issue...
> The discussion ended without a fix (at least for spitz).

Well, the discussion was mainly about how the regulator API should be used.
The proposed patch, used the regulator API incorrectly.
If I recall correctly, in the end of the discussion,
Mark provided another option for configuring the regulator API,
which is number 3 below.

>  I seen two
> proposals:
> - As ADS7846 hardware does not require dedicated regulator, don't
>   require it in driver and fail only on platforms that have a dedicated
>   regulator.

The thing is that ads7846 chip itself just requires power supply
(as most of the peripheral chips), the one who decides if it will be switchable
is the board vendor and the vendor may use any source for the power supply.
It can be fixed, it can be some kind of discrete LDO or one of the power
supplies coming from the system PMIC.
The ads7846 driver provides the regulator functionality via the regulator API
and it is up to board code to provide the appropriate regulator definitions or
configure the regulator API so the ads7846 will function correctly.

> - Use dummy regulators for all platforms without dedicated ADS7846
>   regulator.

IMO, this is the right way.

>> 1) add regulator definition for ads7846 into the board file
> There is no dedicated regulator on spitz, ADS7846 uses common always-on
> power supply.

Mark,

Is there a kind of regulator for this case (except dummy)?
Some kind of fixed regulator which is not binded to any supply?

>> 2) enable the CONFIG_REGULATOR_DUMMY in your kernel configuration
>> 3) use regulator_use_dummy_regulator() call in the board file.
> OK, I will do 2 or 3. In the new kernel spitz has a regulator, but it is
> not related to ADS7846. And it is actually broken:
>
> I2C: i2c-0: PXA I2C adapter
> Resetting I2C Controller Unit
>  (null): i2c_pxa_abort: called in slave mode
> i2c i2c-1: adapter [pxa_i2c-i2c.1] registered
> i2c 1-000c: uevent
> isl6271a 1-000c: probe
> i2c i2c-1: master_xfer[0] R, addr=0x0c, len=1
> i2c i2c-1: setting to bus master
> i2c i2c-1: state:i2c_pxa_handler:981: ISR=00000442, ICR=000007e0, IBMR=03
> i2c i2c-1: state:i2c_pxa_irq_txempty:932: ISR=00000002, ICR=000007e0, IBMR=03
> i2c i2c-1: Retrying transmission
> i2c i2c-1: setting to bus master
> i2c i2c-1: state:i2c_pxa_handler:981: ISR=00000045, ICR=000007e1, IBMR=00
> i2c i2c-1: state:i2c_pxa_irq_txempty:932: ISR=00000005, ICR=000017ee, IBMR=00
> i2c i2c-1: state:i2c_pxa_handler:981: ISR=00000087, ICR=000017e6, IBMR=00
> print_constraints: vcc_core range: 850 <--> 1600 mV at 1350 mV 
> print_constraints: vcc_core range: 1100 mV 
> isl6271a 1-000c: Failed to set supply vcc_core
> isl6271a 1-000c: failed to register isl6271a
> isl6271a: probe of 1-000c failed with error -16
> i2c i2c-1: client [isl6271a] registered with bus id 1-000c
> I2C: i2c-1: PXA I2C adapter
> ...
> cpufreq: Didn't find vcc_core regulator

This looks like the regulator definitions for spitz are broken and need to be fixed.

-- 
Regards,
Igor.
