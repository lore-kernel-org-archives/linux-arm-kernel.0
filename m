From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Fri, 1 Jun 2018 12:44:42 +0000
Subject: [PATCH v2]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <86d0xhaucm.wl-marc.zyngier@arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69F1300F@G01JPEXMBKW03>
 <86d0xhaucm.wl-marc.zyngier@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F3004A@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

I have reviewed your patch.	 
I think the approach is same between your patch and mine.
Your patch is simpler and more beautiful, and match our bus's requirement.

I have only one question.
According your patch, if there are no enough lpis, amount of lpis required
will be divide by 2. it means someone want 16 lpis, maybe they can only get 8?
I don?t' understand why we need it.

 static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 {
         unsigned long *bitmap = NULL;
         int err = 0;

         do {
                 err = alloc_lpi_range(nr_irqs, base);
                 if (!err)
                         break;

                 nr_irqs /= 2;
         } while (nr_irqs > 0);


Best Regards,
Lei Zhang zhang.lei at jp.fujitsu.com
FUJITSU LIMITED

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> Marc Zyngier
> Sent: Monday, May 28, 2018 2:20 AM
> To: Zhang, Lei/? ?
> Cc: 'linux-arm-kernel at lists.infradead.org'
> Subject: Re: [PATCH v2]irqchip/irq-gic-v3:Avoid a waste of LPI resource
> 
> On Fri, 25 May 2018 13:45:24 +0100,
> Zhang, Lei wrote:
> 
 
> I've just prototyped what I had in mind for this at [1] (see the first
> patch for the allocator itself). As you can see, the allocator is a
> lot simpler, yet it has all the flexibility you would need, The
> drawback is of course that freeing LPIs is quite expensive, but that
> almost never happens. And if it does, we can switch to a tree or some
> more efficient data structure.
> 
> Thanks,
> 
> 	M.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.gi
> t/log/?h=irq/lpi-allocator
> 
