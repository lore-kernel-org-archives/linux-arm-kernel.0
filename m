From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 13 Jan 2014 15:04:06 +0000
Subject: [PATCH V6 3/8] Add helper function to get and convert EFI
 command line
In-Reply-To: <1389371417-379-4-git-send-email-roy.franz@linaro.org>
References: <1389371417-379-1-git-send-email-roy.franz@linaro.org>
 <1389371417-379-4-git-send-email-roy.franz@linaro.org>
Message-ID: <20140113150406.GE3256@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jan, at 08:30:12AM, Roy Franz wrote:
> Add an EFI stub helper function to retrieve the EFI command line using
> the LOADED_IMAGE_PROTOCOL, and convert it to ASCII.  This function will
> be shared by the various EFI stub implementations.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  drivers/firmware/efi/efi-stub-helper.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
> index eb5d2eb..f657456 100644
> --- a/drivers/firmware/efi/efi-stub-helper.c
> +++ b/drivers/firmware/efi/efi-stub-helper.c
> @@ -637,3 +637,33 @@ static char *efi_convert_cmdline_to_ascii(efi_system_table_t *sys_table_arg,
>  	*cmd_line_len = options_size;
>  	return (char *)cmdline_addr;
>  }
> +
> +/*
> + * get the command line from EFI, using the LOADED_IMAGE
> + * protocol, and convert to ASCII.
> + *
> + */
> +static void efi_get_cmdline(efi_system_table_t *sys_table,
> +			      efi_loaded_image_t **image,
> +			      void *handle, char **cmdline_ptr)
> +{

Wouldn't this prototype make more sense?

static char *efi_get_cmdline(efi_system_table_t *sys_table,
			     efi_loaded_image_t **image,
			     void *handle);

Is this function really worth implementing at all? Certainly on x86, we
lookup the loaded image protocol for reasons other than parsing the
command line, and so would need to do it in the caller anyway.

-- 
Matt Fleming, Intel Open Source Technology Center
