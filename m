From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 14:31:17 -0700
Subject: [PATCH v4 1/3] power-domain: add power domain drivers for
 Rockchip platform
In-Reply-To: <1413795824-3453-2-git-send-email-jinkun.hong@rock-chips.com>
 (jinkun hong's message of "Mon, 20 Oct 2014 02:03:41 -0700")
References: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
 <1413795824-3453-2-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <7hppdme8d6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"jinkun.hong" <jinkun.hong@rock-chips.com> writes:

> From: "jinkun.hong" <jinkun.hong@rock-chips.com>
>
> Add power domain drivers based on generic power domain for Rockchip platform,
> and support RK3288.
>
> Signed-off-by: Jack Dai <jack.dai@rock-chips.com>
> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>

[...]

> +static int rockchip_pmu_set_idle_request(struct rockchip_domain *pd,
> +					 bool idle)
> +{
> +	u32 idle_mask = BIT(pd->idle_shift);
> +	u32 idle_target = idle << (pd->idle_shift);
> +	u32 ack_mask = BIT(pd->ack_shift);
> +	u32 ack_target = idle << (pd->ack_shift);
> +	unsigned int mask = BIT(pd->req_shift);
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pd->idle_lock, flags);
> +	val = (idle) ? mask : 0;
> +	regmap_update_bits(pd->regmap_pmu, REQ_OFFSET, mask, val);
> +	dsb();

A summary of the locking and barriers here (or in changelog) would be
helpful for reviewers to verify you're protecting what you need to
protect.

> +	do {
> +		regmap_read(pd->regmap_pmu, ACK_OFFSET, &val);
> +	} while ((val & ack_mask) != ack_target);
> +
> +	do {
> +		regmap_read(pd->regmap_pmu, IDLE_OFFSET, &val);
> +	} while ((val & idle_mask) != idle_target);
> +
> +	spin_unlock_irqrestore(&pd->idle_lock, flags);

These IRQ-disabled while loops look like opportunities to lockup the
system.  Maybe add a timeout or a maximum number of tries?

> +	return 0;
> +}

Kevin
