From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 21 Nov 2011 16:34:20 +0530
Subject: [PATCH v2] ARM: OMAP2+: hwmod: Add a new state to handle hwmods
 left enabled at init
In-Reply-To: <CAAL8m4xY=dRKuY697zdWaqUowyHecfC7cLRiPYNjdaCd4oau-A@mail.gmail.com>
References: <1321856114-11260-1-git-send-email-rnayak@ti.com>
 <CAAL8m4xY=dRKuY697zdWaqUowyHecfC7cLRiPYNjdaCd4oau-A@mail.gmail.com>
Message-ID: <4ECA3034.2070104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2011 03:33 PM, Govindraj wrote:
> Hi Rajendra,
>
> On Mon, Nov 21, 2011 at 11:45 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
>> enabled state by the hwmod framework post the initial setup.
>> Once a real user of the device (a driver) tries to enable it
>> at a later point, the hwmod framework throws a WARN() about
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
>>
>> Acked-by: Kevin Hilman<khilman@ti.com>
>> Acked-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>> changes in v2:
>> Fixed minor typos, removed stay change, updated comment
>> in header.
>>
>>   arch/arm/mach-omap2/omap_hwmod.c             |   15 ++++++++++++++-
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++++
>>   2 files changed, 20 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 6b3088d..72ee723 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
>>
>>         pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>>
>> +       /*
>> +        * hwmods' with HWMOD_INIT_NO_IDLE flag set, are left
>> +        * in enabled state at init.
>> +        * Now that someone is really trying to enable them,
>> +        * just update the state.
>> +        */
>> +       if (oh->_state == _HWMOD_STATE_ENABLED_AT_INIT) {
>> +               oh->_state = _HWMOD_STATE_ENABLED;
>> +               return 0;
>> +       }
>> +
>
> one issue returning from here without doing
> omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>
> causes hmux->enabled to be false after first _enable (get_sync)
>
> and for first _idle(put/put_sync)
>
> omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
> will not happen and will not enable rx_pad wake-up for uart.
> so this is causing wake-up failures from off mode.

Ok, so this looks like is something that happens additionally
with a driver-enable, which does not happen as part of the
framework-enable (as part of setup).
Thanks for digging it up.

An easy way to fix it would be to handle the muxing along with the
state change..

if (oh->_state == _HWMOD_STATE_ENABLED_AT_INIT) {
	/*
	 * If the caller has mux data populated, do the mux'ing
	 * which wouldn't have been done as part of the _enable()
	 * done during setup.
	 */
	if (oh->mux)
		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
	oh->_state = _HWMOD_STATE_ENABLED;
	return 0;
}

Will respin with the changes, and hopefully this should fix the wakeup
issues from OFF.

>
