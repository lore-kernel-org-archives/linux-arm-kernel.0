From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Tue, 19 Aug 2014 22:52:59 +0300
Subject: [PATCH v3 03/15] clk: tegra: Add closed loop support for the DFLL
In-Reply-To: <53F2D454.2020000@nvidia.com>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
 <1408419205-10048-4-git-send-email-tuomas.tynkkynen@iki.fi>
 <53F2D454.2020000@nvidia.com>
Message-ID: <53F3AB1B.70703@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/14 07:36, Vince Hsu wrote:
> Hi,
> 
> On 08/19/2014 11:33 AM, Tuomas Tynkkynen wrote:
[...]
>> +    dfll_writel(td, val, DFLL_OUTPUT_CFG);
>> +    dfll_wmb(td);
> Sorry that I forgot to mention this in v2's comment. Could you squash the change below in this patch? And actually it's pretty easy to misuse the dfll read/write/wmb functions. We might want to have some generic functions for these, and let the generic functions handle the offset to different register blocks.
> 

Indeed, having single readl/writel and handling the different register areas there
sounds much better, I'll implement that.

[...]
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 9b3eded6b880..71e4b256ea0d 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -645,7 +645,7 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>         val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
>                 (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
>                 (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
> -       dfll_writel(td, val, DFLL_OUTPUT_CFG);
> +       dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
> -        dfll_wmb(td);
> +        dfll_i2c_wmb(td);
> 
>         dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
> @@ -1146,7 +1146,8 @@ static int attr_registers_show(struct seq_file *s, void *data)
>         seq_puts(s, "CONTROL REGISTERS:\n");
>         for (offs = 0; offs <= DFLL_MONITOR_DATA; offs += 4)
>                 seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> -                          dfll_readl(td, offs));
> +                               offs == DFLL_OUTPUT_CFG ? dfll_i2c_readl(td, offs) :
> +                                       dfll_readl(td, offs));
> 
>         seq_puts(s, "\nI2C and INTR REGISTERS:\n");
>         for (offs = DFLL_I2C_CFG; offs <= DFLL_I2C_STS; offs += 4)
> 
> 
> 
> Thanks,
> Vince

-- 
nvpublic
