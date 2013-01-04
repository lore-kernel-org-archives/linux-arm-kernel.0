From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Jan 2013 13:02:33 -0700
Subject: [PATCH] pinctrl/nomadik: Add "ste,config" property
In-Reply-To: <1357316010-677-1-git-send-email-linus.walleij@stericsson.com>
References: <1357316010-677-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50E73559.60508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 09:13 AM, Linus Walleij wrote:
> From: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
> 
> The "ste,config" property will contain the pin config node.
> It will be easier to define a pin configuration and use it by
> reference without duplicating lines tedious.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> diff --git a/Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt b/Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt

> -- ste,input : <0/1/2/3>
> +- ste,config: Handle of pin configuration node (ste,config = <&in_pu>)
> +
> +- ste,input : <0/1/2>

The changes to ste,input and ste,sleep-output look like some unrelated
change.

I guess the idea of ste,input is quite neat, but ...

>  Example board file extract:
>  
> +	in_pu: input_pull_up {
> +		ste,input = <1>;
> +	};

... these nodes shouldn't be placed at the top-level of the device tree;
housing them inside the pin controller node itself makes much more sense
since the pin controller binding is able/allowed to define what goes
inside the pin controller node, but shouldn't influence the top-level of
the device tree.

> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c

> +	np_config = of_parse_phandle(np, "ste,config", 0);
> +	if (np_config) {
> +		for (i = 0; i < ARRAY_SIZE(nmk_cfg_params); i++) {
> +			unsigned long cfg = 0;
> +			int val;

Is it worth making ste,config optional, so that config properties can be
placed either into the node directly, or into a node referenced by
ste,config? That might make doing one-off unusual configurations easier
- no need to create a separate node that's only used once. Still, if
that's unlikely on your HW, it's probably no big deal.
