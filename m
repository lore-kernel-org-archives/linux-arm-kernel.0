From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 23 May 2013 00:28:21 +0800
Subject: [PATCH] pinctrl: sirf: save the status in suspend and restore
 after resuming
In-Reply-To: <CACRpkdaSTC8cLi-C_gwZEk8iF=bnAce920DbKvxN6S-=75xbnA@mail.gmail.com>
References: <1368674229-11813-1-git-send-email-Baohua.Song@csr.com>
 <CACRpkdaSTC8cLi-C_gwZEk8iF=bnAce920DbKvxN6S-=75xbnA@mail.gmail.com>
Message-ID: <CAGsJ_4wPd1_T--ezGQQVbeL3sJQwSTACJvE787JUoDQVvZ_muw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/20 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, May 16, 2013 at 5:17 AM, Barry Song <Baohua.Song@csr.com> wrote:
>
>> this patch saves the status of pinctrl registers and restore them while
>> resuming. this makes all drivers have coherent status for pinmux after
>> suspending and resuming.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Applied, but a quick remark that you may want to fix up:

thanks, linus. i will have an incremental patch to fix it.

>
> (...)
>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sirfsoc_pinmux_suspend_noirq(struct device *dev)
>> +{
>> +       int i, j;
>> +       struct sirfsoc_pmx *spmx = dev_get_drvdata(dev);
>> +
>> +       for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
>> +               for (j = 0; j < SIRFSOC_GPIO_BANK_SIZE; j++) {
>> +                       spmx->gpio_regs[i][j] = readl(spmx->gpio_virtbase +
>> +                               SIRFSOC_GPIO_CTRL(i, j));
>> +               }
>> +               spmx->ints_regs[i] = readl(spmx->gpio_virtbase +
>> +                       SIRFSOC_GPIO_INT_STATUS(i));
>> +               spmx->paden_regs[i] = readl(spmx->gpio_virtbase +
>> +                       SIRFSOC_GPIO_PAD_EN(i));
>> +       }
>> +       spmx->dspen_regs = readl(spmx->gpio_virtbase + SIRFSOC_GPIO_DSP_EN0);
>> +
>> +       for (i = 0; i < 3; i++)
>
> Why are you hard-coding 3 here? It looks fragile.

that means i have 3 registers beginning from spmx->rsc_virtbase to
save and restore. i missed to check the name of everyone.

>
>> +               spmx->rsc_regs[i] = readl(spmx->rsc_virtbase + 4 * i);
>> +ery
>> +       return 0;
>> +}
>> +
>> +static int sirfsoc_pinmux_resume_noirq(struct device *dev)
>> +{
>> +       int i, j;
>> +       struct sirfsoc_pmx *spmx = dev_get_drvdata(dev);
>> +
>> +       for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
>> +               for (j = 0; j < SIRFSOC_GPIO_BANK_SIZE; j++) {
>> +                       writel(spmx->gpio_regs[i][j], spmx->gpio_virtbase +
>> +                               SIRFSOC_GPIO_CTRL(i, j));
>> +               }
>> +               writel(spmx->ints_regs[i], spmx->gpio_virtbase +
>> +                       SIRFSOC_GPIO_INT_STATUS(i));
>> +               writel(spmx->paden_regs[i], spmx->gpio_virtbase +
>> +                       SIRFSOC_GPIO_PAD_EN(i));
>> +       }
>> +       writel(spmx->dspen_regs, spmx->gpio_virtbase + SIRFSOC_GPIO_DSP_EN0);
>> +
>> +       for (i = 0; i < 3; i++)
>
> Dito.
>
> Yours,
> Linus Walleij
>

-barry
