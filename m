From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Mar 2014 10:05:17 +0000
Subject: [PATCH v5 01/11] staging: imx-drm-core: Use OF graph to find
 components and connections between encoder and crtcs
In-Reply-To: <1394011262-16849-2-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <1394011262-16849-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140305100516.GV21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:20:52AM +0100, Philipp Zabel wrote:
> +struct imx_drm_component {
> +	struct device_node *of_node;
> +	struct list_head list;
> +};
> +

The only thing this structure appears to be doing is ensuring that a
single component doesn't get added twice - is that correct?  If so,
(and the troublesome problem with the IPU crtcs is now gone)
we can modify the core component code such that it does this:

                if (c->master && c->master != master)
                        continue;

                if (compare(c->dev, compare_data)) {
			if (!c->master)
	                        component_attach_master(master, c);
                        ret = 0;
                        break;
                }

which will mean that you don't need to build this list anymore to track
what will be added - though I'd like to think a little more about that
before making that change.  Please confirm whether this will eliminate
your list generation.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
