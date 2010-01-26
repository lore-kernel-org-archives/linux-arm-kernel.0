From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 22:12:39 -0500
Subject: [PATCH 2/4] mfd: update irq handler in max8925
In-Reply-To: <20100125115930.GE22909@sirena.org.uk>
References: <771cded01001250308mfd2b3d2l76bc2a2df88e7b93@mail.gmail.com>
	<20100125115930.GE22909@sirena.org.uk>
Message-ID: <771cded01001251912q67c9c2a5w3db61e9d7fe53cf9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 6:59 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 25, 2010 at 06:08:19AM -0500, Haojian Zhuang wrote:
>
>> +static struct resource power_supply_resources[] = {
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "max8925-power",
>> + ? ? ? ? ? ? .start ?= MAX8925_CHG_IRQ1,
>> + ? ? ? ? ? ? .end ? ?= MAX8925_CHG_IRQ1,
>> + ? ? ? ? ? ? .flags ?= IORESOURCE_IO,
>
> These should be IORESOURCE_IRQ.
>
Now I changed .start and .end. I only need declare IO resources.

>> + ? ? ? ? ? ? else if (value & irq_data->offs) {
>> + ? ? ? ? ? ? ? ? ? ? dev_err(chip->dev, "Noboday cares IRQ #%d. Mask it\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? chip->irq_base + i);
>> + ? ? ? ? ? ? ? ? ? ? max8925_set_bits(i2c, irq_data->mask_reg,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? irq_data->offs, irq_data->offs);
>
> genirq ought to be handling this for you?
>
No, genirq doesn't know this. I let the thread_fn to take this job.

>> + ? ? for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
>> + ? ? ? ? ? ? irq_data = &max8925_irqs[i];
>> + ? ? ? ? ? ? /* non TSC IRQ should be serviced in max8925_irq() */
>> + ? ? ? ? ? ? if (!irq_data->tsc_irq)
>> + ? ? ? ? ? ? ? ? ? ? continue;
>
> Shouldn't the interrupt handlers be able to avoid having to iterate
> through the array? ?It's unlikely to be expensive in the context of the
> I/O but it looks a bit odd.
>
There're multiple IRQ & IRQ_MASK registers. If I use bitmap at here, I
would use more code on composing it. Since some bits are not defined
in IRQ, I need to take care on it. If I use array at here, the code is
clean and simple. Although it looks a bit odd.

>> + * clear_irq: operation on clearing status of nIRQ pin in platform
>> + * clear_tsc_irq: operation on clearing status of nTIRQ pin in platform
>> + */
>
> Shouldn't these also be handled by genirq as functions of the interrupt
> controller that the chip is chained from?
>
Because PMIC IRQ is connected to the special pin of CPU. CPU needs to
clear pin status in external. genirq shouldn't take care on it. I have
to use this ugly way to clear pin status.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-mfd-update-irq-handler-in-max8925.patch
Type: text/x-patch
Size: 29093 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100125/98120427/attachment-0001.bin>
