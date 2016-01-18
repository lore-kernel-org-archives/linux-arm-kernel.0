From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 11:03:19 +0000
Subject: [PATCH v2 14/16] Xen: EFI: Parse DT parameters for Xen specific
 UEFI
In-Reply-To: <1452840929-19612-15-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-15-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160118110319.GF21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:55:27PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a new function to parse DT parameters for Xen specific UEFI just
> like the way for normal UEFI. Then it could reuse the existing codes.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)

> @@ -520,15 +531,28 @@ static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
>  				       int depth, void *data)
>  {
>  	struct param_info *info = data;
> +	struct params *dt_params;
> +	unsigned int size;
>  	const void *prop;
>  	void *dest;
>  	u64 val;
>  	int i, len;
>  
> -	if (depth != 1 || strcmp(uname, "chosen") != 0)
> -		return 0;
> +	if (efi_enabled(EFI_PARAVIRT)) {
> +		if (depth != 2 || strcmp(uname, "uefi") != 0)
> +			return 0;

Please check the full path rather than the leaf node name alone.

Mark.
