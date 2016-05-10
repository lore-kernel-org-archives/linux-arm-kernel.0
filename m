From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 10 May 2016 14:00:01 +0200
Subject: [PATCH] pinctrl: stm32: Implement .pin_config_dbg_show()
In-Reply-To: <CACRpkdZ=KsPL1mBS1bLi=jYsv=Vb1QNBi8XPAJW50doPcwBuZg@mail.gmail.com>
References: <1461939943-24752-1-git-send-email-patrice.chotard@st.com>
 <CACRpkdZ=KsPL1mBS1bLi=jYsv=Vb1QNBi8XPAJW50doPcwBuZg@mail.gmail.com>
Message-ID: <5731CD41.60506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/2016 01:50 PM, Linus Walleij wrote:
> On Fri, Apr 29, 2016 at 4:25 PM,  <patrice.chotard@st.com> wrote:
>
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Patch applied! Because this gives good debuggability.
>
> But think about refactorings:
>
>> +static bool stm32_pconf_input_get(struct stm32_gpio_bank *bank,
>> +       unsigned int offset)
>> +{
>> +       unsigned long flags;
>> +       u32 val;
>> +
>> +       clk_enable(bank->clk);
>> +       spin_lock_irqsave(&bank->lock, flags);
>> +
>> +       val = !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
>> +
>> +       spin_unlock_irqrestore(&bank->lock, flags);
>> +       clk_disable(bank->clk);
>> +
>> +       return val;
>> +}
>> +
>> +static bool stm32_pconf_output_get(struct stm32_gpio_bank *bank,
>> +       unsigned int offset)
>> +{
>> +       unsigned long flags;
>> +       u32 val;
>> +
>> +       clk_enable(bank->clk);
>> +       spin_lock_irqsave(&bank->lock, flags);
>> +       val = !!(readl_relaxed(bank->base + STM32_GPIO_ODR) & BIT(offset));
>> +
>> +       spin_unlock_irqrestore(&bank->lock, flags);
>> +       clk_disable(bank->clk);
>> +
>> +       return val;
>> +}
Hi Linus

> Don't you think these two look very similar for example.

You 're right, i will rework this in a separate patch

Thanks

Patrice

>
> But that can be fixed later, debuggability is more important.
>
> Yours,
> Linus Walleij
