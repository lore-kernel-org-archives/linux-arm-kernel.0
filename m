From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 May 2016 15:34:42 +0200
Subject: [PATCH 5/7] net:mdio-mux: Add MDIO mux driver for iProc SoCs
In-Reply-To: <1464592251-2688-6-git-send-email-pramod.kumar@broadcom.com>
References: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
 <1464592251-2688-6-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160530133442.GK6027@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 12:40:49PM +0530, Pramod Kumar wrote:
> iProc based SoCs supports the integrated mdio multiplexer which
> has the bus selection as well as mdio transaction generation logic
> inside.

Hi Pramod

Great to see you using the existing MDIO framework. Thanks.

> +static int mdio_mux_iproc_switch_fn(int current_child, int desired_child,
> +				    void *data)
> +{
> +	struct iproc_mdiomux_desc *md = data;
> +	struct mdiomux_bus_param *bp = &md->bus_param[desired_child];
> +	u32 param, bus_id;
> +	bool bus_dir;
> +
> +	/* select bus and its properties */
> +	bus_dir = (desired_child < EXT_BUS_START_ADDR);
> +	bus_id = bus_dir ? desired_child : (desired_child - EXT_BUS_START_ADDR);
> +
> +	param = (bus_dir ? 1 : 0) << MDIO_PARAM_INTERNAL_SEL;
> +	param |= (bp->is_c45 ? 1 : 0) << MDIO_PARAM_C45_SEL;
> +	param |= (bus_id << MDIO_PARAM_BUS_ID);
> +
> +	writel(param, md->base + MDIO_PARAM_OFFSET);
> +	return 0;
> +}

What i don't yet see is why you went for the concept of an integrated
MDIO and MUX. This function above is the mux function, and it looks
like it could be used to implement a standard mdio-mux driver.

Thanks
     Andrew
