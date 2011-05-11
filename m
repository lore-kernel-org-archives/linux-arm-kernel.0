From: joe@perches.com (Joe Perches)
Date: Tue, 10 May 2011 17:15:14 -0700
Subject: [PATCH] drivers: create a pinmux subsystem v2
In-Reply-To: <1305070783-23193-1-git-send-email-linus.walleij@linaro.org>
References: <1305070783-23193-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1305072914.19586.166.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-11 at 01:39 +0200, Linus Walleij wrote:
> This creates a subsystem for handling of pinmux devices.
[]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[]

Nice work and yes, more trivia...

> diff --git a/drivers/pinmux/core.c b/drivers/pinmux/core.c
[]
> +struct pin_desc {
> +	struct pinmux_dev *pmxdev;
> +	bool	requested;
> +	char	function[16];

Magic number 16 used here and a couple other places.

I also think function is a poor variable name for a descriptor.
Might ever this need the size increased or the use changed
to const char* func_desc (with kstrdup or equivalent)

> +	if (status) {
> +		pr_err("->request on device %s failed "
> +		       "for pin %d (offset %d)\n",

I think prefacing with "->" doesn't add anything and
I think it's better to ignore 80 column line lengths for
formats.  Maybe:

		pr_err("device %s: request for pin %d/offset %d failed\n",

> +	strncpy(desc->function, function, 16);
> +	desc->function[15] = '\0';

Here's that magic number again.  Maybe:
	strlcpy(desc->function, function, sizeof(desc->function));
or maybe:
	kstrdup(desc->func_name, function, GFP_KERNEL);

> +
> +out:
> +	spin_unlock_irqrestore(&pin_desc_lock, flags);
> +	if (status)
> +		pr_err("pin-%d (%s) status %d\n",
> +		       pin, function ? : "?", status);

Why test function for non-null only here?

> +int pinmux_register_mappings(struct pinmux_map const *maps, unsigned num_maps)

const struct pinmux_map *maps?
Normal kernel style uses const before struct.

> +void pinmux_put(struct pinmux *pmx)
[]
> +		pr_warn("pinmux: releasing pinmux with active users!\n");

I think you don't need the prefix anymore.

cheers, Joe
