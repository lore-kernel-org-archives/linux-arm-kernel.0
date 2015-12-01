From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Tue, 1 Dec 2015 09:20:06 +0100
Subject: [PATCH RFC] l2c: warn about misconfigured PL310 shared-override
In-Reply-To: <1445521419-10104-1-git-send-email-l.stach@pengutronix.de>
References: <1445521419-10104-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAH9NwWcU_4rnMKa3yF-kvJ6mShzY+LDBZfAAKhV-Mr+b3nBQwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-22 15:43 GMT+02:00 Lucas Stach <l.stach@pengutronix.de>:
> If the shared override enable bit in the PL310 aux ctrl register is
> not set the L2 cache controller will render the system non-compliant
> to the rules regarding mismatched memory aliases as specified in the
> ARMv7 ARM.
>
> As this may lead to subtle corruptions when reading from a bufferable
> alias, make sure to warn about this in the kernel log.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> I'm open to suggestions on how to improve the warning or where to put
> documentation for this so users are advised to update their board
> firmware, or work around this by using the "arm,shared-override" DT
> property on a secure state booted kernel, without spamming the logs
> too much.
> ---
>  arch/arm/mm/cache-l2x0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 493692d838c6..8c586894c58d 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -820,6 +820,11 @@ static int __init __l2c_init(const struct l2c_init_data *data,
>                 pr_warn("L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x\n",
>                         old_aux, aux);
>
> +       if (((cache_id & L2X0_CACHE_ID_PART_MASK) == L2X0_CACHE_ID_PART_L310) &&
> +           !(aux & L2C_AUX_CTRL_SHARED_OVERRIDE))
> +               pr_warn("L2C-310 shared attribute override enable not set, "
> +                       "system is non-compliant to ARM specified memory aliasing rules\n");
> +
>         /* Determine the number of ways */
>         switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
>         case L2X0_CACHE_ID_PART_L310:
> --
> 2.6.1
>

Maybe its time to send out the same patch without the RFC patch?

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
