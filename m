From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 27 Sep 2017 11:42:07 +0100
Subject: [PATCH 3/3] arm64: cpuinfo: display product info in /proc/cpuinfo
In-Reply-To: <20170926222324.17409-4-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-4-ahs3@redhat.com>
Message-ID: <f09e55d8-28ba-30e3-d58a-ad125fd73019@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/17 23:23, Al Stone wrote:
> While it is very useful to know what CPU is being used, it is also
> useful to know who made the platform being used.  On servers, this
> can point to the right person to contact when a server is having
> trouble.
> 
> Go get the product info -- manufacturer, product name and version --
> from DMI (aka SMBIOS) and display it in /proc/cpuinfo.  To look more
> like other server platforms, include the CPU type and frequency when
> displaying the product info, too.
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
[...]
> @@ -190,6 +298,31 @@ static int c_show(struct seq_file *m, void *v)
>  			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
>  				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
>  
> +		if (IS_ENABLED(CONFIG_DMI)) {
> +			seq_puts(m, "product name\t: ");
> +
> +			if (!dmi_product_info)
> +				get_dmi_product_info();
> +			if (dmi_product_info)
> +				seq_printf(m, "%s", dmi_product_info);
> +			else
> +				seq_puts(m, "<unknown>");
> +
> +			seq_printf(m, ", ARM 8.%d (r%dp%d) CPU",
> +				   MIDR_VARIANT(midr),
> +				   MIDR_VARIANT(midr),
> +				   MIDR_REVISION(midr));

What is "ARM 8.1" meant to infer for, say, a typical Cortex-A57?

Robin.

> +
> +			if (!dmi_max_mhz)
> +				dmi_max_mhz = get_dmi_max_mhz();
> +			if (dmi_max_mhz)
> +				seq_printf(m, " @ %d.%02dGHz\n",
> +					   (int)(dmi_max_mhz / 1000),
> +					   (int)(dmi_max_mhz % 1000));
> +			else
> +				seq_puts(m, " @ <unknown>GHz\n");
> +		}
> +
>  		impl = (u8) MIDR_IMPLEMENTOR(midr);
>  		for (j = 0; hw_implementer[j].id != 0; j++) {
>  			if (hw_implementer[j].id == impl) {
