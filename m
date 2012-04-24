From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 24 Apr 2012 21:06:59 +0530
Subject: [PATCH v9 11/25] gpio/omap: cleanup omap_gpio_mod_init function
In-Reply-To: <CAC83ZvK630=6B-k2TfV3XBg8w7ZosLVDNE4ezjDYnn=hcXA48Q@mail.gmail.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
 <1328203851-20435-12-git-send-email-tarun.kanti@ti.com>
 <13629551.hP3ZV1ajDo@vclass>
 <CAC83ZvK630=6B-k2TfV3XBg8w7ZosLVDNE4ezjDYnn=hcXA48Q@mail.gmail.com>
Message-ID: <CAC83ZvJDDvCu8NKTOYh75USA3fvSAKEGaXXi9PtCM955K_keSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

On Tue, Apr 24, 2012 at 12:24 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Sat, Apr 21, 2012 at 7:33 PM, Janusz Krzysztofik
> <jkrzyszt@tis.icnet.pl> wrote:
>> On Thursday 02 of February 2012 23:00:37 Tarun Kanti DebBarma wrote:
>>> With register offsets now defined for respective OMAP versions we can get rid
>>> of cpu_class_* checks. This function now has common initialization code for
>>> all OMAP versions...
>>>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> Signed-off-by: Charulatha V <charu@ti.com>
>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> Sorry for being so late with my comment for chanes already present in
>> mainline, but this patch breaks GPIO on Amstrad Delta at least, and I
>> have neither enough spare time nor enough experience with non OMAP1
>> machines to provide a solution myself.
> Yes, I looked at the omap_gpio_mod_init() and OMAP1 configurations are
> overwritten.
> Also looks like there is issue in making distinction between omap15xx
> and omap16xx.
> I will post a patch and you can help me testing it in OMAP1 platform.
> Thanks for pointing this out.
> --
> Tarun
>>
>>> ---
>>> ?arch/arm/mach-omap1/gpio16xx.c | ? 35 +++++++++++++++++-
>>> ?drivers/gpio/gpio-omap.c ? ? ? | ? 77 ++++++++++++----------------------------
>>> ?2 files changed, 57 insertions(+), 55 deletions(-)
>> ...
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index f39d9e4..a948351 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>> ...
>>> @@ -898,62 +896,30 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
>>> ? */
>>> ?static struct lock_class_key gpio_lock_class;
>>>
>>> -/* TODO: Cleanup cpu_is_* checks */
>>> ?static void omap_gpio_mod_init(struct gpio_bank *bank)
>>> ?{
>>> - ? ? if (cpu_class_is_omap2()) {
>>> - ? ? ? ? ? ? if (cpu_is_omap44xx()) {
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0xffffffff, bank->base +
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP4_GPIO_IRQSTATUSCLR0);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base +
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP4_GPIO_DEBOUNCENABLE);
>>> - ? ? ? ? ? ? ? ? ? ? /* Initialize interface clk ungated, module enabled */
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
>>> - ? ? ? ? ? ? } else if (cpu_is_omap34xx()) {
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base +
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP24XX_GPIO_IRQENABLE1);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0xffffffff, bank->base +
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP24XX_GPIO_IRQSTATUS1);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base +
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP24XX_GPIO_DEBOUNCE_EN);
>>> -
>>> - ? ? ? ? ? ? ? ? ? ? /* Initialize interface clk ungated, module enabled */
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
>>> - ? ? ? ? ? ? }
>>> - ? ? } else if (cpu_class_is_omap1()) {
>>> - ? ? ? ? ? ? if (bank_is_mpuio(bank)) {
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writew(0xffff, bank->base +
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MPUIO_GPIO_MASKIT / bank->stride);
>>> - ? ? ? ? ? ? ? ? ? ? mpuio_init(bank);
>>> - ? ? ? ? ? ? }
>>> - ? ? ? ? ? ? if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writew(0xffff, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP1510_GPIO_INT_MASK);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writew(0x0000, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP1510_GPIO_INT_STATUS);
>>> - ? ? ? ? ? ? }
>>> - ? ? ? ? ? ? if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writew(0x0000, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP1610_GPIO_IRQENABLE1);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writew(0xffff, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP1610_GPIO_IRQSTATUS1);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writew(0x0014, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP1610_GPIO_SYSCONFIG);
>>> + ? ? void __iomem *base = bank->base;
>>> + ? ? u32 l = 0xffffffff;
>>>
>>> - ? ? ? ? ? ? ? ? ? ? /*
>>> - ? ? ? ? ? ? ? ? ? ? ?* Enable system clock for GPIO module.
>>> - ? ? ? ? ? ? ? ? ? ? ?* The CAM_CLK_CTRL *is* really the right place.
>>> - ? ? ? ? ? ? ? ? ? ? ?*/
>>> - ? ? ? ? ? ? ? ? ? ? omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ULPD_CAM_CLK_CTRL);
>>> - ? ? ? ? ? ? }
>>> - ? ? ? ? ? ? if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0xffffffff, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP7XX_GPIO_INT_MASK);
>>> - ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP7XX_GPIO_INT_STATUS);
>>> - ? ? ? ? ? ? }
>>> + ? ? if (bank->width == 16)
>>> + ? ? ? ? ? ? l = 0xffff;
>>> +
>>> + ? ? if (bank_is_mpuio(bank)) {
>>> + ? ? ? ? ? ? __raw_writel(l, bank->base + bank->regs->irqenable);
>>> + ? ? ? ? ? ? return;
>>> ? ? ? }
>>> +
>>> + ? ? _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->irqenable_inv);
>>> + ? ? _gpio_rmw(base, bank->regs->irqstatus, l,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->regs->irqenable_inv == false);
>>> + ? ? _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debounce_en != 0);
>>> + ? ? _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl != 0);
>>
>> bank->regs->irqenable trgister is manipulated 3 times in a row, each
>> time based on different criteria. This breaks GPIO on Amstrad Delta at
>> least, and generally looks wrong. I was only able to verify that
>> commenting out the above two lines fixes the issue with Amstrad Delta for
>> me.
>>
>>> + ? ? if (bank->regs->debounce_en)
>>> + ? ? ? ? ? ? _gpio_rmw(base, bank->regs->debounce_en, 0, 1);
>>
>> This also looks suspicious, I guess the second line should rather be:
>>
>> ? ? ? ? ? ? ? ?_gpio_rmw(base, bank->regs->debounce, 0, 1);
>>
>>> +
>>> + ? ? ?/* Initialize interface clk ungated, module enabled */
>>> + ? ? if (bank->regs->ctrl)
>>> + ? ? ? ? ? ? _gpio_rmw(base, bank->regs->ctrl, 0, 1);
>>
>> Is bank->regs->ctrl a flag, or a register offset? If the latter, is that
>> offset guaranteed to never take a valid value of 0?
>>
>> Thanks,
>> Janusz

