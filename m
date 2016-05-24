From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 May 2016 10:58:33 +0200
Subject: [PATCH] hwrng: stm32 - fix build warning
In-Reply-To: <CALszF6BPPA=tezMLhmdC4YFwmH1tGhDxCNDZNwGp1cTDWP7Fmg@mail.gmail.com>
References: <1464007448-25395-1-git-send-email-sudipm.mukherjee@gmail.com>
 <12548318.auB4PSA3KC@wuerfel>
 <CALszF6BPPA=tezMLhmdC4YFwmH1tGhDxCNDZNwGp1cTDWP7Fmg@mail.gmail.com>
Message-ID: <6044541.yeLQbYg2Jv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 24, 2016 10:50:17 AM CEST Maxime Coquelin wrote:
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
> @@ -79,10 +83,6 @@ static int stm32_rng_read(struct hwrng *rng, void
> *data, size_t max, bool wait)
>                 max -= sizeof(u32);
>         }
> 
> -       if (WARN_ONCE(sr & (RNG_SR_SEIS | RNG_SR_CEIS),
> -                     "bad RNG status - %x\n", sr))
> -               writel_relaxed(0, priv->base + RNG_SR);
> -
>         pm_runtime_mark_last_busy((struct device *) priv->rng.priv);
>         pm_runtime_put_sync_autosuspend((struct device *) priv->rng.priv);
> 
> Thanks,
> 

Yes, that looks good to me.

	Arnd
