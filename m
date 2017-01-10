From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 10 Jan 2017 21:41:24 +0100
Subject: [PATCH net-next 6/8] net: dsa: Add support for platform data
In-Reply-To: <20170110201235.21771-7-f.fainelli@gmail.com>
References: <20170110201235.21771-1-f.fainelli@gmail.com>
 <20170110201235.21771-7-f.fainelli@gmail.com>
Message-ID: <20170110204124.GL22820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -452,11 +455,14 @@ static int dsa_cpu_parse(struct dsa_port *port, u32 index,
>  	struct net_device *ethernet_dev;
>  	struct device_node *ethernet;
>  
> -	ethernet = of_parse_phandle(port->dn, "ethernet", 0);
> -	if (!ethernet)
> -		return -EINVAL;
> +	if (port->dn) {
> +		ethernet = of_parse_phandle(port->dn, "ethernet", 0);
> +		if (!ethernet)
> +			return -EINVAL;
> +		ethernet_dev = of_find_net_device_by_node(ethernet);
> +	} else
> +		ethernet_dev = dev_to_net_device(dst->pd->netdev);

Hi Florian

This is not going to work with John's rework of my multi CPU ports
code. I think you are going to have to modify the platform_data
structure to support multi-CPU ports.

I put higher priority on cleanly integrating multi-CPU ports using
device tree, than supporting legacy platforms. I'm O.K. with
preparatory patches, but i think we should wait for actually platform
data changes until after Johns code has landed and we can design the
platform_data to work with it.

	      Andrew
