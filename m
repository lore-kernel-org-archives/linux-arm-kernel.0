From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 12 Oct 2011 19:08:51 +0530
Subject: [PATCH v6 10/16] OMAP2+: UART: Modify omap_uart_can_sleep function
In-Reply-To: <87vcrv2xox.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<87vcrv2xox.fsf@ti.com>
Message-ID: <CAAL8m4xTmz+-ureDiGPoKUu634q1Wy=h01kpfRWCk9LFCV0+Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 11:54 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Modify the omap_uart_can_sleep function to check uart is active
>> or not to be used by pm code to enter low power states.
>
> Doesn't the driver now control when the UART clocks are gated (using
> runtime PM autosuspend)?
>
> IMO, this check should be completely removed and the driver should
> be managing this with the autosuspend timeout.
>
>> Removing this check can cause console response little sluggish.
>
> Sluggish in what way?
>

response is slower like when we type something or cat debugfs/pm_count
see things little slower on console, there is no character loss.

Happens even though we have not set the autosuspend timeout and uart
clocks are active,
which basically means allowing mpu to enter retention keeping uart active.

this delay in response or sluggishness is not there on my 3430SDP or
3630zoom board but I was able to see this behavior on a beagle board(xm rev c).

retaining this uart_can_sleep check in omap3_can_sleep ensures a better
console user experience. (not allowing mpu to enter retention
until uart clocks are cut)


> If the driver is runtime suspended, it should only be sluggish for the
> first character. ?After that, the autosuspend timeout should prevent it
> from feeling sluggish.
>
>> However no characters will be lost until uart clocks are gated
>> and woken up using rx-pad. UART interface clocks can be auto gated
>> this can make response on uart slower. This behaviour was observed
>> only on some of OMAP3 boards(beagleboard xm rev c).
>>
>> Reported-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c | ? 21 +++++++++------------
>> ?1 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index 6725caf..ccf3550 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -156,23 +156,20 @@ static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
>>
>> ?int omap_uart_can_sleep(void)
>> ?{
>> - ? ? struct omap_uart_state *uart;
>> - ? ? int can_sleep = 1;
>> -
>> - ? ? list_for_each_entry(uart, &uart_list, node) {
>> - ? ? ? ? ? ? if (!uart->clocked)
>> - ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? struct omap_hwmod *oh;
>> + ? ? u8 i, ret = true;
>>
>> - ? ? ? ? ? ? if (!uart->can_sleep) {
>> - ? ? ? ? ? ? ? ? ? ? can_sleep = 0;
>> + ? ? for (i = 0; i < num_uarts; i++) {
>> + ? ? ? ? ? ? oh = omap_uart_hwmod_lookup(i);
>
> This is a heavy operation to add for *every* entry into idle.
>

removing uart_list caused this ops, retaining uart_list
will ensure this will be replaced with list_for_each_entry
as done in existing code.

--
Thanks,
Govindraj.R
