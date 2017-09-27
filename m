From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 26 Sep 2017 17:40:20 -0700
Subject: [PATCH 3/3] arm64: cpuinfo: display product info in /proc/cpuinfo
In-Reply-To: <20170926222324.17409-4-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-4-ahs3@redhat.com>
Message-ID: <d186c3fa-5d6f-8865-b824-efcdc7184cb3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2017 03:23 PM, Al Stone wrote:
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

[snip]

> +/* Look up the baseboard info in DMI */
> +static void get_dmi_product_info(void)
> +{
> +	if (!dmi_product_info) {
> +		dmi_product_info = kcalloc(DMI_MAX_STRLEN,
> +					   sizeof(char), GFP_KERNEL);
> +		if (!dmi_product_info)
> +			return;
> +	}
> +
> +	dmi_walk(find_dmi_product_info, dmi_product_info);
> +}

Don't you need all of these DMI-related functions you defined to be also
enclosed within an #if IS_ENABLED(CONFIG_DMI) otherwise chances are that
we are going to get defined but unused warnings?


>  		impl = (u8) MIDR_IMPLEMENTOR(midr);
>  		for (j = 0; hw_implementer[j].id != 0; j++) {
>  			if (hw_implementer[j].id == impl) {
> @@ -208,7 +341,7 @@ static int c_show(struct seq_file *m, void *v)
>  		part = (u16) MIDR_PARTNUM(midr);
>  		for (j = 0; parts[j].id != (-1); j++) {
>  			if (parts[j].id == part) {
> -				seq_printf(m, "%s\n", parts[j].name);
> +				seq_printf(m, "%s ", parts[j].name);
>  				break;
>  			}

Should this hunk be part of patch 3?
-- 
Florian
