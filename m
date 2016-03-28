From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Mar 2016 16:33:11 -0300
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <56F9855B.9060009@timesys.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
 <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
 <CAOMZO5DJ=2xo3ciDDoC1KVwHpxagEjNHq5hEkS7StBzaXrk-pQ@mail.gmail.com>
 <56F9855B.9060009@timesys.com>
Message-ID: <CAOMZO5CsCfprq_br-omNyeE_T7XC7Do+Z0qOT68msZSu9QedqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akshay,

On Mon, Mar 28, 2016 at 4:26 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:

> The 2 discrepancies I see with this patch with regards to the sequence from
> NXP 3.10 kernel are:
>
> 1. NXP 3.10 kernel switches clock source as follows:
> current_parent -> 7 -> 4 -> new_parent

Yes, we need to follow this requirement.

>
> Ref:
> +       /*
> +        * Set the ldb_di0_clk and ldb_di1_clk to 111b.
> +        */
> +       reg = readl_relaxed(ccm_base + 0x2c);
> +       reg |= ((7 << 9) | (7 << 12));
> +       writel_relaxed(reg, ccm_base + 0x2c);
> +
> +       /*
> +        * Set the ldb_di0_clk and ldb_di1_clk to 100b.
> +        */
> +       reg = readl_relaxed(ccm_base + 0x2c);
> +       reg &= ~((7 << 9) | (7 << 12));
> +       reg |= ((4 << 9) | (4 << 12));
> +       writel_relaxed(reg, ccm_base + 0x2c);
> +
> +       /*
> +        * Perform the LDB parent clock switch.
> +        */
> +       clk_set_parent(clk[ldb_di0_sel], clk[new_parent]);
> +       clk_set_parent(clk[ldb_di1_sel], clk[new_parent]);
>
>
> If I am reading this patch correctly, then this patch does:
> current_parent -> (current_parent | 4) -> (new_parent | 4) -> new_parent
>
> Ref:
> +       /* First switch to the bottom mux */
> +       sel[i][1] = sel[i][0] | 4;
> +
> +       /* Then configure the top mux before switching back to it */
> +       sel[i][2] = sel[i][3] | 4;
> +
> +       pr_debug("ccm: switching ldb_di%d_sel: %d->%d->%d->%d\n", i,
> +                        sel[i][0], sel[i][1], sel[i][2], sel[i][3]);
>
>
> 2. The NXP 3.10 kernel does not have any restriction on what the new parent
> is.

That's correct. There is no restriction on what the new parent will be.
