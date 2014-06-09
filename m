From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 9 Jun 2014 18:24:34 +0800
Subject: [PATCH 2/2] mtd: atmel_nand: NFC: support multiple interrupt
 handling
In-Reply-To: <53915CE4.803@atmel.com>
References: <1402026480-26648-1-git-send-email-josh.wu@atmel.com>
 <1402026480-26648-2-git-send-email-josh.wu@atmel.com>
 <53915CE4.803@atmel.com>
Message-ID: <53958B62.6060103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bo

On 6/6/2014 2:17 PM, Bo Shen wrote:
> Hi Josh,
>
> On 06/06/2014 11:48 AM, Josh Wu wrote:
>> It fixes following error sometime happens during the NFC data transfer:
>>    atmel_nand 80000000.nand: Time out to wait for interrupt: 0x00010000
>>    atmel_nand 80000000.nand: something wrong, No XFR_DONE interrupt 
>> comes.
>>
>> The root cause is in current interrupt handler, we read the ISR but
>> only handle one interrupt. If there are more than one interrupt come
>> together, then the second one will be lost.
>>
>> During the NFC data transfer. There is possible two NFC interrupts:
>> NFC_CMD_DONE and NFC_XFR_DONE, come in same time.
>>
>> NFC_CMD_DONE means NFC command is send. and NFC_XFR_DONE means NFC data
>> is transfered.
>>
>> This patch can handle multiple NFC interrupts in same time. And during
>> the NFC data transfer, we need to wait for two NFC interrupts:
>> NFC_CMD_DONE and NFC_XFR_DONE.
>
> I think, these two patches is try to fix this issue, can you combine 
> it into one? Or else, I really don't know what the patch 1 is benefit 
> for?

I split them because I think it is more readable. But I'm ok to merge 
them into one.

