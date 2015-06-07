From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 07 Jun 2015 18:03:06 +0100
Subject: [PATCH v4 2/2] arch: arm: Show the serial number from
 devicetree =?iso-8859-1?Q?in=0D?= cpuinfo
In-Reply-To: <1430206196-3483-2-git-send-email-contact@paulk.fr>
References: <1430206196-3483-1-git-send-email-contact@paulk.fr>
 <1430206196-3483-2-git-send-email-contact@paulk.fr>
Message-ID: <20150607170306.376FBC40580@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Apr 2015 09:29:56 +0200
, Paul Kocialkowski <contact@paulk.fr>
 wrote:
> This grabs the serial number shown in cpuinfo from the serial-number devicetree
> property in priority. When booting with ATAGs (and without device-tree), the
> provided number is still shown instead.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

One comment below, but otherwise:

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  arch/arm/include/asm/system_info.h |  1 +
>  arch/arm/kernel/setup.c            | 23 +++++++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
> index 720ea03..3860cbd40 100644
> --- a/arch/arm/include/asm/system_info.h
> +++ b/arch/arm/include/asm/system_info.h
> @@ -17,6 +17,7 @@
>  
>  /* information about the system we're running on */
>  extern unsigned int system_rev;
> +extern const char *system_serial;
>  extern unsigned int system_serial_low;
>  extern unsigned int system_serial_high;
>  extern unsigned int mem_fclk_21285;
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 1d60beb..b501754 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -93,6 +93,9 @@ unsigned int __atags_pointer __initdata;
>  unsigned int system_rev;
>  EXPORT_SYMBOL(system_rev);
>  
> +const char *system_serial;
> +EXPORT_SYMBOL(system_serial);
> +

Is there any need to export this symbol? It's only used by built-in
code. Not by modules.

>  unsigned int system_serial_low;
>  EXPORT_SYMBOL(system_serial_low);
>  
> @@ -821,8 +824,25 @@ arch_initcall(customize_machine);
>  
>  static int __init init_machine_late(void)
>  {
> +	struct device_node *root;
> +	int ret;
> +
>  	if (machine_desc->init_late)
>  		machine_desc->init_late();
> +
> +	root = of_find_node_by_path("/");
> +	if (root) {
> +		ret = of_property_read_string(root, "serial-number",
> +					      &system_serial);

of_property_read_string() will not modify the argument on failure. If
system_serial is initialized to NULL, then the failure path is
unnecessary.

> +		if (ret)
> +			system_serial = NULL;
> +	}

Calls to of_find_node* functions increment the refcount for the node.
Need an of_node_put() here, or just use the of_root pointer directly. It
is safe to call of_property_read_string() with a NULL node pointer too,
it will fail gracefully.

So, the whole thing can safely boil down to:

	of_property_read_string(of_root, "serial-number", &system_serial);
	if (!system_serial)
		system_serial = kasprintf(GFP_KERNEL, "%08x%08x",
					  system_serial_high, system_serial_low);

g.
