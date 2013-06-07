From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 21:10:35 +0200
Subject: [PATCH 03/14] bus: mvebu-mbus: Introduce device tree binding
In-Reply-To: <1370623671-7748-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201306072110.35856.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Ezequiel Garcia wrote:
> +       np = of_find_matching_node(NULL, of_mvebu_mbus_ids);
> +       if (!np) {
> +               pr_err("could not find a matching SoC family\n");
> +               return -ENODEV;
> +       }
> +
> +       of_id = of_match_node(of_mvebu_mbus_ids, np);
> +       mbus_state.soc = of_id->data;
> +
> +       if (of_address_to_resource(np, 0, &mbuswins_res)) {
> +               pr_err("cannot get MBUS register address\n");
> +               return -EINVAL;
> +       }
> +
> +       if (of_address_to_resource(np, 1, &sdramwins_res)) {
> +               pr_err("cannot get SDRAM register address\n");
> +               return -EINVAL;
> +       }

Just an idea to make this more regular: Since the internal-regs can no longer
be regarded as a fixed location, we might want to use the same "ranges" property
mechanism for resolving the internal regs as we use for everything else.

This would imply that the device node this driver binds to would actually
end up being a child of the bus itself, which then goes on to modify the
ranges property of its parent node. Does that make sense?

	Arnd
