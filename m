From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Feb 2017 16:07:06 +0000
Subject: [PATCH 7/7] efi: Print the secure boot status in x86 setup_arch()
 [ver #7]
In-Reply-To: <148587565838.4026.2835771993519594392.stgit@warthog.procyon.org.uk>
References: <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <148587565838.4026.2835771993519594392.stgit@warthog.procyon.org.uk>
Message-ID: <CAKv+Gu8otPYWcKw72zP2q+34JAzZ-QRy8xGFmbStO6WseeANdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2017 at 15:14, David Howells <dhowells@redhat.com> wrote:
> Print the secure boot status in the x86 setup_arch() but otherwise do
> nothing more for now.  More functionality will be added later, but this at
> least allows for testing.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  arch/x86/kernel/setup.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 4cfba947d774..22e4b47a5c14 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1176,6 +1176,20 @@ void __init setup_arch(char **cmdline_p)
>         /* Allocate bigger log buffer */
>         setup_log_buf(1);
>
> +       if (IS_ENABLED(CONFIG_EFI)) {

Shouldn't this be a runtime check?

> +               switch (boot_params.secure_boot) {
> +               case efi_secureboot_mode_disabled:
> +                       pr_info("Secure boot disabled\n");
> +                       break;
> +               case efi_secureboot_mode_enabled:
> +                       pr_info("Secure boot enabled\n");
> +                       break;
> +               default:
> +                       pr_info("Secure boot could not be determined\n");
> +                       break;
> +               }
> +       }
> +
>         reserve_initrd();
>
>         acpi_table_upgrade();
>
