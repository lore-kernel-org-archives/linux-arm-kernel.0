From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:15:25 -0800
Subject: [PATCH v2 12/21] ARM: tegra: clock: Add shared bus clock type
In-Reply-To: <1298154371-5641-1-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTinWQRmKhorYHQ2rHCArHN89go-2mYVAe5UUZVOV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> Some clocks may have multiple downstream users that need to request a
> higher clock rate. ?Shared bus clocks provide a unique shared_bus_user
> clock to each user. ?The frequency of the bus is set to the highest
> enabled shared_bus_user clock, with a minimum value set by the
> shared bus. ?Drivers can use clk_enable and clk_disable to enable
> or disable their requirement, and clk_set_rate to set the minimum rate.
>
> Signed-off-by: Colin Cross <ccross@android.com>

[...]
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index a1c86d8..dd53af3 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
[...]

> + ? ? ? c->u.shared_bus_user.rate = c->parent->max_rate;
> + ? ? ? c->state = OFF;
> +#ifdef CONFIG_DEBUG_FS
> + ? ? ? c->set = 1;
> +#endif
> +
> + ? ? ? spin_lock_irqsave(&c->parent->spinlock, flags);


A later patch in the series removes the ifdef. Might as well remove it
here. Also, should be c->set = true, which that patch also does. :)

With that fixed:

Acked-by: Olof Johansson <olof@lixom.net>
