From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 12 Jul 2016 14:31:05 -0700
Subject: [PATCH 2/2] fpga-manager: Add Socfpga Arria10 support
In-Reply-To: <20160712190709.5964-3-atull@opensource.altera.com>
References: <20160712190709.5964-1-atull@opensource.altera.com>
 <20160712190709.5964-3-atull@opensource.altera.com>
Message-ID: <CAAtXAHfSBzLisqBgF4Vry0vrcL3+DB4b1ctMOrTdOq5ue4D7JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

couple of nits inline below.

On Tue, Jul 12, 2016 at 12:07 PM, Alan Tull <atull@opensource.altera.com> wrote:

> +static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr, u32 flags)
> +{
> +       struct a10_fpga_priv *priv = mgr->priv;
> +       u32 reg;
> +       int ret;
> +
> +       /* Wait for pr_done */
> +       ret = socfpga_a10_fpga_wait_for_pr_done(priv);
> +
> +       /* Clear pr_request */
> +       regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_01_OFST,
> +                          A10_FPGAMGR_IMGCFG_CTL_01_S2F_PR_REQUEST, 0);
> +
> +       /* Send some clocks to clear out any errors */
> +       socfpga_a10_fpga_generate_dclks(priv, 256);
> +
> +       /* Disable s2f dclk and data */
> +       regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_02_OFST,
> +                          A10_FPGAMGR_IMGCFG_CTL_02_EN_CFG_CTRL, 0);

Maybe replace 0 with named constant.
> +
> +       /* Deassert chip select */
> +       regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_01_OFST,
> +                          A10_FPGAMGR_IMGCFG_CTL_01_S2F_NCE,
> +                          A10_FPGAMGR_IMGCFG_CTL_01_S2F_NCE);
> +
> +       /* Disable data, dclk, nce, and pr_request override to CSS */
> +       regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_01_OFST,
> +                          A10_FPGAMGR_IMGCFG_CTL_01_S2F_NENABLE_CONFIG,
> +                          A10_FPGAMGR_IMGCFG_CTL_01_S2F_NENABLE_CONFIG);
> +
> +       /* Return any errors regarding pr_done or pr_error */
> +       if (ret)
> +               return ret;
> +
> +       /* Final check */
> +       reg = socfpga_a10_fpga_read_stat(priv);
> +
> +       if (((reg & A10_FPGAMGR_IMGCFG_STAT_F2S_USERMODE) == 0) ||
> +           ((reg & A10_FPGAMGR_IMGCFG_STAT_F2S_CONDONE_PIN) == 0) ||
> +           ((reg & A10_FPGAMGR_IMGCFG_STAT_F2S_NSTATUS_PIN) == 0)) {
> +               dev_dbg(&mgr->dev,
> +                       "Timeout in final check. Status=%08xf\n", reg);
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static enum fpga_mgr_states socfpga_a10_fpga_state(struct fpga_manager *mgr)
> +{
> +       struct a10_fpga_priv *priv = mgr->priv;
> +       u32 reg = socfpga_a10_fpga_read_stat(priv);
> +
> +       if (reg & A10_FPGAMGR_IMGCFG_STAT_F2S_USERMODE)
> +               return FPGA_MGR_STATE_OPERATING;
> +
> +       if (reg & A10_FPGAMGR_IMGCFG_STAT_F2S_PR_READY)
> +               return FPGA_MGR_STATE_WRITE;
> +
> +       if (reg & A10_FPGAMGR_IMGCFG_STAT_F2S_CRC_ERROR)
> +               return FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
> +
> +       if ((reg & A10_FPGAMGR_IMGCFG_STAT_F2S_NSTATUS_PIN) == 0)
> +               return FPGA_MGR_STATE_RESET;
> +
> +       return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static const struct fpga_manager_ops socfpga_a10_fpga_mgr_ops = {
> +       .state = socfpga_a10_fpga_state,
> +       .write_init = socfpga_a10_fpga_write_init,
> +       .write = socfpga_a10_fpga_write,
> +       .write_complete = socfpga_a10_fpga_write_complete,
> +};
> +
> +static int socfpga_a10_fpga_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct a10_fpga_priv *priv;
> +       void __iomem *reg_base;
> +       struct resource *res;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       /* First mmio base is for register access */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       reg_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       /* Second mmio base is for writing FPGA image data */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       priv->fpga_data_addr = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(priv->fpga_data_addr))
> +               return PTR_ERR(priv->fpga_data_addr);
> +
> +       /* regmap for register access */
> +       priv->regmap = devm_regmap_init_mmio(dev, reg_base,
> +                                            &socfpga_a10_fpga_regmap_config);
> +       if (IS_ERR(priv->regmap))
> +               return -ENODEV;
> +
> +       priv->clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(dev, "no clock specified\n");
> +               return PTR_ERR(priv->clk);
> +       }
> +
> +       ret = clk_prepare_enable(priv->clk);
> +       if (ret) {
> +               dev_err(dev, "could not enable clock\n");
> +               clk_put(priv->clk);

Seen that you used devm_clk_get() is this one necessary?

> +static int socfpga_a10_fpga_remove(struct platform_device *pdev)
> +{
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +       struct a10_fpga_priv *priv = mgr->priv;
> +
> +       fpga_mgr_unregister(&pdev->dev);
> +       clk_disable_unprepare(priv->clk);
> +       clk_put(priv->clk);

Same here, if needed at all shouldn't it be devm_clk_put() ?

Cheers,

Moritz
