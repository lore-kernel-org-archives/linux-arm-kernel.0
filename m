From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Apr 2015 16:49:17 +0100
Subject: [PATCH 2/6] ARM: keystone2: move update of the phys-to-virt
 constants into generic code
In-Reply-To: <552691E2.2050000@linaro.org>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk>
 <552541B1.2000501@linaro.org>
 <20150408175959.GO12732@n2100.arm.linux.org.uk>
 <552691E2.2050000@linaro.org>
Message-ID: <20150409154917.GY12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 05:51:14PM +0300, Grygorii.Strashko at linaro.org wrote:
> @@ -1401,14 +1401,15 @@ void __init early_paging_init(const struct machine_desc *mdesc)
>  	pgtables_remap *lpae_pgtables_remap;
>  	unsigned long pa_pgd;
>  	unsigned int cr;
> -	long long offset;
> +	phys_addr_t new_phys_offset;
> +	phys_addr_t old_phys_offset = PHYS_OFFSET;
>  	void *boot_data;
>  
>  	if (!mdesc->pv_fixup)
>  		return;
>  
> -	offset = mdesc->pv_fixup();
> -	if (offset == 0)
> +	new_phys_offset = mdesc->pv_fixup();
> +	if (new_phys_offset == 0)

"0" is a special magic value here.  The advantage of the delta approach
is that "0" is obviously equivalent to "no change".

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
