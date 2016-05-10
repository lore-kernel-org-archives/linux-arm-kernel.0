From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 May 2016 13:50:11 +0200
Subject: [PATCH] pinctrl: stm32: Implement .pin_config_dbg_show()
In-Reply-To: <1461939943-24752-1-git-send-email-patrice.chotard@st.com>
References: <1461939943-24752-1-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdZ=KsPL1mBS1bLi=jYsv=Vb1QNBi8XPAJW50doPcwBuZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 4:25 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Patch applied! Because this gives good debuggability.

But think about refactorings:

> +static bool stm32_pconf_input_get(struct stm32_gpio_bank *bank,
> +       unsigned int offset)
> +{
> +       unsigned long flags;
> +       u32 val;
> +
> +       clk_enable(bank->clk);
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       val = !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       clk_disable(bank->clk);
> +
> +       return val;
> +}
> +
> +static bool stm32_pconf_output_get(struct stm32_gpio_bank *bank,
> +       unsigned int offset)
> +{
> +       unsigned long flags;
> +       u32 val;
> +
> +       clk_enable(bank->clk);
> +       spin_lock_irqsave(&bank->lock, flags);
> +       val = !!(readl_relaxed(bank->base + STM32_GPIO_ODR) & BIT(offset));
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       clk_disable(bank->clk);
> +
> +       return val;
> +}

Don't you think these two look very similar for example.

But that can be fixed later, debuggability is more important.

Yours,
Linus Walleij
