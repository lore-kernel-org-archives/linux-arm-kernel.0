From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 21 Sep 2010 13:05:57 -0700
Subject: [PATCH 00/11] OMAP: Serial: Add omap-serial driver with platform
	support
In-Reply-To: <AANLkTinqiknLaBmMj17fi31TsZ+eaSkCcgd-wbQvMpz-@mail.gmail.com>
	(Govindraj's message of "Tue, 21 Sep 2010 21:07:29 +0530")
References: <13965.10.24.255.18.1284739547.squirrel@dbdmail.itg.ti.com>
	<87tylorl9i.fsf@deeprootsystems.com>
	<AANLkTik-+RC7y=dJnDdxzrqMFnTzRV-j8s5FtmMy8ZhE@mail.gmail.com>
	<87wrqg2xog.fsf@deeprootsystems.com>
	<AANLkTinqiknLaBmMj17fi31TsZ+eaSkCcgd-wbQvMpz-@mail.gmail.com>
Message-ID: <87lj6uj1zu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> <SNIP>
>
>>>>> Also the patch series updates various low level platform specific
>>>>> serial data to support omap-uarts with hwmod framework and adds support
>>>>> for uart4 on OMAP3630.
>>>>
>>>> This series is missing a couple things to work more broadly on all
>>>> boards, specifically 3630-based boards.
>>>>
>>>> First, due to the current UART idle code base, you need to enable all
>>>> OMAP UARTs 36xx. ?Enabling less than all OMAP UARTs will break the
>>>> current idle code. ?As we discussed, the next phase we will move the
>>>> idle management from this serial.c hackery into the omap-serial driver
>>>> iteself. ?Until then, you need to call omap_serial_init() on
>>>> Zoom2/Zoom3. ?Patch below[1]
>>>>
>>>> Also, you previously had a patch that updated omap_uart_idle_init() to
>>>> handle 36xx and specifically UART4. ?Without that, struct
>>>> omap_uart_state is not setup correctly for UART4, and thus cannot be
>>>> properly idled on 3630.
>>>
>>> ok fine, I will I incorporate initialize all uarts patch for zoom boards.
>>>
>>> Are you referring to this patch?
>>> https://patchwork.kernel.org/patch/108066/
>>>
>>> Is this still needed if we have initialized all uarts?
>>> This patch might not needed if we have initialized all uarts right?
>>
>> Right. ?We don't need the above patchwork patch if all UARTs are
>> initialized.
>>
>> The other patch I was referring to was the one that added UART4 support
>> to omap_uart_idle_init() (added the wk_en, wk_st, padconf etc.) ?I had a
>> pending request for you to drop the muxmode from that patch, but the
>> rest of it was still needed.
>>
>>>>
>>>> Also, it's been a while since I tested this on OMAP2. ?Please re-test on
>>>> OMAP2 with the whole series. ?Also, please report here the other
>>>> platforms this was tested on. ?The final needs to be tested on OMAP2, 3
>>>> and 4 before merge.
>>>
>>> Yes Sure,
>>>
>>> Just FYI this patch series was also tested on omap2,3,4.
>>>
>>
>> OK, be sure to test Zoom3, because my testing on Zoom3 led to a crash as
>> soon as idle was enabled due to the missing init of all UARTs.
>
>
> This patch series applied on top of pm-core branch
>
> commit 4c1f85cdc189d41ee53c1bc3957a908c91cffc00
> Merge: ca1684b 96c4e27
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Thu Sep 16 15:29:06 2010 -0700
>
> with below changes:
>
> 1) if (uart->timeout)
>                 uart->timeout = (30 * HZ);
>
> 2) #define DEFAULT_TIMEOUT 5 [temporary change for timeout]

Doing this masks the problem.  If you do 1 without 2, you'll see that
UART4 can never go idle.

Please test without this change and use the sysfs files to enable the
timeouts:

  echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout 
  echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout 
  echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout 
  echo 5 > /sys/devices/platform/omap/omap-hsuart.3/sleep_timeout 

> I see ret count getting incremented on ZOOM3 even without "UART4 support
> to omap_uart_idle_init()" patch.
>
> I dont see any crash.

It has to do more than not crash for this to be acceptable.   All UARTs
need to have the same capabilities.

Currently, UART4 has no padconf, wk_en, or wk_st fields set.  This means
1) it's sysfs entry  doesn't get a 'sleep_timeout' file so it cannot be
made changed and 2) wakeups on UART4 cannot work.

As I said before, you had all this stuff in a previous series.  I only
requested you drop the 'muxmode' stuff from that patch, but everything
else (padconf, wk_en, wk_st) was fine.

Please add this back to the series.

Kevin
