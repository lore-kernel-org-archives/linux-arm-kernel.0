From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 7 Aug 2013 14:08:51 +0100
Subject: [PATCH 03/17] Add system pointer argument to shared EFI stub
 related functions so they no longer use global system table pointer as they
 did when part of eboot.c.
In-Reply-To: <1375847113-24884-4-git-send-email-roy.franz@linaro.org>
References: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
 <1375847113-24884-4-git-send-email-roy.franz@linaro.org>
Message-ID: <20130807130851.GC2515@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Aug, at 08:44:59PM, Roy Franz wrote:
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  arch/x86/boot/compressed/eboot.c       |   38 +++++++------
>  drivers/firmware/efi/efi-stub-helper.c |   96 +++++++++++++++++---------------
>  2 files changed, 72 insertions(+), 62 deletions(-)

For future reference you should really use a shorter first line in your
git commit message, which would produe a shorter subject when mailing
your patches.

I'll fix up the commit messages when I apply these patches, so don't
worry about it for now.

[...]

> @@ -19,15 +19,16 @@ struct initrd {
>  
>  
>  
> -static void efi_char16_printk(efi_char16_t *str)
> +static void efi_char16_printk(efi_system_table_t *sys_table_arg,
> +			      efi_char16_t *str)
>  {
>  	struct efi_simple_text_output_protocol *out;
>  
> -	out = (struct efi_simple_text_output_protocol *)sys_table->con_out;
> +	out = (struct efi_simple_text_output_protocol *)sys_table_arg->con_out;
>  	efi_call_phys2(out->output_string, out, str);
>  }
>  
> -static void efi_printk(char *str)
> +static void efi_printk(efi_system_table_t *sys_table_arg, char *str)
>  {
>  	char *s8;
>  

Hmm... I'm not necessarily convinced this is an improvement over using
some kind of a global pointer to the EFI System Table.

Parameterizing stuff like this is useful when the argument changes at
runtime from call to call, but that isn't the case for the boot stubs. I
don't think there's anything wrong with a global in this scenario, and
this patch is a fair amount of churn for no real improvement.

-- 
Matt Fleming, Intel Open Source Technology Center
