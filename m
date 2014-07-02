From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 2 Jul 2014 11:27:21 -0300
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <20140702043508.GA16176@dragon>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
 <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
 <20140702043508.GA16176@dragon>
Message-ID: <CAOMZO5AYA-i8Rp2Oo+unwUXmH0uQ8D3rnXxBQUgqKrfXw-vN-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 1:35 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> What about the patch below?

It does allow audio to play, but it resulted in CCGR5 as 0xffffffff
(all clocks enabled), so we still need to adjust it.

> Shawn
>
> ----8<-------------
>
> From 0ed4b3edc661c63f86c914ea3c6deb3af3438151 Mon Sep 17 00:00:00 2001
> From: Shawn Guo <shawn.guo@freescale.com>
> Date: Wed, 2 Jul 2014 11:32:06 +0800
> Subject: [PATCH] ARM: imx: fix shared gate clock to have its own enable count
>
> Let's say clock A and B are two gate clocks that share the same register
> bit in hardware.  Therefore they should be registered as shared gate
> clocks with imx_clk_gate2_shared().
>
> In the current implementation, clk_enable(A) call will have share_count
> become 1.  If clk_disable(B) is called right after that, the register
> bit will be cleared to gate off the clocks.  This is unexpected.  The
> cause for that is there is no enable count tracking for clock A and B
> respectively.
>
> The patch fixes the issue by adding enable_count into clk_gate2, and
> tracks it prior to share_count in .enable and .disable.  Also,
> .is_enabled is fixed to report enable state instead of hardware state
> in case of shared gate clock.
>
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: <stable@vger.kernel.org>
> Fixes: f9f28cdf2167 ("ARM: imx: add shared gate clock support")

No need to Cc stable on this one as the this commit did not reach stable.

> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/clk-gate2.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
> index 4ba587da89d2..c5dca7cdbbb1 100644
> --- a/arch/arm/mach-imx/clk-gate2.c
> +++ b/arch/arm/mach-imx/clk-gate2.c
> @@ -33,6 +33,7 @@ struct clk_gate2 {
>         u8              bit_idx;
>         u8              flags;
>         spinlock_t      *lock;
> +       unsigned int    enable_count;
>         unsigned int    *share_count;
>  };
>
> @@ -46,6 +47,9 @@ static int clk_gate2_enable(struct clk_hw *hw)
>
>         spin_lock_irqsave(gate->lock, flags);
>
> +       if (gate->enable_count++ > 0)
> +               goto out;
> +
>         if (gate->share_count && (*gate->share_count)++ > 0)
>                 goto out;
>
> @@ -67,6 +71,9 @@ static void clk_gate2_disable(struct clk_hw *hw)
>
>         spin_lock_irqsave(gate->lock, flags);
>
> +       if (--gate->enable_count > 0)
> +               goto out;

All these pre-decrement look buggy because enable_count and
share_count are 'unsigned int'.

If share_count is 0 and then you decrement it, it will still be
greater than zero.
--(*gate->share_count) > 0 and --gate->enable_count > 0 are always true.

I have tried to make share_count and enable_count as 'int'. Then it
resulted CGR5 as
0FFFCFFF, which still leaves ssi1 and ssi3 enabled (I have locally
made ssi a shared clock now)

I will post a v2 without touching arch/arm/mach-imx/clk-gate2.c to
make it easier for us to debug it.

Thanks,

Fabio Estevam
