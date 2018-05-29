From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 May 2018 15:16:13 -0300
Subject: [PATCH v3 4/5] clocksource: add driver for i.MX EPIT timer
In-Reply-To: <20180529170436.22711-5-peron.clem@gmail.com>
References: <20180529170436.22711-1-peron.clem@gmail.com>
 <20180529170436.22711-5-peron.clem@gmail.com>
Message-ID: <CAOMZO5AwF6TprHKgiSfky3QoN0=PGBY6-Apy2MCjoThp0daydA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 2:04 PM, Cl?ment P?ron <peron.clem@gmail.com> wrote:

> +static int __init epit_timer_init(struct device_node *np)
> +{
> +       struct epit_timer *epittm;
> +       struct clk *clk_ipg;
> +       int ret;
> +
> +       epittm = kzalloc(sizeof(*epittm), GFP_KERNEL);
> +       if (!epittm)
> +               return -ENOMEM;
> +
> +       epittm->base = of_iomap(np, 0);
> +       if (!epittm->base) {
> +               ret = -ENXIO;
> +               goto out_kfree;
> +       }
> +
> +       epittm->irq = irq_of_parse_and_map(np, 0);
> +       if (!epittm->irq) {
> +               ret = -EINVAL;
> +               goto out_iounmap;
> +       }
> +
> +       clk_ipg = of_clk_get_by_name(np, "ipg");
> +       if (IS_ERR(clk_ipg)) {
> +               pr_err("i.MX EPIT: unable to get clk_ipg\n");
> +               ret = PTR_ERR(clk_ipg);
> +               goto out_iounmap;
> +       }
> +
> +       ret = clk_prepare_enable(clk_ipg);
> +       if (ret) {
> +               pr_err("i.MX EPIT: unable to prepare+enable clk_ipg\n");
> +               goto out_clk_ipg_disable;

This should be: goto out_iounmap;
