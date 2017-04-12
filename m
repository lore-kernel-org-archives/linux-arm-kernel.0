From: bp@alien8.de (Borislav Petkov)
Date: Wed, 12 Apr 2017 18:51:26 +0200
Subject: [PATCH V14 03/10] efi: parse ARM processor error
In-Reply-To: <1490729440-32591-4-git-send-email-tbaicar@codeaurora.org>
References: <1490729440-32591-1-git-send-email-tbaicar@codeaurora.org>
 <1490729440-32591-4-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170412165125.xzsovuficgbygkfp@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 01:30:33PM -0600, Tyler Baicar wrote:
> Add support for ARM Common Platform Error Record (CPER).
> UEFI 2.6 specification adds support for ARM specific
> processor error information to be reported as part of the
> CPER records. This provides more detail on for processor error logs.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> CC: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Reviewed-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/cper.c | 133 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |  54 ++++++++++++++++++
>  2 files changed, 187 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 8fa4e23..56aa516 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -110,12 +110,15 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>  static const char * const proc_type_strs[] = {
>  	"IA32/X64",
>  	"IA64",
> +	"ARM",
>  };
>  
>  static const char * const proc_isa_strs[] = {
>  	"IA32",
>  	"IA64",
>  	"X64",
> +	"ARM A32/T32",
> +	"ARM A64",
>  };
>  
>  static const char * const proc_error_type_strs[] = {
> @@ -139,6 +142,18 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>  	"corrected",
>  };
>  
> +static const char * const arm_reg_ctx_strs[] = {
> +	"AArch32 general purpose registers",
> +	"AArch32 EL1 context registers",
> +	"AArch32 EL2 context registers",
> +	"AArch32 secure context registers",
> +	"AArch64 general purpose registers",
> +	"AArch64 EL1 context registers",
> +	"AArch64 EL2 context registers",
> +	"AArch64 EL3 context registers",
> +	"Misc. system register structure",
> +};

That...

> +
>  static void cper_print_proc_generic(const char *pfx,
>  				    const struct cper_sec_proc_generic *proc)
>  {
> @@ -184,6 +199,114 @@ static void cper_print_proc_generic(const char *pfx,
>  		printk("%s""IP: 0x%016llx\n", pfx, proc->ip);
>  }
>  
> +static void cper_print_proc_arm(const char *pfx,
> +				const struct cper_sec_proc_arm *proc)

... and that function should go into:

#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)

Just put them close together so that you don't have too much ifdeffery.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
