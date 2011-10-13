From: khilman@ti.com (Kevin Hilman)
Date: Thu, 13 Oct 2011 14:01:43 -0700
Subject: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
	runtime API for early console
In-Reply-To: <CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
	(Govindraj's message of "Thu, 13 Oct 2011 06:52:04 +0530")
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
	<CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
	<871uuhn4kw.fsf@ti.com>
	<CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
Message-ID: <8739ewk3m0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Thu, Oct 13, 2011 at 5:30 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>>> On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrote:
>>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>>
>>>>> For the early console probing we had avoided hwmod reset and idling
>>>>> and uart was idled using hwmod API and enabled back using omap_device API
>>>>> after omap_device registration.
>>>>>
>>>>> Now since we are using runtime API's to enable back uart, move hwmod
>>>>> idling and use runtime API to enable back UART.
>>>>>
>>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>>
>>>> Now that the driver is using runtime PM. ?Why do we still need
>>>> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>>>>
>>>> The comment in the code says:
>>>>
>>>> ? ? ? ? ? ? ? ?/*
>>>> ? ? ? ? ? ? ? ? * During UART early init, device need to be probed
>>>> ? ? ? ? ? ? ? ? * to determine SoC specific init before omap_device
>>>> ? ? ? ? ? ? ? ? * is ready. ?Therefore, don't allow idle here
>>>> ? ? ? ? ? ? ? ? */
>>>>
>>>> This was true when using the 8250 driver because it was not using
>>>> runtime PM so could not know how to (re)enable the device.
>>>>
>>>> However, since the driver is now runtime PM adapted, any device access
>>>> should be contained within a runtime PM get/put block, so there should
>>>> no longer be a reason not allow the IP blocks to be reset during boot.
>>>>
>>>
>>> Forgot to add, this is still needed for
>>> earlyprintk(CONFIG_EARLY_PRINTK) use case,
>>
>> Ah, right. ?I forgot about that. ?Please update the changelog (and
>> comment in the code) to reflect that.
>>
>>> The initial boot prints until a console driver is available is from
>>> "arch/arm/kernel/early_printk.c" which does a tx on uart console
>>> and relies on configuration from bootloader.
>>>
>>> during bootup earlyprink does a tx on uart console and if ?uart driver
>>> is not available yet
>>> uart reset or idle done by hwmod layer can cause boot failures.
>>>
>>> --> put_char from earlyprintk.c
>>> ? ? ?--> reset/idle from hwmod layer
>>> ? ? ? ? ? --> put_char from earlyprintk.c
>>>
>>>
>>> So console_uart reset or clock gating must be done only after uart
>>> driver is available or be prevented using these available hwmod_flags.
>>
>> So why not leave the driver out of it and solve it like the current code
>> does?
>>
>> The current codes use the hwmod flags, then waits until the UART driver
>> is available (after omap_device_build) and uses omap_hwmod_idle() to do
>> an clean idle of the device.
>>
>> Notably this is inside a console_lock/console_unlock block so that
>> prints are buffered.
>>
>> The current code then does an omap_device_enable() to re-enable the
>> device, but you shouldn't need that after the driver is converted to
>> runtime PM.
>
> Yes similar approach here, We are not doing hwmod idle
> until console driver is available, once omap-serial is available
> from probe doing hwmod_idle* and then get_sync.

> hwmod idle in serial.c will still cause problems if ealryprintk tries
> to print until omap-uart console driver is not available, 

It will try, but note that current code takes the console_lock() during
that time, so those prints will be buffered.

> as now with rumtime adaptation only driver can enable back clocks.

I'm not sure why you're calling this "enable back clocks."  This patch
is just trying to decide where to idle the hwmod (that is, disable the
clocks.)

Re: only the driver can do it, I can think of at least 2 ways to keep
this out of the driver.

1) Use the a custom activate_func in the omap_device pm_lats struct
   to idle the first time.

2) Use a bus notifier so the device init can be notified when the
   real driver is available.  I think you're probably wanting
   the BUS_NOTIFY_BIND_DRIVER event, which would happen right
   before probe.  There's also BUS_NOTIFY_BOUND_DRIVER which
   happens right after probe.   You might actually want to use
   both.  e.g.   console_lock(); omap_hwmod_idle() in BIND
   and console_unlock() in 'BOUND'.

> So have added a function pointer to pdata which calls hwmod_idle
> implemented in serial.c calling omap_hwmod_idle.

Yes, I saw that in the patch, and that's what I don't like.

Fixing up after earlyprintk is not the responsiblity of the driver, and
the driver should not know or care whether earlyprintk was or wasn't
used before it was loaded.  This needs to be handled in device init code
as it is today.

Kevin
