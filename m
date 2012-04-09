From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 9 Apr 2012 14:52:15 -0700
Subject: common clk: fix clk_register_fixed_rate() under memory pressure
In-Reply-To: <20120405084808.GA21060@glitch>
References: <20120405084808.GA21060@glitch>
Message-ID: <CAJOA=zNt7V_LNLAyXxJU2oS3vTEhvZ1JUWAx+hqQM1t=Whjr6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 1:48 AM, Domenico Andreoli <cavokz@gmail.com> wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
>
> Under memory pressure clk_register_fixed_rate() fails to manage
> allocation errors and prepares land for a later WARN_ON at best.
>
> This fix leaves parent_names correctly initialized or NULL, intermediate
> half initialized states are cleaned up and not propagated to the clock
> framework.
>
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

Thanks for the patch Domenico.  I did a big cleanup of the
registration code for all of the basic clock types and a fix for this
has already been rolled in to that branch, so I won't be taking this
patch.  I'll Cc you on the fixes when I send them to the list
(probably tomorrow).

Regards,
Mike

> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Arnd Bergman <arnd.bergmann@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
>
> ---
> ?drivers/clk/clk-fixed-rate.c | ? ?7 +++++--
> ?1 file changed, 5 insertions(+), 2 deletions(-)
>
> Index: b/drivers/clk/clk-fixed-rate.c
> ===================================================================
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -67,8 +67,11 @@ struct clk *clk_register_fixed_rate(stru
>
> ? ? ? ? ? ? ? ?parent_names[0] = kmalloc(len, GFP_KERNEL);
>
> - ? ? ? ? ? ? ? if (!parent_names[0])
> + ? ? ? ? ? ? ? if (!parent_names[0]) {
> + ? ? ? ? ? ? ? ? ? ? ? kfree(parent_names);
> + ? ? ? ? ? ? ? ? ? ? ? parent_names = NULL;
> ? ? ? ? ? ? ? ? ? ? ? ?goto out;
> + ? ? ? ? ? ? ? }
>
> ? ? ? ? ? ? ? ?strncpy(parent_names[0], parent_name, len);
> ? ? ? ?}
> @@ -77,6 +80,6 @@ out:
> ? ? ? ?return clk_register(dev, name,
> ? ? ? ? ? ? ? ? ? ? ? ?&clk_fixed_rate_ops, &fixed->hw,
> ? ? ? ? ? ? ? ? ? ? ? ?parent_names,
> - ? ? ? ? ? ? ? ? ? ? ? (parent_name ? 1 : 0),
> + ? ? ? ? ? ? ? ? ? ? ? (parent_names ? 1 : 0),
> ? ? ? ? ? ? ? ? ? ? ? ?flags);
> ?}
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
