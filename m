From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 28 Jun 2010 14:04:56 +0200
Subject: [PATCH 2/3] pxa2xx/cpufreq: Simplify DRI recomputation routine
In-Reply-To: <AANLkTilIQOmzV5JNk63dQvCViFjYOASLuZ39AZKykf6Z@mail.gmail.com>
References: <1277387833-5419-1-git-send-email-marek.vasut@gmail.com>
	<1277387833-5419-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTilIQOmzV5JNk63dQvCViFjYOASLuZ39AZKykf6Z@mail.gmail.com>
Message-ID: <201006281404.56236.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 28. ?ervna 2010 06:38:16 Eric Miao napsal(a):
> On Thu, Jun 24, 2010 at 9:57 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > This patch:
> > 1) Simpifies the DRI recomputation routine by pulling out the common code
> > 2) Fixes a bug in PXA27x DRI recomputation caused by incorrect
> > parenthesis
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Good catch, I've modified it a bit so it's more compact and reable below
> and I'll apply this to the 'fix' branch.

Ewww ... I'm kind-of missing the readability now ;-)

But I guess if you look into it for a long enough time, it's ok.

Acked-by: Marek Vasut <marek.vasut@gmail.com>

> 
> diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> index 9e4d981..268a9bc 100644
> --- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> +++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> @@ -256,13 +256,9 @@ static void init_sdram_rows(void)
> 
>  static u32 mdrefr_dri(unsigned int freq)
>  {
> -       u32 dri = 0;
> +       u32 interval = freq * SDRAM_TREF / sdram_rows;
> 
> -       if (cpu_is_pxa25x())
> -               dri = ((freq * SDRAM_TREF) / (sdram_rows * 32));
> -       if (cpu_is_pxa27x())
> -               dri = ((freq * SDRAM_TREF) / (sdram_rows - 31)) / 32;
> -       return dri;
> +       return (interval - (cpu_is_pxa27x() ? 31 : 0)) / 32;
>  }
> 
>  /* find a valid frequency point */
> 
> > ---
> >  arch/arm/mach-pxa/cpufreq-pxa2xx.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> > b/arch/arm/mach-pxa/cpufreq-pxa2xx.c index 9e4d981..bb5f21e 100644
> > --- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> > +++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> > @@ -256,12 +256,13 @@ static void init_sdram_rows(void)
> > 
> >  static u32 mdrefr_dri(unsigned int freq)
> >  {
> > -       u32 dri = 0;
> > +       u32 dri = freq * SDRAM_TREF / sdram_rows;
> > 
> > -       if (cpu_is_pxa25x())
> > -               dri = ((freq * SDRAM_TREF) / (sdram_rows * 32));
> >        if (cpu_is_pxa27x())
> > -               dri = ((freq * SDRAM_TREF) / (sdram_rows - 31)) / 32;
> > +               dri -= 31;
> > +
> > +       dri /= 32;
> > +
> >        return dri;
> >  }
> > 
> > --
> > 1.7.1
