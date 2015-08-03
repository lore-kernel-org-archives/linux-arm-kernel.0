From: eric@anholt.net (Eric Anholt)
Date: Mon, 03 Aug 2015 16:23:09 -0700
Subject: [PATCH] irqchip: bcm2836: Use a CPU notifier enable IPIs.
In-Reply-To: <alpine.DEB.2.11.1508021221370.3825@nanos>
References: <55B67C81.1010900@gmail.com>
 <1438027789-1637-1-git-send-email-eric@anholt.net>
 <alpine.DEB.2.11.1508021221370.3825@nanos>
Message-ID: <87fv40lzxe.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, 27 Jul 2015, Eric Anholt wrote:
>> +/* Unmasks the IPI on the CPU wen it's first brought online. */
>
> when
>
>> +static int bcm2836_arm_irqchip_cpu_notify(struct notifier_block *nfb,
>> +					  unsigned long action, void *hcpu)
>> +{
>> +	unsigned int cpu = (unsigned long)hcpu;
>> +	unsigned int int_reg = LOCAL_MAILBOX_INT_CONTROL0;
>> +	unsigned int mailbox = 0;
>> +
>> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>> +		bcm2836_arm_irqchip_unmask_per_cpu_irq(int_reg, mailbox, cpu);
>
> Shouldn't you mask the irq on CPU_DYING?

I was just following what other drivers were doing.  Is CPU_DYING the
only thing that needs masking?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/f573d5f4/attachment.sig>
