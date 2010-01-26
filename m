From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 11:28:00 +0000
Subject: [PATCH 2/4] mfd: update irq handler in max8925
In-Reply-To: <771cded01001251912q67c9c2a5w3db61e9d7fe53cf9@mail.gmail.com>
References: <771cded01001250308mfd2b3d2l76bc2a2df88e7b93@mail.gmail.com>
	<20100125115930.GE22909@sirena.org.uk>
	<771cded01001251912q67c9c2a5w3db61e9d7fe53cf9@mail.gmail.com>
Message-ID: <20100126112800.GL15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 10:12:39PM -0500, Haojian Zhuang wrote:
> On Mon, Jan 25, 2010 at 6:59 AM, Mark Brown
> > On Mon, Jan 25, 2010 at 06:08:19AM -0500, Haojian Zhuang wrote:

> >> + ? ? ? ? ? ? else if (value & irq_data->offs) {
> >> + ? ? ? ? ? ? ? ? ? ? dev_err(chip->dev, "Noboday cares IRQ #%d. Mask it\n",
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? chip->irq_base + i);
> >> + ? ? ? ? ? ? ? ? ? ? max8925_set_bits(i2c, irq_data->mask_reg,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? irq_data->offs, irq_data->offs);

> > genirq ought to be handling this for you?

> No, genirq doesn't know this. I let the thread_fn to take this job.

This suggests that something is wrong somewhere else - genirq will
normally warn if an interrupt is reported without being handled which
looks like what this code is trying to achieve.  Looking at the patch
I expect you should just be able to drop the test you're doing
immediately before the quoted code to see if the interrupt is enabled
and call handle_nested_irq() unconditionally, genirq should generate a
warning and mask the IRQ if it's not handled which is what your code
here is doing.

> >> + * clear_irq: operation on clearing status of nIRQ pin in platform
> >> + * clear_tsc_irq: operation on clearing status of nTIRQ pin in platform
> >> + */

> > Shouldn't these also be handled by genirq as functions of the interrupt
> > controller that the chip is chained from?

> Because PMIC IRQ is connected to the special pin of CPU. CPU needs to
> clear pin status in external. genirq shouldn't take care on it. I have
> to use this ugly way to clear pin status.

I would expect this to be handled by the special pin on the CPU being an
irq_chip, or by having the existing interrupt controller handle this pin
properly.  The need to ack is going to be there for anything that ends
up hanging off this special IRQ, isn't it?
