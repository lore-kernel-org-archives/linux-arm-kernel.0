From: dianders@chromium.org (Doug Anderson)
Date: Wed, 19 Nov 2014 11:30:04 -0800
Subject: [PATCH] mmc: dw_mmc: Turn the card clock off at suspend time
In-Reply-To: <CAL1qeaGkQVimrFNtGgfTJEHNemG_QUTecQwH4=nXu1_u1rWwhg@mail.gmail.com>
References: <1416423073-8105-1-git-send-email-dianders@chromium.org>
 <CAL1qeaGkQVimrFNtGgfTJEHNemG_QUTecQwH4=nXu1_u1rWwhg@mail.gmail.com>
Message-ID: <CAD=FV=UjvQ5Sgfv_-WzvZpOvofA=7Vpzh36LavCwqGV1-0_aHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, Nov 19, 2014 at 11:03 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> Doug,
>
> On Wed, Nov 19, 2014 at 10:51 AM, Doug Anderson <dianders@chromium.org> wrote:
>> Since the dw_mmc driver was first added to Linux it's had a TODO in it
>> that we should turn off the card clock during suspend.  I have no idea
>> for sure why it wasn't done originally, but if I had to guess I'd
>> guess it was related to the lack of a common clock framework.  Let's
>> do it now.
>>
>> There is no reason for the card clock to be left on during suspend and
>> most systems will eventually turn it off anyway (when whole clock
>> trees are disabled).  However, it's good to be explicit that it's
>> disabled at the time that the MMC subsystem is disabled.
>
> Should the bus clock (biu) be disabled as well?

Good question.  I'm slightly hesitant to turn biu_clk off in this
patch, though.  Specifically interrupts are still enabled at this
point in suspend.  I  guess most interrupts shouldn't be going off
right now (nobody is accessing storage, right?), but I could imagine
that a card detect or an SDIO interrupt at just the wrong time could
cause our ISR to go off _after_ this function is called.  The
interrupt handling function doesn't know to turn the BIU clock back on
so you'd get a hang.

...you'll also (I think) get a hang in exynos which has a "no_irq"
function and tries to access dw_mmc without turning on the biu clock.
...of course that wouldn't be hard to fix, but...


Turning off the biu clock when it's not needed seems like a good idea,
but I think it should be a separate patch.  Also, unlike the ciu clock
leaving the biu clock on doesn't seem to hurt anything on the system
I'm currently testing on.


>> This actually fixes a bug on Rockchip rk3288 where an SDIO card wakes
>> the system back up during suspend.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 5a37c33..c448159 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2825,11 +2825,10 @@ EXPORT_SYMBOL(dw_mci_remove);
>>
>>
>>  #ifdef CONFIG_PM_SLEEP
>> -/*
>> - * TODO: we should probably disable the clock to the card in the suspend path.
>> - */
>>  int dw_mci_suspend(struct dw_mci *host)
>>  {
>> +       clk_disable(host->ciu_clk);
>
> I think you need to check for IS_ERR(host->ciu_clk) since the clock is
> optional.  Also, maybe disable_unprepare instead of just disable?

Wow, duh.  Thanks for catching.


>> @@ -2838,6 +2837,8 @@ int dw_mci_resume(struct dw_mci *host)
>>  {
>>         int i, ret;
>>
>> +       clk_enable(host->ciu_clk);
>
> Check return value?

OK, sounds good.  I'll spin this again.

-Doug
