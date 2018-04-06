From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Fri, 6 Apr 2018 12:29:02 +0000
Subject: [PATCH v2 2/2] mailbox: add STMicroelectronics STM32 IPCC driver
In-Reply-To: <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
 <1520852307-26659-3-git-send-email-fabien.dessenne@st.com>
 <CABb+yY1x7J_oEgU-LR5jPYCoCoUHng84E+CibTxLzdtxhENTBw@mail.gmail.com>
Message-ID: <4a2170b7-e5e9-4f5c-8ff7-79e102a658c1@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi


On 05/04/18 11:38, Jassi Brar wrote:
> On Mon, Mar 12, 2018 at 4:28 PM, Fabien Dessenne <fabien.dessenne@st.com> wrote:
> ....
>> +
>> +       /* irq */
>> +       for (i = 0; i < IPCC_IRQ_NUM; i++) {
>> +               ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
>> +               if (ipcc->irqs[i] < 0) {
>> +                       dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
>> +                       ret = ipcc->irqs[i];
>> +                       goto err_clk;
>> +               }
>> +
>> +               ret = devm_request_threaded_irq(dev, ipcc->irqs[i], NULL,
>> +                                               irq_thread[i], IRQF_ONESHOT,
>> +                                               dev_name(dev), ipcc);
>>
> In your interrupt handlers you don't do anything that could block.
> Threads only adds some delay to your message handling.
> So maybe use devm_request_irq() ?

The interrupt handlers call mbox_chan_received_data() / 
mbox_chan_txdone(), which call in turn client's rx_callback() / 
tx_done() / tx_prepare() which behavior may be unsafe. Hence, using a 
threaded irq here seems to be a good choice.


>
> .......
>> +
>> +static struct platform_driver stm32_ipcc_driver = {
>> +       .driver = {
>> +               .name = "stm32-ipcc",
>> +               .owner = THIS_MODULE,
>>
> No need of owner here these days.

OK, I will suppress it.

> And also maybe use readl/writel, instead of _relaxed.

The IPCC device is exclusively used on ARM. In ARM architecture, the 
ioremap on devices are strictly ordered and uncached.
In that case, using _relaxed avoids an unneeded cache flush, slightly 
improving performance.

>
> Cheers!
