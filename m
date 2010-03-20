From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 20 Mar 2010 17:00:50 +0000
Subject: [PATCH 1/6] ASoC: split pxa ssp for reusing code
In-Reply-To: <771cded01003190851w2bb94ca2w1faf2a5fffa11794@mail.gmail.com>
References: <771cded01003190851w2bb94ca2w1faf2a5fffa11794@mail.gmail.com>
Message-ID: <20100320170049.GB1549@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 11:51:55AM -0400, Haojian Zhuang wrote:
> Subject: [PATCH] ASoC: split pxa ssp for reusing code

Again, please remember to CC ALSA patches to the ALSA list.  You should
also remember to CC Liam, my ASoC comaintainer.

> hw_params() isn't put in common ssp files since cpu_is_pxa3xx() is used. The
> cpu_is_pxa3xx() macro is only valid in ARCH_PXA and it's used to distinguish
> pxa2xx and pxa3xx. This macro is meaning less in other architectures. So keep
> this function in device specific driver.

Looking at the code it seems (like I mentioned before) it'd be much
better to factor this out so that the common code is in a library
function which both PXA and MMP variants can use it, with the PXA3xx
specific stuff calling the library function and overriding its behaviour
(eg, by overwriting the registers) where required.

Like I keep saying the SSP port configuration is really rather fragile
(in part due to the documentation issues) so forking this code seems
like it's going to be painful in the long run.

Some other stuff below...

> - * TODO:
> - *  o Test network mode for > 16bit sample size

Have you actually done this testing?

> -static void ssp_enable(struct ssp_device *ssp)
> +void ssp_enable(struct ssp_device *ssp)
>  {
>  	uint32_t sscr0;
> 

If this is being marked non-static presumably it should be exported too?
Similarly for most of the other functions.  Might be worth considering
the namespacing too and shoving some pxa_ or similar prefixes on there
if the function is going global, right now there's a mix of ssp_ and
pxa_ssp_ being exported.

> +/*
> + * pxa2xx-ssp.c  --  ALSA Soc Audio Layer
> + *

I'm not a big fan of the naming here since this also covers PXA3xx
devices.  Is there some general term for the non-MMP processors which
could be used - I'm not aware of one but I might've missed something?

> +enum {
> +	PXA2XX_DAI_SSP1,
> +	PXA2XX_DAI_SSP2,
> +	PXA2XX_DAI_SSP3,
> +	PXA2XX_DAI_SSP4,
> +	PXA2XX_DAI_SSP_MAX,
> +};

TBH I'd be much happier with #defines here - the use of an enum is
rather random given that none of the other defines use one and since the
particular values on this one really matter (as a result of being array
indexes) something that sets the values explicitly seems better.
