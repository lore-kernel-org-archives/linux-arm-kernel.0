From: trblinux@gmail.com (Tushar Behera)
Date: Sat, 17 Jan 2015 14:21:46 +0900
Subject: [PATCH V3 09/15] ASoC: samsung: i2s: Protect more registers with
 a spinlock
In-Reply-To: <1421260962-16892-10-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
 <1421260962-16892-10-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAC5m3BxTkS3KtwUC6itMRF=545PoWJw1gYV6av3p7QjtVMFXTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 3:42 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Ensure the I2SMOD, I2SPSR registers, which are also exposed through
> clk API are only accessed with the i2s->spinlock spinlock held.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c |   81 +++++++++++++++++++++++++++++------------------
>  1 file changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 20cc51f..05fc2f0 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -472,17 +472,22 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
>  {
>         struct i2s_dai *i2s = to_info(dai);
>         struct i2s_dai *other = get_other_dai(i2s);
> -       u32 mod = readl(i2s->addr + I2SMOD);
>         const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
>         unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
>         unsigned int rsrc_mask = 1 << i2s_regs->rclksrc_off;
> +       u32 mod, mask, val = 0;
> +
> +       spin_lock(i2s->lock);
> +       mod = readl(i2s->addr + I2SMOD);
> +       spin_unlock(i2s->lock);
>

'mod' is now updated only at the bottom of this function. The above
readl can be omitted.

>         switch (clk_id) {
>         case SAMSUNG_I2S_OPCLK:
> -               mod &= ~MOD_OPCLK_MASK;
> -               mod |= dir;
> +               mask = MOD_OPCLK_MASK;
> +               val = dir;
>                 break;
>         case SAMSUNG_I2S_CDCLK:
> +               mask = 1 << i2s_regs->cdclkcon_off;

Use BIT() macro instead?

>                 /* Shouldn't matter in GATING(CLOCK_IN) mode */
>                 if (dir == SND_SOC_CLOCK_IN)
>                         rfs = 0;
> @@ -499,15 +504,15 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
>                 }
>
>                 if (dir == SND_SOC_CLOCK_IN)
> -                       mod |= 1 << i2s_regs->cdclkcon_off;
> -               else
> -                       mod &= ~(1 << i2s_regs->cdclkcon_off);
> +                       val = 1 << i2s_regs->cdclkcon_off;
>

Same as above.

>                 i2s->rfs = rfs;
>                 break;
>
>         case SAMSUNG_I2S_RCLKSRC_0: /* clock corrsponding to IISMOD[10] := 0 */
>         case SAMSUNG_I2S_RCLKSRC_1: /* clock corrsponding to IISMOD[10] := 1 */
> +               mask = 1 << i2s_regs->rclksrc_off;
> +

Same as above.

>                 if ((i2s->quirks & QUIRK_NO_MUXPSR)
>                                 || (clk_id == SAMSUNG_I2S_RCLKSRC_0))
>                         clk_id = 0;
> @@ -557,18 +562,19 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
>                         return 0;
>                 }
>
> -               if (clk_id == 0)
> -                       mod &= ~(1 << i2s_regs->rclksrc_off);
> -               else
> -                       mod |= 1 << i2s_regs->rclksrc_off;
> -
> +               if (clk_id == 1)
> +                       val = 1 << i2s_regs->rclksrc_off;

Same as above.

-- 
Tushar Behera
