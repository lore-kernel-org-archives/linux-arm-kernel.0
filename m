From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 17:17:43 -0600
Subject: [PATCHv4 RESEND 0/6] arm: vt8500: Add support for pinctrl/gpio
 module
In-Reply-To: <1364877661-26086-1-git-send-email-linux@prisktech.co.nz>
References: <1364877661-26086-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <515B6717.1060602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2013 10:40 PM, Tony Prisk wrote:
> Sorry - got Linus W's email address wrong in first send.
> 
> v4 changes:
> Changed as requested by Stephen Warren:
> Corrected the range checking in of_property_read_u32_index().
> Fix configs[0] assignment in wmt_pctl_dt_node_to_map_pull().
> Move the platform memory mapping from per-soc to common init.
> Drop the custom .of_xlate function and use the default of_gpio_simple_xlate.

Those changes all look fine.

> Remove the kfree(maps) call, and use devm_kzalloc to simplify the fail path.

I'm not sure that's a good idea.

The issue is that dt_node_to_maps() is called every time a pinctrl
consumer is probed, whereas the devm_kzalloc() call in dt_node_to_maps()
uses the pinctrl device itself, not the pinctrl consumer device.. Each
client's probe() could be deferred a few times. Hence, you may end up
accumulating all those map entries from the deferred probes, until the
pinctrl driver itself is remove()d. Similarly, if you unload/load a
(pinctrl client) driver module over and over, the same thing will happen.

Oh, and you left the following in there too:

> +static void wmt_pctl_dt_free_map(struct pinctrl_dev *pctldev,

> +	kfree(maps);
