From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Mar 2014 11:38:18 -0700
Subject: [PATCH v2] ARM: mm: fix reporting of read-only PMD bits
In-Reply-To: <20140212224357.GA4286@www.outflux.net>
References: <20140212224357.GA4286@www.outflux.net>
Message-ID: <CAGXu5jJOUqvkjkcqJWMBG_UFvuvbr_=HDjph8A2uAZW0aQPR4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 2:43 PM, Kees Cook <keescook@chromium.org> wrote:
> On non-LPAE, read-only PMD bits are defined with the combination
> "PMD_SECT_APX | PMD_SECT_AP_WRITE". Adjusted the bit masks to correctly
> detect this.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
>  - reorder bits, suggested by Olof Johansson.
> ---
>  arch/arm/mm/dump.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 2b3a56414271..2b342177f5de 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -123,19 +123,19 @@ static const struct prot_bits section_bits[] = {
>  #ifndef CONFIG_ARM_LPAE
>         /* These are approximate */
>         {
> -               .mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> -               .val    = 0,
> +               .mask   = PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +               .val    = PMD_SECT_APX | PMD_SECT_AP_WRITE,
>                 .set    = "    ro",
>         }, {

As Russell pointed out, this won't be valid for pre-v6 CPUs. What's
the best config for handling this? I'd like something like
CONFIG_ARM_LPAE, but using the CPU_* stuff seems a bit sloppy:

#if !defined(CONFIG_ARM_CPU_V6) && !defined(CONFIG_ARM_CPU_V7)
...new masks...
#else
...old masks...
#endif

But that seems to be the only thing I can find. Is CPU_* good enough here?

-Kees

> -               .mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +               .mask   = PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>                 .val    = PMD_SECT_AP_WRITE,
>                 .set    = "    RW",
>         }, {
> -               .mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +               .mask   = PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>                 .val    = PMD_SECT_AP_READ,
>                 .set    = "USR ro",
>         }, {
> -               .mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +               .mask   = PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>                 .val    = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>                 .set    = "USR RW",
>  #else
> --
> 1.7.9.5
>
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security
