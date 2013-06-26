From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 26 Jun 2013 14:24:11 +0100
Subject: [PATCH 4/4] init: efi: arm: enable (U)EFI runtime services on arm
In-Reply-To: <1372183863-11333-5-git-send-email-leif.lindholm@linaro.org>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-5-git-send-email-leif.lindholm@linaro.org>
Message-ID: <CACxGe6tRBQdxN=5SrO7ES0N3R+nPeVpJDkBx5WHtKQSxPHb01Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 7:11 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> Since the efi_set_virtual_address_map call has strict init ordering
> requirements, add an explicit hook in the required place.
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  init/main.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/init/main.c b/init/main.c
> index 9484f4b..c61706e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -872,6 +872,12 @@ static noinline void __init kernel_init_freeable(void)
>         smp_prepare_cpus(setup_max_cpus);
>
>         do_pre_smp_initcalls();
> +
> +#ifdef CONFIG_ARM
> +       if (efi_enabled(EFI_RUNTIME_SERVICES))
> +               efi_enter_virtual_mode();
> +#endif

Nitpick:  Alternately you could use:

        if (IS_ENABLED(CONFIG_ARM) && efi_enabled(EFI_RUNTIME_SERVICES))
                efi_enter_virtual_mode();

That would get away from the #ifdef

g.
