From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 12 Sep 2011 12:25:41 +0530
Subject: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for
	omap-serial driver
In-Reply-To: <8739g5y45m.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-8-git-send-email-govindraj.raja@ti.com>
	<87obyu36lo.fsf@ti.com>
	<CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
	<8739g5y45m.fsf@ti.com>
Message-ID: <CAAL8m4zR06U115V52+fT84dc6g7PYkLb1jJaMKGyi2VJhFtYxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2011 at 11:44 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Fri, Sep 9, 2011 at 5:54 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>>> Adapts omap-serial driver to use pm_runtime API's.
>>>>
>>>> 1.) Moving context_restore func to driver from serial.c
>>>> 2.) Use runtime irq safe to use get_sync from irq context.
>>>> 3.) autosuspend for port specific activities and put for reg access.
>>>
>>> Re: autosuspend, it looks like the driver now has 2 mechanisms for
>>> tracking activity. ?The runtime PM 'mark last busy' and the existing
>>> 'up->port_activity = jiffies' stuff. ?Do you think those could be
>>> unified?
>>>
>>
>> Is there a way where we can retrieve the last busy jiffie value
>> using runtime API? I don't find that available.
>>
>
> Not currently. ?The question is more along the lines of: what is the
> port_activity jiffies used for, and can it be replaced by using
> _mark_last_busy().
>
> If it cannot, that's fine, but it should be described.

Okay.

>
>>> At first glance, it looks like most places with a _mark_last_busy() also
>>> have a up->port_activity update. ?I'm not familiar enough with the
>>> driver to make the call, but they look awfully similar.
>>>
>>
>> Ok, I will check whether I can get rid if it.
>>
>>>> 4.) for earlyprintk usage the debug macro will write to console uart
>>>> ? ? so keep uart clocks active from boot, idle using hwmod API's re-enable back
>>>> ? ? using runtime API's.
>>>
>>> /me doesn't understand
>>
>> I have added this reason in early mail reply to 04/11 patch review
>> [needed for earlyprintk option from low level debug ]
>
> OK, but AFAIK, DEBUG_LL + earlyprintk do not use this driver. ?Instead
> they use the debug macros, so any hacks to deal with that do not belong
> in the driver.
>
> If there are hacks required, they should be in a separate patch, with a
> separate descriptive changelog.
>

Yes these are required, because early printk relies on clocks from bootloader
and if clocks are gated even before console_driver is available it can
lead to boot failures.

I can keep that part as a separate patch.


>>>
>>>> 5.) Moving context restore to runtime suspend and using reg values from port
>>>> ? ? structure to restore the uart port context based on context_loss_count.
>>>> ? ? Maintain internal state machine for avoiding repeated enable/disable of
>>>> ? ? uart port wakeup mechanism.
>>>> 6.) Add API to enable wakeup and check wakeup status.
>>>>
>>>> Acked-by: Alan Cox <alan@linux.intel.com>
>>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>> ---
>>>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 49 ++++++
>>>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? 10 ++
>>>> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ?211 ++++++++++++++++++++++---
>>>> ?3 files changed, 250 insertions(+), 20 deletions(-)
>>>>
>>
>> [..]
>>
>>>> +
>>>> +static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
>>>> +{
>>>> + ? ? struct omap_device *od;
>>>> + ? ? struct omap_uart_port_info *up = pdev->dev.platform_data;
>>>> +
>>>> + ? ? /* Set or clear wake-enable bit */
>>>> + ? ? if (up->wk_en && up->wk_mask) {
>>>> + ? ? ? ? ? ? u32 v = __raw_readl(up->wk_en);
>>>> + ? ? ? ? ? ? if (enable)
>>>> + ? ? ? ? ? ? ? ? ? ? v |= up->wk_mask;
>>>> + ? ? ? ? ? ? else
>>>> + ? ? ? ? ? ? ? ? ? ? v &= ~up->wk_mask;
>>>> + ? ? ? ? ? ? __raw_writel(v, up->wk_en);
>>>> + ? ? }
>>>> +
>>>> + ? ? od = to_omap_device(pdev);
>>>> + ? ? if (enable)
>>>> + ? ? ? ? ? ? omap_hwmod_enable_wakeup(od->hwmods[0]);
>>>> + ? ? else
>>>> + ? ? ? ? ? ? omap_hwmod_disable_wakeup(od->hwmods[0]);
>>>> +}
>>>> +
>>>
>>> Here again, this is difficult to review because you removed the code in
>>> [4/11] and add it back here, but with rather different functionality
>>> with no description as to why.
>>>
>>
>> will move this change as part of 4/11 itself.
>>
>
> The point was not just that the move was confusing, but that you changed
> the functionality along with the move without any description.
>

