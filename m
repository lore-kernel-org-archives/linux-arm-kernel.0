From: khilman@ti.com (Kevin Hilman)
Date: Wed, 12 Oct 2011 17:00:15 -0700
Subject: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
	runtime API for early console
In-Reply-To: <CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
	(Govindraj's message of "Wed, 12 Oct 2011 19:34:12 +0530")
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
	<CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
Message-ID: <871uuhn4kw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> For the early console probing we had avoided hwmod reset and idling
>>> and uart was idled using hwmod API and enabled back using omap_device API
>>> after omap_device registration.
>>>
>>> Now since we are using runtime API's to enable back uart, move hwmod
>>> idling and use runtime API to enable back UART.
>>>
>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>
>> Now that the driver is using runtime PM. ?Why do we still need
>> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>>
>> The comment in the code says:
>>
>> ? ? ? ? ? ? ? ?/*
>> ? ? ? ? ? ? ? ? * During UART early init, device need to be probed
>> ? ? ? ? ? ? ? ? * to determine SoC specific init before omap_device
>> ? ? ? ? ? ? ? ? * is ready. ?Therefore, don't allow idle here
>> ? ? ? ? ? ? ? ? */
>>
>> This was true when using the 8250 driver because it was not using
>> runtime PM so could not know how to (re)enable the device.
>>
>> However, since the driver is now runtime PM adapted, any device access
>> should be contained within a runtime PM get/put block, so there should
>> no longer be a reason not allow the IP blocks to be reset during boot.
>>
>
> Forgot to add, this is still needed for
> earlyprintk(CONFIG_EARLY_PRINTK) use case,

Ah, right.  I forgot about that.  Please update the changelog (and
comment in the code) to reflect that.

> The initial boot prints until a console driver is available is from
> "arch/arm/kernel/early_printk.c" which does a tx on uart console
> and relies on configuration from bootloader.
>
> during bootup earlyprink does a tx on uart console and if  uart driver
> is not available yet
> uart reset or idle done by hwmod layer can cause boot failures.
>
> --> put_char from earlyprintk.c
>      --> reset/idle from hwmod layer
>           --> put_char from earlyprintk.c
>
>
> So console_uart reset or clock gating must be done only after uart
> driver is available or be prevented using these available hwmod_flags.

So why not leave the driver out of it and solve it like the current code
does?

The current codes use the hwmod flags, then waits until the UART driver
is available (after omap_device_build) and uses omap_hwmod_idle() to do
an clean idle of the device. 

Notably this is inside a console_lock/console_unlock block so that
prints are buffered.

The current code then does an omap_device_enable() to re-enable the
device, but you shouldn't need that after the driver is converted to
runtime PM.

Kevin
