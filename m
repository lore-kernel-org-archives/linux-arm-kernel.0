From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 12:49:09 +0200
Subject: [PATCH v9 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1431623147-4950-5-git-send-email-lho@apm.com>
References: <1431623147-4950-1-git-send-email-lho@apm.com>
 <1431623147-4950-4-git-send-email-lho@apm.com>
 <1431623147-4950-5-git-send-email-lho@apm.com>
Message-ID: <4813332.ncdNtLvLzH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 11:05:46 Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

Looks much better than before.

>  
> +config EDAC_XGENE
> +	tristate "APM X-Gene SoC"
> +	depends on EDAC_MM_EDAC && ARM64
> +	help
> +	  Support for error detection and correction on the
> +	  APM X-Gene family of SOCs.
> +
>  endif # EDAC

Maybe 'ARM64 || COMPILE_TEST', so we get build coverage on x86 with allmodconfig?

> +	rc = of_property_read_u32_array(np, "reg", addr_res, 4);
> +	if (rc < 0) {
> +		dev_err(edac->dev, "no MCU resource address\n");
> +		goto err_group;
> +	}
> +	tmp_ctx.mcu_csr = devm_ioremap(edac->dev,
> +				       MAKEU64(addr_res[0], addr_res[1]),
> +				       MAKEU64(addr_res[2], addr_res[3]));
> +	if (IS_ERR(tmp_ctx.mcu_csr)) {
> +		dev_err(edac->dev, "unable to map MCU resource\n");
> +		rc = PTR_ERR(tmp_ctx.mcu_csr);
> +		goto err_group;
> +	}

This is incorrect, you have to use of_get_address() or of_address_to_resource()
to compute the CPU-relative address: The address that is used within the
node may not be the same, depending on the parent's ranges properties.
See also my comment about the missing ranges in the DT example.

	Arnd
