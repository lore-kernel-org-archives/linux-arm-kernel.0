From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Dec 2013 12:34:06 +0000
Subject: [RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
References: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131202123406.GK12952@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 10:15:09AM +0000, Xiubo Li wrote:
> The FTM PWM device can be found on Vybrid VF610 Tower and
> Layerscape LS-1 SoCs.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> 
> I'm sending the RFC patch about the FTM IP block registers read and write
> endian fix for comments and more parcticed ideas.
> 
> In Vybird VF610 Tower, all the IP blocks expect LE data. In the LS-1, some of
> the IP blocks expect LE data, while others expect BE data. And the CPU always
> operates in LE mode in these two platforms.

Could you elaborate on "expect BE data" please? Is this all registers
within a given device, or a subset thereof? Are there data structrues
involved (i.e. buffers)?

> 
> So now I must take care of all these two cases. I'm not very sure if there is
> other better ways to resolve this problem. In this patch I have implemented
> two functions fsl_pwm_readl() and fsl_pwm_writel() to replace readl() and
> writel(). At the same time there should add one "endianess" property in the DT
> file.

If you're adding DT properties, binding updates are helpful to describe
their intended use.

[...]

> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc, void __iomem *reg)
> +{
> +       u32 val;
> +
> +       val = __raw_readl(reg);
> +
> +       if (fpc->endianess == FTM_BIG)
> +               return be32_to_cpu(val);
> +       else
> +               return le32_to_cpu(val);
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 val,
> +               void __iomem *reg)
> +{
> +       if (fpc->endianess == FTM_BIG)
> +               val = cpu_to_be32(val);
> +       else
> +               val = cpu_to_le32(val);
> +
> +       __raw_writel(val, reg);
> +}

Using the __raw variants also loses you the memory barriers. Does this
create any ordering issues in the rest of the driver?

[...]

> +static int fsl_pwm_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       const char *endianess;
> +       struct fsl_pwm_chip *fpc;
> +       struct resource *res;
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> +       if (!fpc)
> +               return -ENOMEM;
> +
> +       mutex_init(&fpc->lock);
> +
> +       fpc->chip.dev = &pdev->dev;
> +
> +       ret = fsl_pwm_parse_clk_ps(fpc);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (of_property_read_string(np, "endianess", &endianess))
> +               pr_warning("missing \"endianess\" property, "
> +                               "the FTM IP block is little "
> +                               "endian as default\n");
> +       else if (!strcmp("big", endianess))
> +               fpc->endianess = FTM_BIG;

Please don't do this.

One option is to have a new compatible string -- a big-endian device
can't be poked in the same way as its little-endian variants, so they're
not compatible. You can then associate some data with the compatible
strings to figure out which accessors to use.

If you really want this to be a separate property, make it a boolean
property (e.g. "fsl,big-endian", which you can read with
of_property_read_bool. There's no need for this to be a string.

I'd prefer the compatible string option.

Thanks,
Mark.
