From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 16:05:37 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
Message-ID: <20111117160536.GU9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:04PM +0000, Pawel Moll wrote:
> +#if defined(CONFIG_ARCH_VEXPRESS_DT)
> +		int err;
> +		const char *path;
> +		struct device_node *node;
> +
> +		node = of_find_compatible_node(NULL, NULL, "arm,sp810");
> +		BUG_ON(!node);
> +		sysctl_base = of_iomap(node, 0);
> +		BUG_ON(!sysctl_base);
> +
> +		err = of_property_read_string(of_aliases, "timer", &path);
> +		BUG_ON(err);
> +		node = of_find_node_by_path(path);
> +		BUG_ON(!node);
> +		timer01_base = of_iomap(node, 0);
> +		BUG_ON(!timer01_base);
> +		timer01_irq = irq_of_parse_and_map(node, 0);

Are you sure you have enough BUG_ON()s there?  It's well worth reading
Linus' various messages on the use of BUG(), which can be found:

	http://yarchive.net/comp/linux/BUG.html

The lack of the timer and sysctl registers are really a 'report and maybe
we could get a message out' kind of scenario rather than a 'oops, kill
the machine'.

> +#endif
> +	} else {
>  		sysctl_base = ioremap(V2M_SYSCTL, SZ_4K);
>  		BUG_ON(!sysctl_base);
>  		timer01_base = ioremap(V2M_TIMER01, SZ_4K);
>  		BUG_ON(!timer01_base);
>  		timer01_irq = IRQ_V2M_TIMER0;
> +	}

And in any case, both these paths have a common set of BUG_ON()s:
	BUG_ON(!sysctl_base);
	BUG_ON(!timer01_base);

So do we really need them having this independently?

> @@ -383,11 +412,18 @@ static struct clk_lookup v2m_lookups[] = {
>  	},
>  };
>  
> +static void __init v2m_system_id(void)
> +{
> +	if (!system_rev)
> +		system_rev = readl(v2m_sysreg_base + V2M_SYS_ID);

You do understand that system_rev is for the system _revision_ not for
some kind of system ID.  For example, it's to identify whether we're on
a revision 4, 5 or 6 system.

However, with DT the differences in system revision should be encoded
into the DT itself, and the kernel should not be making choices about
the hardware off this.
