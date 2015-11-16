From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 16:30:16 +0000
Subject: [PATCH 2/2] drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1447685093-26129-3-git-send-email-Liviu.Dudau@arm.com>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
 <1447685093-26129-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151116163016.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've tweaked your patch to make the above (buggy) change a little clearer.

On Mon, Nov 16, 2015 at 02:44:53PM +0000, Liviu Dudau wrote:
> -	for (i = 0;; i++) {
> -		port = of_parse_phandle(np, "ports", i);
> -		if (!port)
> -			break;
> -
> -		if (!of_device_is_available(port->parent)) {
> -			of_node_put(port);
> -			continue;
> -		}
>  
> -		component_match_add(dev, &match, compare_of, port->parent);
> -		of_node_put(port);
> -	}

> -static int compare_of(struct device *dev, void *data)
> -{
> -	struct device_node *np = data;
> -
> -	return dev->of_node == np;
> -}

The original above passes port->parent to component_match_add().  This
means 'np' in the above compare_of() function is 'port->parent'.

This means the above comparison is effectively:

	dev->of_node == port->parent

The generic code instead does this:

                component_match_add(dev, &match, compare_of, port);

So what we get in the comparison function is 'port' rather than
'port->parent':

> +static int compare_port(struct device *dev, void *data)
>  {
> +	struct device_node *np = data;
> +	return dev->parent->of_node == np;
> +}

which means the comparison is:

	dev->parent->of_node == port

which is a different comparison from the above.

You instead want this to be:

	return dev->of_node == np->parent;

Heiko, please test the above change to compare_port() - I think you'll
find that will fix your issue.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
