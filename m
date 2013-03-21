From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Mar 2013 11:32:51 -0600
Subject: [PATCH 00/16] Marvell EBU thermal sensor consolidation
In-Reply-To: <20130321064501.GK21478@lunn.ch>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321064501.GK21478@lunn.ch>
Message-ID: <20130321173251.GA3070@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 07:45:01AM +0100, Andrew Lunn wrote:

> In the end, i decided it was simpler and cleaner to just have separate
> drivers. This is something which we should think about and discuss.

When I looked through the merge'd driver I thought the shared code
really had little to do with Marvell, it was mostly boilerplate that
would be common to any memory mapped temperature sensor - so maybe the
drivers should be kept apart and the boiler plate could be factored?

 thermal_platform_mmio_init(pdev,&ops);

Where ops has the is_valid, init_sensor, get_sensor functions

Or something?

...

BTW, Ezequiel your driver is probably a bit smaller if you do

struct mvebu_ops {
	/* Initialize the sensor (optional) */
	void (*init_sensor)(struct mvebu_thermal_priv *);

	/* Test for a valid sensor value (optional) */
	bool (*is_valid)(struct mvebu_thermal_priv *);
};

static const struct mvebu_ops kirkwood_ops = {..};

static const struct of_device_id mvebu_thermal_id_table[] = {
	{
		.compatible = "marvell,kirkwood-thermal",
		.data       = &kirkwood_ops,
	},

And drop the switch statement and the MVEBU_THERMAL_SOC_* constants..

Cheers,
Jason
