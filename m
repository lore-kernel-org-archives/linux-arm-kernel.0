From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 1 Apr 2016 09:30:32 +0100
Subject: [RFC PATCH] genirq: Change the non-balanced irq to balance irq
 when the cpu of the irq bounded off line
In-Reply-To: <1459481291-10136-1-git-send-email-majun258@huawei.com>
References: <1459481291-10136-1-git-send-email-majun258@huawei.com>
Message-ID: <56FE31A8.1020502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ma Jun,

On 01/04/16 04:28, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> When the CPU of a non-balanced irq bounded is off line, the irq will be migrated to other CPUs,
> usually the first cpu on-line.
> 
> We can suppose the situation if a system has more than one non-balanced irq.
> At extreme case, these irqs will be migrated to the same CPU and will cause the 
> CPU run with high irq pressure, even make the system die.

It would take a hell of lot of interrupts (and a very badly designed
system) for that system to collapse under the interrupt load. Whatever
people tend to think, interrupts are a very rare event.

Any moderately ancient CPU can take several hundred of thousand
interrupts per second, and you still barely notice it (try any embedded
platform with a bunch of MMC controllers...).

Now, let's get to the actual question:

> So, I think maybe we need to change the non-balanced irq to a irq can be
> balanced to avoid the problem descried above.

But what makes you think that you can safely clear that flag? If it has
been excluding from balancing, that's surely for a good reason, and the
device driver that requested this probably doesn't expect the interrupt
affinity to change, other than by the effect of CPU hotplug itself.

So if you're seeing a problem with an interrupt not being balanced,
please first investigate *why* the driver asked for it the first place.

But to the best of my understanding, this patch doesn't solve anything.

Thanks,

	N,
-- 
Jazz is not dead. It just smells funny...
