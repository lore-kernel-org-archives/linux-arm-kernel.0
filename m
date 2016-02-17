From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Feb 2016 07:47:40 +0000
Subject: [PATCH v2 4/5] irqchip:create irq domain for each mbigen device
In-Reply-To: <56C3F4AC.8020807@huawei.com>
References: <1455604648-20668-1-git-send-email-majun258@huawei.com>
 <1455604648-20668-5-git-send-email-majun258@huawei.com>
 <20160216085024.3f573f40@arm.com> <56C3F4AC.8020807@huawei.com>
Message-ID: <20160217074740.439c53b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Feb 2016 12:18:52 +0800
"majun (F)" <majun258@huawei.com> wrote:

> 
> 
> ? 2016/2/16 16:50, Marc Zyngier ??:
> > On Tue, 16 Feb 2016 14:37:27 +0800
> > MaJun <majun258@huawei.com> wrote:
> > 
> >> From: Ma Jun <majun258@huawei.com>
> [...]
> >> +	unsigned int nid;
> >> +
> >> +	nid = get_mbigen_nid(hwirq);
> >> +
> >> +	if (nid < 4)
> >> +		return (nid * 4) + REG_MBIGEN_VEC_OFFSET;
> >> +	else
> >> +		return (nid - 4) * 4 + REG_MBIGEN_EXT_VEC_OFFSET;
> >> +}
> >> +
> >> +static struct irq_chip mbigen_irq_chip = {
> >> +	.name =			"mbigen-v1",
> >> +};
> >> +
> >> +static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> >> +{
> >> +	/* The address of doorbell is encoded in mbigen register by default
> >> +	 * So,we don't need to program the doorbell address at here
> >> +	 * Besides, the event ID is decided by the hardware pin number,
> >> +	 * we can't change it in software.So, we don't need to encode the
> >> +	 * event ID in mbigen register.
> >> +	 */
> > 
> > Really? What if tomorrow I decide to change the EventID allocation
> > policy in the ITS driver? Have your HW engineers really baked the
> > behaviour of the Linux driver into the device?
> > 
> 
> Yes.
> If we really need to support this chip,is there
> any possible solution for this problem?

You would have to provide some sort of lookup table from the
device-tree, or find a way to pass this information down the ITS code.

The real question is: do we take this as it is and fix it once it
breaks? or do we mandate a proper solution before this has a remote
chance of getting in?

At the moment, I don't know, because the idea of hardcoded MSIs is so
wrong and so against the way the whole stack works that I just want to
say no to this and run away.

I need to think.

	M.
-- 
Jazz is not dead. It just smells funny.
