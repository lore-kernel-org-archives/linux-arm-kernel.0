From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 7 Nov 2011 14:12:49 +0530
Subject: [PATCH v7 19/21] OMAP2+: UART: Use custom activate func for
 console uart.
In-Reply-To: <878vnv334f.fsf@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
 <1318952110-10659-5-git-send-email-govindraj.raja@ti.com>
 <878vnv334f.fsf@ti.com>
Message-ID: <CAAL8m4yoN0MCXSE=Y7qnpywy1m9xVsuHoPoMt6tyM_5_eTs8dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 5, 2011 at 4:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Omap-uart can be used as console uart to print early boot
>> messages using earlyprintk so for console uart prevent
>> hwmod reset or idling during bootup.
>>
>> Identify the console_uart set the id and use the custom
>> pm_latency ops for console uart for the first time
>> to idle console uart left enabled from bootup and then enable
>> them back and reset pm_latency ops to default ops.
>>
>> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
>> this approach.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c | ? 79 ++++++++++++++++++++++++++++-------------
>> ?1 files changed, 54 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index e1eba7f..55903f0 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -63,6 +63,7 @@ struct omap_uart_state {
>>
>> ?static LIST_HEAD(uart_list);
>> ?static u8 num_uarts;
>> +static u8 console_uart_id = -1;
>>
>> ?#define DEFAULT_RXDMA_POLLRATE ? ? ? ? ? ? ? 1 ? ? ? /* RX DMA polling rate (us) */
>> ?#define DEFAULT_RXDMA_BUFSIZE ? ? ? ? ? ? ? ?4096 ? ?/* RX DMA buffer size */
>> @@ -87,6 +88,29 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
>> ? ? ? },
>> ?};
>>
>> +static int console_uart_enable_hwmod(struct omap_device *od)
>> +{
>> + ? ? /* For early console we prevented hwmod reset and idle
>> + ? ? ?* So before we enable the uart clocks idle and then
>> + ? ? ?*/
>
> minor: fix multi-line comment style (search for multi-line in
> Documentation/CodingStyle). ?Another one below.
>

will correct this.

> Notice that you're moving existing code here, but also changing the
> functionality without a description as to why. ? ?Based on the existing code:
>
> You need a console_lock() here...
>
>> + ? ? omap_hwmod_idle(od->hwmods[0]);
>> + ? ? omap_hwmod_enable(od->hwmods[0]);
>
> ...and this should be omap_device_enable().
>
> And ?you need a console_unlock() here.
>
> Yes, you're subsequent patches avoid this problem, but we still need a real
> fix other than checking for 'debug/loglevel', and when that happens,
> we'll need a console lock here.
>

yes correct, we need console_lock/unlock binding here will update this.

--
Thanks,
Govindraj.R
