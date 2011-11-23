From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Nov 2011 16:10:28 +0000
Subject: [PATCH v2 2/4] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1322060508-11298-3-git-send-email-pawel.moll@arm.com>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <1322060508-11298-3-git-send-email-pawel.moll@arm.com>
Message-ID: <1322064628.3093.447.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-23 at 15:01 +0000, Pawel Moll wrote:
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index ee52b35..fd7ee1f 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
[...]
> +		node = of_find_compatible_node(NULL, NULL, "arm,sp810");
> +		if (node)
> +			sysctl_base = of_iomap(node, 0);
> +
> +		err = of_property_read_string(of_aliases, "timer", &path);
> +		if (!err)
> +			node = of_find_node_by_path(path);
> +		if (node) {
> +			timer01_base = of_iomap(node, 0);
> +			timer01_irq = irq_of_parse_and_map(node, 0);
> +		}

I've just realized that this fragment should actually look like that:

                node = of_find_compatible_node(NULL, NULL, "arm,sp810");
                sysctl_base = of_iomap(node, 0);
                
                err = of_property_read_string(of_aliases, "timer", &path);
                if (!err) {
                        node = of_find_node_by_path(path);
                        timer01_base = of_iomap(node, 0);
                        timer01_irq = irq_of_parse_and_map(node, 0);
                }

I will change that.

Cheers!

Pawel
