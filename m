From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 18 Nov 2011 12:14:32 +0530
Subject: [PATCH] ARM: omap_hwmod: Add a new state to handle hwmods left
 enabled at init
In-Reply-To: <87fwhm4k5s.fsf@ti.com>
References: <1321524690-10302-1-git-send-email-rnayak@ti.com>
 <87fwhm4k5s.fsf@ti.com>
Message-ID: <4EC5FED0.3000202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Friday 18 November 2011 01:05 AM, Kevin Hilman wrote:
> Rajendra Nayak<rnayak@ti.com>  writes:
>
>> A hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
>> enabled state by the hwmod framework post the initial setup.
>> Once a real user of the device (a driver) tries to enable it
>> at a later point, the hmwod framework throws a WARN() about
>> the device being already in enabled state.
>>
>> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
>> to identify such devices/hwmods, so nothing but just a state
>> change to '_HWMOD_STATE_ENABLED' can be done when the device/hwmod
>> is requested to be enabled (the first time) by its driver/user.
>>
>> A good example of a such a device is an UART used as debug console.
>> The UART module needs to be kept enabled through the boot, until the
>> UART driver takes control of it, for debug prints to appear on
>> the console.
>
> Nice.  This is indeed much cleaner than what we're doing in the UART
> code.  However...
>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c             |   16 ++++++++++++++--
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index d7f4623..7d94cc3 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
>>
>>   	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>>
>> +	/*
>> +	 * hwmods' with HWMOD_INIT_NO_IDLE flag set, are left
>
> (no the ' isn't necessary)
>
>> +	 * in enabled state at init.
>> +	 * Now that someone is really trying to enable them,
>> +	 * just update the state.
>> +	 */
>> +	if (oh->_state == _HWMOD_STATE_ENABLED_AT_INIT) {
>> +		oh->_state = _HWMOD_STATE_ENABLED;
>> +		return 0;
>> +	}
>
> ...this subtly changes the behavior, at least compared to how the UART
> code handles this today.
>
> One thing that this doesn't do that the current UART code does is ensure
> that the IP is actually in a state that can properly idle after this is
> done.
>
> For example, if the bootloader is dumb (most are) and has configured the
> UARTs in mode that prevents idle (e.g. no-idle mode), then these UARTs
> will never allow the SoC to hit low power states.
>
> So, what's really needed is not just a return here, but an _idle() and
> then continue so we know that the HW is in a state that we know can
> idle from here on out.

I don't know if I completely understand what you are saying.
The above change is in the _enable() call which would be triggered
as part of runtime call from the serial driver to enable the module.
(Since the module is already enabled, you just change state to suggest
its now enabled by its user, rather than 'left enabled' at init)
There would be another call from the serial driver to idle it when
a corresponding hwmod _idle() call would idle the device.
I don't seem to understand why would a call to _idle() be needed
in an _enable() call.

regards,
Rajendra

>
> Kevin
