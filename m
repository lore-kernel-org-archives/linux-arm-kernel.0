From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 12 Oct 2011 19:34:12 +0530
Subject: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with
	runtime API for early console
In-Reply-To: <87pqi3z19z.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	<87pqi3z19z.fsf@ti.com>
Message-ID: <CAAL8m4xmGQaQZm5Oz8B5e6Mt7VP7c_VwQ=AnfpKotZRci32JiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 2:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> For the early console probing we had avoided hwmod reset and idling
>> and uart was idled using hwmod API and enabled back using omap_device API
>> after omap_device registration.
>>
>> Now since we are using runtime API's to enable back uart, move hwmod
>> idling and use runtime API to enable back UART.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Now that the driver is using runtime PM. ?Why do we still need
> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?
>
> The comment in the code says:
>
> ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? * During UART early init, device need to be probed
> ? ? ? ? ? ? ? ? * to determine SoC specific init before omap_device
> ? ? ? ? ? ? ? ? * is ready. ?Therefore, don't allow idle here
> ? ? ? ? ? ? ? ? */
>
> This was true when using the 8250 driver because it was not using
> runtime PM so could not know how to (re)enable the device.
>
> However, since the driver is now runtime PM adapted, any device access
> should be contained within a runtime PM get/put block, so there should
> no longer be a reason not allow the IP blocks to be reset during boot.
>

Forgot to add, this is still needed for
earlyprintk(CONFIG_EARLY_PRINTK) use case,

The initial boot prints until a console driver is available is from
"arch/arm/kernel/early_printk.c" which does a tx on uart console
and relies on configuration from bootloader.

during bootup earlyprink does a tx on uart console and if  uart driver
is not available yet
uart reset or idle done by hwmod layer can cause boot failures.

--> put_char from earlyprintk.c
     --> reset/idle from hwmod layer
          --> put_char from earlyprintk.c


So console_uart reset or clock gating must be done only after uart
driver is available or be prevented
using these available hwmod_flags.

omap_serial_early_init should be now be binded with CONFIG_SERIAL_OMAP macro ?

--
Thanks,
Govindraj.R
