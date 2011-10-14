From: khilman@ti.com (Kevin Hilman)
Date: Fri, 14 Oct 2011 10:12:18 -0700
Subject: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
	runtime API for early console
In-Reply-To: <CAAL8m4wgLbmm-3eqku1+0oa77_fxVoFzR1ujF9nwAQRavfqLfg@mail.gmail.com>
	(Govindraj's message of "Fri, 14 Oct 2011 19:48:51 +0530")
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
	<CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
	<871uuhn4kw.fsf@ti.com>
	<CAAL8m4wzT-ecmVeU--EQGF1PxuZuB6WZj54MmVAk-kCtFUcUSg@mail.gmail.com>
	<8739ewk3m0.fsf@ti.com>
	<CAAL8m4wgLbmm-3eqku1+0oa77_fxVoFzR1ujF9nwAQRavfqLfg@mail.gmail.com>
Message-ID: <8739evebv1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

[...]

>
> I did some study into the approaches you suggested,
> Below are my observation, Please correct me if I missed out
> any thing in my below observation,
>
>
>> 1) Use the a custom activate_func in the omap_device pm_lats struct
>> ? to idle the first time.
>>
>
> same activate func gets called for all uarts, how to determine the
> activate func. was called for first time for the given uart.
>
> (use od->pdev->dev.name strcmp with uart name for first name
> and maintain a state machine ? confused)
>
> Then should we have different activate funcs?

You would only need to install a custom activate_func for the console
UART device.  After the first call, you could set the activate_func back
to the default.

>> 2) Use a bus notifier so the device init can be notified when the
>> ? real driver is available. ?I think you're probably wanting
>> ? the BUS_NOTIFY_BIND_DRIVER event, which would happen right
>> ? before probe. ?There's also BUS_NOTIFY_BOUND_DRIVER which
>> ? happens right after probe. ? You might actually want to use
>> ? both. ?e.g. ? console_lock(); omap_hwmod_idle() in BIND
>> ? and console_unlock() in 'BOUND'.
>
> bus_register_notifier is for all drivers within the bus,
> omap-uart is registered as platform bus and there a lot more
> devices that register under platform bus,
>
> So registering the notifier for platform bus will call notifier
> for all probes withing platform bus,
>
> Is there a way to have notifier per device or given device?

The notifier callback passes the device pointer.  You just have to take
action for the devices you care about, and return for the others.

Kevin