>
>> Reported-by: Matthieu CRAPET <Matthieu.CRAPET@ingenico.com>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>>   drivers/mtd/nand/atmel_nand.c |   61 
>> +++++++++++++++++++++++------------------
>>   1 file changed, 35 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c 
>> b/drivers/mtd/nand/atmel_nand.c
>> index 347cee2..faee53d 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -1579,7 +1579,7 @@ static irqreturn_t hsmc_interrupt(int irq, void 
>> *dev_id)
>>   {
>>       struct atmel_nand_host *host = dev_id;
>>       u32 status, mask, pending;
>> -    irqreturn_t ret = IRQ_HANDLED;
>> +    irqreturn_t ret = IRQ_NONE;
>>
>>       status = nfc_readl(host->nfc->hsmc_regs, SR);
>>       mask = nfc_readl(host->nfc->hsmc_regs, IMR);
>> @@ -1588,14 +1588,17 @@ static irqreturn_t hsmc_interrupt(int irq, 
>> void *dev_id)
>>       if (pending & NFC_SR_XFR_DONE) {
>>           complete(&host->nfc->comp_xfer_done);
>>           nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_XFR_DONE);
>> -    } else if (pending & NFC_SR_RB_EDGE) {
>> +        ret = IRQ_HANDLED;
>> +    }
>> +    if (pending & NFC_SR_RB_EDGE) {
>>           complete(&host->nfc->comp_ready);
>>           nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_RB_EDGE);
>> -    } else if (pending & NFC_SR_CMD_DONE) {
>> +        ret = IRQ_HANDLED;
>> +    }
>> +    if (pending & NFC_SR_CMD_DONE) {
>>           complete(&host->nfc->comp_cmd_done);
>>           nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_CMD_DONE);
>> -    } else {
>> -        ret = IRQ_NONE;
>> +        ret = IRQ_HANDLED;
>>       }
>>
>>       return ret;
>> @@ -1604,31 +1607,40 @@ static irqreturn_t hsmc_interrupt(int irq, 
>> void *dev_id)
>>   /* NFC(Nand Flash Controller) related functions */
>>   static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
>>   {
>> -    unsigned long timeout;
>> -    struct completion *comp;
>> -
>> -    if (flag & NFC_SR_XFR_DONE) {
>> -        comp = &host->nfc->comp_xfer_done;
>> -    } else if (flag & NFC_SR_RB_EDGE) {
>> -        comp = &host->nfc->comp_ready;
>> -    } else if (flag & NFC_SR_CMD_DONE) {
>> -        comp = &host->nfc->comp_cmd_done;
>> -    } else {
>> +    int i, index = 0;
>> +    struct completion *comp[3];    /* Support 3 interrupt completion */
>> +
>> +    if (flag & NFC_SR_XFR_DONE)
>> +        comp[index++] = &host->nfc->comp_xfer_done;
>> +
>> +    if (flag & NFC_SR_RB_EDGE)
>> +        comp[index++] = &host->nfc->comp_ready;
>> +
>> +    if (flag & NFC_SR_CMD_DONE)
>> +        comp[index++] = &host->nfc->comp_cmd_done;
>> +
>> +    if (index == 0) {
>>           dev_err(host->dev, "Unkown interrupt flag: 0x%08x\n", flag);
>>           return -EINVAL;
>>       }
>>
>> -    init_completion(comp);
>> +    for (i = 0; i < index; i++)
>> +        init_completion(comp[i]);
>
> One question, will the interrupt occur before you initial the 
> completion? If so, you will lose the interrupt.
Ah, yes. I think it's possible.
I should initialize the completion and enable IER before we send command 
to NFC. I will send out v2 patch for fix this. Thanks.

Best Regards,
Josh Wu

>
>>
>>       /* Enable interrupt that need to wait for */
>>       nfc_writel(host->nfc->hsmc_regs, IER, flag);
>>
>> -    timeout = wait_for_completion_timeout(comp,
>> -            msecs_to_jiffies(NFC_TIME_OUT_MS));
>> -    if (timeout)
>> -        return 0;
>> +    for (i = 0; i < index; i++) {
>> +        if (wait_for_completion_timeout(comp[i],
>> +                msecs_to_jiffies(NFC_TIME_OUT_MS)))
>> +            continue;    /* wait for next completion */
>> +        else
>> +            goto err_timeout;
>> +    }
>>
>> -    /* Time out to wait for the interrupt */
>> +    return 0;
>> +
>> +err_timeout:
>>       dev_err(host->dev, "Time out to wait for interrupt: 0x%08x\n", 
>> flag);
>>       return -ETIMEDOUT;
>>   }
>> @@ -1652,7 +1664,8 @@ static int nfc_send_command(struct 
>> atmel_nand_host *host,
>>       }
>>       nfc_writel(host->nfc->hsmc_regs, CYCLE0, cycle0);
>>       nfc_cmd_addr1234_writel(cmd, addr, host->nfc->base_cmd_regs);
>> -    return nfc_wait_interrupt(host, NFC_SR_CMD_DONE);
>> +    return nfc_wait_interrupt(host, NFC_SR_CMD_DONE |
>> +            (cmd & NFCADDR_CMD_DATAEN ? NFC_SR_XFR_DONE : 0));
>>   }
>>
>>   static int nfc_device_ready(struct mtd_info *mtd)
>> @@ -1810,10 +1823,6 @@ static void nfc_nand_command(struct mtd_info 
>> *mtd, unsigned int command,
>>       nfc_addr_cmd = cmd1 | cmd2 | vcmd2 | acycle | csid | dataen | 
>> nfcwr;
>>       nfc_send_command(host, nfc_addr_cmd, addr1234, cycle0);
>>
>> -    if (dataen == NFCADDR_CMD_DATAEN)
>> -        if (nfc_wait_interrupt(host, NFC_SR_XFR_DONE))
>> -            dev_err(host->dev, "something wrong, No XFR_DONE 
>> interrupt comes.\n");
>> -
>>       /*
>>        * Program and erase have their own busy handlers status, 
>> sequential
>>        * in, and deplete1 need no delay.
>>
>
> Best Regards,
> Bo Shen