Here is the patch, with attachment as well. I have just tested on
OMAP4 platform.
Testing on other OMAP2+ platforms is pending. In the meantime can you please
validate on OMAP1 platform and confirm? Thanks.
--
Tarun

From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Tue, 24 Apr 2012 20:34:32 +0530
Subject: [PATCH] gpio/omap: fix omap1 register overwrite in omap_gpio_mod_init

Initialization of irqenable, irqstatus registers is the common
operation done in this function for all OMAP platforms, viz.
OMAP1, OMAP2+. The latter _gpio_rmw()'s to irqenable register
was overwriting the correctly programmed OMAP1 value at the
beginning. As a result, even though it worked on OMAP2+
platforms it was breaking OMAP1 functionality.

On closer observation it is found that the first _gpio_rmw()
which is supposedly done to take care of OMAP1 platform is
generic enough and takes care of OMAP2+ platform as well.
Therefore remove the latter _gpio_rmw() to irqenable as they
are redundant.

Also, changing the sequence and logic of initializing the
irqstatus.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1adc2ec..b8f01c1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -964,11 +964,8 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
                return;
        }

+       _gpio_rmw(base, bank->regs->irqstatus, l,
bank->regs->irqenable_inv == 0 );
        _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->irqenable_inv);
-       _gpio_rmw(base, bank->regs->irqstatus, l,
-                                       bank->regs->irqenable_inv == false);
-       _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debounce_en != 0);
-       _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl != 0);
        if (bank->regs->debounce_en)
                _gpio_rmw(base, bank->regs->debounce_en, 0, 1);

--
1.7.0.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gpio-omap-fix-omap1-register-overwrite-in-omap_gpio_.patch
Type: application/octet-stream
Size: 1790 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/b645a46d/attachment-0001.obj>
