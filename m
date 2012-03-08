From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 8 Mar 2012 09:28:53 +0530
Subject: [PATCH v3 12/13] gpio/omap: fix incorrect context restore logic
 in omap_gpio_runtime_resume
In-Reply-To: <4F574F95.7090801@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-13-git-send-email-tarun.kanti@ti.com>
 <4F574F95.7090801@ti.com>
Message-ID: <CAC83ZvLFoSppTiPw-_a=z_Mnpmk6nHeaadTShdJP8RpDWh9TLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 5:37 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
>> In omap_gpio_runtime_resume() the context restore should be independent
>> of bank->enabled_non_wakeup_gpios. This was preventing context restore
>> of GPIO lines which are not wakeup enabled.
>>
>> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> ?drivers/gpio/gpio-omap.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 2e8e476..ccfbae0 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1227,7 +1227,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
>> ? ? ? __raw_writel(bank->context.risingdetect,
>> ? ? ? ? ? ? ? ? ? ?bank->base + bank->regs->risingdetect);
>>
>> - ? ? if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabled) {
>> + ? ? if (!bank->workaround_enabled) {
> This doesn't seem to be right.
> Don't you want to avoid GPIO restore for banks which are in
> always on domain. Infact the purpose of "enabled_non_wakeup_gpios"
> is exactly that ? Isn't it.
>
> What am I missing ?
The bank->enabled_non_wakeup_gpios is set whenever a gpio line is programmed
as edge trigger as shown below.
(This is not meant to distinguish between gpios in WKUP domain vs
those in PER domain).
The context restore should happen irrespective of whether the trigger
type is edge or level.
In fact context restore was not happening for a gpio line because of
this condition while
testing suspend/resume.

[...]
                if (trigger & IRQ_TYPE_EDGE_BOTH)
                        bank->enabled_non_wakeup_gpios |= gpio_bit;
                else
                        bank->enabled_non_wakeup_gpios &= ~gpio_bit;
[...]
--
Tarun

>
> Regards
> Santosh