If are referring to uart rx pad wakeup its still retained but done
using mux framework.

>>> The previous version enabled wakeups at the PRCM and at the IO ring.
>>> This version enables wakeups at the PRCM as well but instead of enabling
>>> them at the IO ring, enables them at the module.
>>>
>>
>> Since we are gating using prepare idle call I think
>> we can use this enable wake-up call as part of prepare idle call itself,
>> as done earlier.
>
> Not sure what that has to with my comment.
>
> In moving this code, you removed the enable/disable of IO ring wakeups.
> It probably continues to work because they're enabled by the bootloader,
> but that is not correct and the driver should be managing the IO ring
> wakeups as before.
>

Prior to this we used io-pad offsets address and modified to enable wakeup
mechanism, But since we received some comments from Tony to use mux framework
for any mux changes, I removed using mux address and use mux framework from
hwmod, I have not removed rx-pad wakeup still enable io-pad wakeup.
otherwise wakeup from off-mode will fail on 3430SDP.

omap_uart_wakeup_enable
    --> omap_hwmod_enable_wakeup
           --> omap_hwmod_enable_ioring_wakeup [PATCH v4 01/11]
OMAP2+: hwmod: Add API to enable IO ring wakeup.]

boot-loaders doesn't enable io pad wakeup for uart.


> [...]
>
>>>> ?}
>>>>
>>>> ?static int __init
>>>> @@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg = {
>>>> ? ? ? .cons ? ? ? ? ? = OMAP_CONSOLE,
>>>> ?};
>>>>
>>>> -static int
>>>> -serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
>>>> +static int serial_omap_suspend(struct device *dev)
>>>> ?{
>>>> - ? ? struct uart_omap_port *up = platform_get_drvdata(pdev);
>>>> + ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
>>>>
>>>> - ? ? if (up)
>>>> + ? ? if (up) {
>>>> ? ? ? ? ? ? ? uart_suspend_port(&serial_omap_reg, &up->port);
>>>> + ? ? ? ? ? ? if (up->port.line == up->port.cons->index &&
>>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? !is_console_locked())
>>>> + ? ? ? ? ? ? ? ? ? ? up->console_locked = console_trylock();
>>>> + ? ? }
>>>> +
>>>
>>> Motiviation for console locking in this version of the series is not
>>> clear, and not described in the changelog.
>>>
>>> It's also present here in static suspend/resume but not in runtime
>>> suspend/resume, which also is suspicious.
>>>
>>
>> Yes will add to change log,
>>
>> We needed this for no console suspend use case
>> no console lock is taken in no_console_suspend is specified,
>>
>> Since our pwr_dmn hooks disable clocks left enabled during suspend,
>> so any prints after pwr_dmn hooks can cause problems since clocks
>> are already cut from pwr_dmn hooks.
>>
>> So buffer prints while entering suspend by taking console lock
>> if not taken already and print back after uart state machine restores
>> console uart.
>
> Any special consideration for features like no_console_suspend should be
> done in a separate patch with a separate changelog.
>

will add as separate patch.

> However, as I've stated before during previous reviews, if someone has
> put no_console_suspend on the command line, that means they've
> specifically stated they *want* to see console writes during suspend.
> That means, we should not cut clocks at all.
>
> Of course, that means the system will not hit the low power state becase
> the UART clocks are not gated, but that is what the user requested.

Yes correct, But pwr domain callback will now cut all enabled clocks
now, so only available method was to use console_lock and print later.

pwr_domain callback done in omap-device.c
will force to low powers state by gating all clocks that where left
enabled by driver.

--
Thanks,
Govindraj.R


>
>
> Kevin
>
