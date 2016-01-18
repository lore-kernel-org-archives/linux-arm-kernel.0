From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 18 Jan 2016 13:04:08 +0000
Subject: [RFC PATCH v2] irqchip: Add support for Tango interrupt controller
In-Reply-To: <569CE0F2.1060507@sigmadesigns.com> (Marc Gonzalez's message of
 "Mon, 18 Jan 2016 13:56:18 +0100")
References: <569CE0F2.1060507@sigmadesigns.com>
Message-ID: <yw1xwpr7rqd3.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> +	if (of_property_read_u32(node, "reg", &ctl))
> +		panic("%s: failed to get reg base", node->name);
> +
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	chip->ctl = ctl;
> +	chip->base = base;

I think it might be better to let the OF core convert the "reg" property
to a struct resource, then get the offset by subtracting from the base
(physical) address.  Otherwise it will break badly if someone thinks
it's safe to drop "ranges" from the outer node and use absolute
addresses in the child nodes (that's how the "reg" property typically
behaves).

Anyway, thanks for revisiting this.  I never got a straight answer (or
any answer for that matter) when I asked which approach would be
preferred, and then I had better things to do than keep trying patches
until people got happy.

-- 
M?ns Rullg?rd
