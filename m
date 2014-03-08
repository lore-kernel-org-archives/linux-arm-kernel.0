From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 08 Mar 2014 07:37:58 +0000
Subject: [PATCH v2] dt: platform driver: Fill the resources before probe
 and defer if needed
In-Reply-To: <1392988720-20976-1-git-send-email-jjhiblot@traphandler.com>
References: <20140220153042.DF053C4050F@trevor.secretlab.ca> <
 1392988720-20976-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20140308073758.DA63FC408EC@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Feb 2014 14:18:40 +0100, Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:
> The goal of this patch is to allow drivers to be probed even if at the time of
> the DT parsing some of their ressources are not available yet.

Hi Jean-Jacques

[...]
> +int of_platform_device_prepare(struct platform_device *dev)
> +{
> +	struct device_node *np;
> +	int i, irq_index;
> +	struct resource *res;
> +
> +	/*
> +	 * This function applies only devices described in the DT.
> +	 * Other platform devices have their ressources already populated.
> +	 */
> +	np = dev->dev.of_node;
> +	if (!np)
> +		return 0;

I believe we already talked about the above test. This function must
only process devices created by of_platform_populate(). Merely checking
the of_node pointer is not a sufficient test because there are other
paths in the kernel for creating platform_devices that might get a node
pointer attached to it.

g.
