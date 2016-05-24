From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 24 May 2016 11:09:42 +0100
Subject: [PATCH] hwrng: stm32 - fix build warning
In-Reply-To: <CALszF6BPPA=tezMLhmdC4YFwmH1tGhDxCNDZNwGp1cTDWP7Fmg@mail.gmail.com>
References: <1464007448-25395-1-git-send-email-sudipm.mukherjee@gmail.com>
 <6297051.TAxtzW5OIB@wuerfel>
 <CALszF6AxXY0LK5fToFg3095+gz6xcZz8KHaYqc=o39vjpBYDmA@mail.gmail.com>
 <12548318.auB4PSA3KC@wuerfel>
 <CALszF6BPPA=tezMLhmdC4YFwmH1tGhDxCNDZNwGp1cTDWP7Fmg@mail.gmail.com>
Message-ID: <56bb8ec4-fe7e-ec09-adc3-ec7eea2d7ddd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/16 09:50, Maxime Coquelin wrote:
> diff --git a/drivers/char/hw_random/stm32-rng.c
> b/drivers/char/hw_random/stm32-rng.c
> index 92a810648bd0..2a0fc90e4dc3 100644
> --- a/drivers/char/hw_random/stm32-rng.c
> +++ b/drivers/char/hw_random/stm32-rng.c
> @@ -68,6 +68,10 @@ static int stm32_rng_read(struct hwrng *rng, void
> *data, size_t max, bool wait)
>                         } while (!sr && --timeout);
>                 }
>
> +               if (WARN_ONCE(sr & (RNG_SR_SEIS | RNG_SR_CEIS),
> +                               "bad RNG status - %x\n", sr))
> +                       writel_relaxed(0, priv->base + RNG_SR);
> +
>                 /* If error detected or data not ready... */
>                 if (sr != RNG_SR_DRDY)
>                         break;

Minor quibble but I might prefer that the error handling/recovery 
actually be put on the error path itself (included in the if (sr != 
RNG_SR_DRDY) ).


Daniel.
