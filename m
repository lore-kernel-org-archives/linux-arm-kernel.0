From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 7 Nov 2011 14:09:01 +0530
Subject: [PATCH v7 16/21] OMAP2+: UART: Remove custom activate funcs and
 use generic funcs.
In-Reply-To: <877h3f5z0x.fsf@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
 <1318952110-10659-2-git-send-email-govindraj.raja@ti.com>
 <877h3f5z0x.fsf@ti.com>
Message-ID: <CAAL8m4y1LOhZSLGO5rJQzFxnWxi7gBsHyLfKLNuRxNB465b=rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 5, 2011 at 3:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> The custom hwmod activate and deactivate funcs does hwmod_enable
>> and idle same can be done with omap_device generic API's.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> This one needs a minor update for current mainline...
>
>> ---
>> ?arch/arm/mach-omap2/serial.c | ? 18 ++----------------
>> ?1 files changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index 7c65410..7658a03 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -78,24 +78,10 @@ static struct omap_uart_port_info omap_serial_default_info[] __initdata = {
>> ? ? ? },
>> ?};
>>
>> -static int uart_idle_hwmod(struct omap_device *od)
>> -{
>> - ? ? omap_hwmod_idle(od->hwmods[0]);
>> -
>> - ? ? return 0;
>> -}
>> -
>> -static int uart_enable_hwmod(struct omap_device *od)
>> -{
>> - ? ? omap_hwmod_enable(od->hwmods[0]);
>> -
>> - ? ? return 0;
>> -}
>> -
>> ?static struct omap_device_pm_latency omap_uart_latency[] = {
>> ? ? ? {
>> - ? ? ? ? ? ? .deactivate_func = uart_idle_hwmod,
>> - ? ? ? ? ? ? .activate_func ? = uart_enable_hwmod,
>> + ? ? ? ? ? ? .activate_func ? = omap_device_enable_hwmods,
>> + ? ? ? ? ? ? .deactivate_func = omap_device_idle_hwmods,
>> ? ? ? ? ? ? ? .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>> ? ? ? },
>> ?};
>
> If we're just using default pm_latency struct, it can be passed to
> omap_device_build as NULL, and a default one will be configured.
>

yes, will update this.

--
Thanks,
Govindraj.R
