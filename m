From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Jun 2013 09:13:54 +0200
Subject: [PATCH 3/5] of: net: introduce a of_set_mac_address() helper
 function
In-Reply-To: <1370414409-29991-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130605071354.GW8681@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 08:40:07AM +0200, Thomas Petazzoni wrote:
> The ARM MXS code already has some code to allocate and setup a
> property that contains the MAC address, and the Marvell Armada 370/XP
> code is going to gain a similar copy of this code. Therefore, let's
> add a small helper function that does that, in drivers/of/of_net.c.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_net.c    | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/of_net.h |  6 ++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
> index ffab033..02af898 100644
> --- a/drivers/of/of_net.c
> +++ b/drivers/of/of_net.c
> @@ -92,3 +92,39 @@ const void *of_get_mac_address(struct device_node *np)
>  	return NULL;
>  }
>  EXPORT_SYMBOL(of_get_mac_address);
> +
> +/**
> + * Set a MAC address of a given network interface device tree node, if
> + * none was already defined.
> + */
> +int of_set_mac_address(struct device_node *np, const void *mac)
> +{
> +	struct property *pp;
> +	int ret;
> +
> +	if (of_get_mac_address(np))
> +		return 0;

Hi Thomas

The semantics is a bit odd here for a set function. Only set if not
already set. From the function name, its not clear it has this extra
semantics. of_set_if_not_set_mac_address() seems a bit long, but makes
it clearer. Or maybe of_set_default_mac_address()?

I've no strong preference here, i just see the potential for bugs.

     Andrew
