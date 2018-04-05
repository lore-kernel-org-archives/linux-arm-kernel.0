From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 5 Apr 2018 15:08:31 +0530
Subject: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
In-Reply-To: <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
 <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
Message-ID: <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 4:28 PM, Fabien Dessenne <fabien.dessenne@st.com> wrote:
....
> +
> +       /* irq */
> +       for (i = 0; i < IPCC_IRQ_NUM; i++) {
> +               ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
> +               if (ipcc->irqs[i] < 0) {
> +                       dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
> +                       ret = ipcc->irqs[i];
> +                       goto err_clk;
> +               }
> +
> +               ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
> +                                               irq_thread[i], IRQF_ONESHOT,
> +                                               dev_name(dev), ipcc);
>
In your interrupt handlers you don't do anything that could block.
Threads only adds some delay to your message handling.
So maybe use devm_request_irq() ?

.......
> +
> +static struct platform_driver stm32_ipcc_driver = {
> +       .driver = {
> +               .name = "stm32-ipcc",
> +               .owner = THIS_MODULE,
>
No need of owner here these days.
And also maybe use readl/writel, instead of _relaxed.

Cheers!
