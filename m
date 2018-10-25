From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 08:25:04 -0500
Subject: [PATCH v3 1/3] of/fdt: Absorb ARM64's
 __early_init_dt_declare_initrd()
In-Reply-To: <20181025001742.6510-2-f.fainelli@gmail.com>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
 <20181025001742.6510-2-f.fainelli@gmail.com>
Message-ID: <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 7:17 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> ARM64 is the only architecture that requires a re-definition of
> __early_init_dt_declare_initrd(), absorb its custom implemention in
> drivers/of/fdt.c.
>
> Suggested-by: Rob Herring <robh@kernel.org.

You forgot a shift key. :)

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/of/fdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 800ad252cf9c..7d316f008f22 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -896,9 +896,14 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
>  static void __early_init_dt_declare_initrd(unsigned long start,
>                                            unsigned long end)
>  {
> +#if IS_ENABLED(CONFIG_ARM64)

C code, not preprocessor please.

> +       initrd_start = start;
> +       initrd_end = end;

Thinking some more about this, perhaps it is better to just add the
*_phys variants now along side the VA variants and set them here. Then
the arm64 code can override the initrd_start, initrd_end, and
initrd_below_start_ok values.

> +#else
>         initrd_start = (unsigned long)__va(start);
>         initrd_end = (unsigned long)__va(end);
>         initrd_below_start_ok = 1;
> +#endif
>  }
>  #endif
>
> --
> 2.17.1
>
