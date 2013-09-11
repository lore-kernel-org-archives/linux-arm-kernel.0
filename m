From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 09:54:00 +0200
Subject: [PATCH RFC] of: add a basic memory driver
In-Reply-To: <1378863781-4235-1-git-send-email-emilio@elopez.com.ar>
References: <1378863781-4235-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130911075400.GG2746@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Tue, Sep 10, 2013 at 10:43:01PM -0300, Emilio L?pez wrote:
> This driver's only job is to claim and ensure that the necessary clock
> for memory operation on a DT-enabled machine remains enabled.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> Hi,
> 
> I am currently facing an issue with the clock setup: a critical but
> unclaimed clock gets disabled as a side effect of disabling one of its
> children. The clock setup looks something like this:
> 
>       PLL
>        |
>  ------------
>  |          |
> DDR       Others
>             |
>           periph
> 
> The PLL clock is marked with the CLK_IGNORE_UNUSED flag, so on a normal
> boot it remains on, even after the unused clocks cleanup code runs. The
> problem occurs when someone enables "periph" and then, later on, disables
> it: the framework starts disabling clocks upwards on the tree, 
> eventually switching the PLL off (and that kills the machine, as the memory
> clock is shut down).

That looks like a bug in the clock framework. I'd expect it to at least
behave in the same way when disabling the unused clocks at late startup
and when going up disabling some clocks' parent later on.

> There's two possible solutions I can think of:
>  1) add some extra checks on the framework to not turn off clocks marked
>     with such a flag on the non-explicit case (ie, when I'm disabling
>     some other clock)
> 
>  2) create an actual user of the DDR clock, that way it won't get
>     disabled simply because it's being used.
> 
> I considered 1) and implemented it, but the result was not pretty.

What was not pretty about it?

> This patch is my take on 2). Please let me know what you think; all
> feedback is welcome :)
> 
> Cheers,
> 
> Emilio
> 
>  drivers/of/Kconfig     |  6 ++++++
>  drivers/of/Makefile    |  1 +
>  drivers/of/of_memory.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 drivers/of/of_memory.c
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 9d2009a..f6c5e20 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -80,4 +80,10 @@ config OF_RESERVED_MEM
>  	help
>  	  Initialization code for DMA reserved memory
>  
> +config OF_MEMORY
> +	depends on COMMON_CLK
> +	def_bool y
> +	help
> +	  Simple memory initialization
> +
>  endmenu # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index ed9660a..15f0167 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_OF_PCI)	+= of_pci.o
>  obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
>  obj-$(CONFIG_OF_MTD)	+= of_mtd.o
>  obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
> +obj-$(CONFIG_OF_MEMORY) += of_memory.o
> diff --git a/drivers/of/of_memory.c b/drivers/of/of_memory.c
> new file mode 100644
> index 0000000..a833f7a
> --- /dev/null
> +++ b/drivers/of/of_memory.c
> @@ -0,0 +1,30 @@
> +/*
> + * Simple memory driver
> + */
> +
> +#include <linux/of.h>
> +#include <linux/clk.h>
> +
> +static int __init of_memory_enable(void)
> +{
> +	struct device_node *np;
> +	struct clk *clk;
> +
> +	np = of_find_node_by_path("/memory");
> +	if (!np) {
> +		pr_err("no /memory on DT!\n");
> +		return 0;
> +	}
> +
> +	clk = of_clk_get(np, 0);
> +	if (!IS_ERR(clk)) {
> +		clk_prepare_enable(clk);
> +		clk_put(clk);
> +	}
> +
> +	of_node_put(np);
> +
> +	return 0;
> +}
> +
> +device_initcall(of_memory_enable);

I like this idea as well. But imho, both 1 and 2 should be done. 2) is
only about memory devices, while 1) is much more generic.

And fwiw, the Marvell Armada 370 is also in this case of having a
gatable clock for the DDR that could potentially be disabled (but is
not, since it has no other users than the DDR itself, and as such, no
one ever calls clk_disable on it). 

Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/bfe85d37/attachment.sig>
