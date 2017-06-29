From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 29 Jun 2017 10:47:53 +0800
Subject: [PATCH v7] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170628105224.6619-1-net147@gmail.com>
References: <20170628105224.6619-1-net147@gmail.com>
Message-ID: <CAGb2v651r+ksbZGLATOdrh5RyuCeR-vp06D246A+QXferLH=4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 28, 2017 at 6:52 PM, Jonathan Liu <net147@gmail.com> wrote:
> The documentation for drm_do_get_edid in drivers/gpu/drm/drm_edid.c states:
> "As in the general case the DDC bus is accessible by the kernel at the I2C
> level, drivers must make all reasonable efforts to expose it as an I2C
> adapter and use drm_get_edid() instead of abusing this function."
>
> Exposing the DDC bus as an I2C adapter is more beneficial as it can be used
> for purposes other than reading the EDID such as modifying the EDID or
> using the HDMI DDC pins as an I2C bus through the I2C dev interface from
> userspace (e.g. i2c-tools).
>
> Implement this for A10s.
>
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
> Changes for v7:
>  - Fix mixed declarations and code compiler warning for level variable
>
> Changes for v6:
>  - Use fixed byte time of 100 us instead of dynamically calculating from DDC
>    clock that is set to a fixed 100 MHz rate anyway
>  - Change is_fifo_flag_unset to not read the status register as well to be
>    more consistent with is_err_status
>
> Changes for v5:
>  - Use devm_kzalloc instead of devm_kmemdup and remove const struct i2c_adapter
>  - Rework to use readl_poll_timeout for checking FIFO status
>
> Changes for v4:
>  - Carry over copyright from initial I2C code into sun4i_hdmi_i2c.c
>  - Clean up indentation in sun4i_hdmi.h
>  - Rename SUN4I_HDMI_DDC_MAX_TRANSFER_SIZE to SUN4I_HDMI_DDC_BYTE_COUNT_MAX
>    and group it under the SUN4I_HDMI_DDC_BYTE_COUNT_REG define, changing the
>    value to use the GENMASK macro to make it clear that it is derived from
>    the width of the field in the register
>  - Fix SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_UNDERFLOW typo which should be
>    SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_OVERFLOW
>  - Remove redundant rewriting of SUN4I_HDMI_DDC_INT_STATUS_REG register
>  - Change struct i2c_adapter to be const by using devm_kmemdup on creation
>  - Return -ETIMEDOUT instead of -EIO if there is timeout while transferring an
>    I2C message
>  - Instead of waiting for 1-2 bytes to transfer, wait for the time it would
>    take for remaining bytes to transfer (limited by FIFO size)
>  - Add additional comments
>
> Changes for v3:
>  - Explain why drm_do_get_edid should be used and why it's better to expose it
>    as an I2C adapter in commit message
>  - Reorder bit defines in descending order for consistency
>  - Keep old unused macros instead of removing them
>  - The v2 algorithm split large transfers into 16 byte transfers but this may
>    cause a large single write to be treated as multiple writes causing data
>    corruption. The algorithm has been reworked to not split larger transfers
>    and make more use of the FIFO to avoid this.
>  - Moved the creation of the DDC clock from sun4i_hdmi_enc.c to
>    sun4i_hdmi_i2c.c
>  - Reformatted code
>  - Instead of masking bits that we don't want to check for errors, explicitly
>    check the error bits
>  - Clear error bits at start of transfer in case of error from previous transfer
>  - Poll for completion of FIFO clear after setting FIFO clear bit
>
> Changes for v2:
>  - Rebased against Maxime's sunxi-drm/for-next branch
>  - Fix up error paths in sun4i_hdmi_bind so that the I2C adapter is deleted if
>    any of the calls after the I2C adapter is created fails
>  - Remove unnecessary includes in sun4i_hdmi_i2c.c
>
>  drivers/gpu/drm/sun4i/Makefile         |   1 +
>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  23 ++++
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 101 ++------------
>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c | 234 +++++++++++++++++++++++++++++++++
>  4 files changed, 269 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
>

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> new file mode 100644
> index 000000000000..ce954ee25ae4
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> @@ -0,0 +1,234 @@

[...]

> +static int fifo_transfer(struct sun4i_hdmi *hdmi, u8 *buf, int len, bool read)
> +{
> +       /*
> +        * 1 byte takes 9 clock cycles (8 bits + 1 ACK) = 90 us for 100 MHz
> +        * clock. As clock rate is fixed, just round it up to 100 us.

This looks fishy. I2C busses are never that fast. Maybe kHz?

ChenYu

> +        */
> +       const unsigned long byte_time_ns = 100;
> +       u32 int_status;
> +       u32 fifo_status;
> +       /* Read needs empty flag unset, write needs full flag unset */
> +       u32 flag = read ? SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY :
> +                         SUN4I_HDMI_DDC_FIFO_STATUS_FULL;
> +       int level;
> +       int ret;
> +
> +       /* Wait until error or FIFO ready */
> +       ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG,
> +                                int_status,
> +                                is_err_status(int_status) ||
> +                                is_fifo_flag_unset(fifo_status =
> +                                                   read_fifo_status(hdmi),
> +                                                   flag),
> +                                min(len, SUN4I_HDMI_DDC_FIFO_SIZE) *
> +                                byte_time_ns, 100000);
> +
> +       if (is_err_status(int_status))
> +               return -EIO;
> +       if (ret)
> +               return -ETIMEDOUT;
> +
> +       /* Read FIFO level */
> +       level = (int)(fifo_status & SUN4I_HDMI_DDC_FIFO_STATUS_LEVEL_MASK);
> +
> +       /* Limit transfer length using FIFO level to avoid underflow/overflow */
> +       len = min(len, read ? level : (SUN4I_HDMI_DDC_FIFO_SIZE - level));
> +
> +       if (read)
> +               readsb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG, buf, len);
> +       else
> +               writesb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG, buf, len);
> +
> +       return len;
> +}
> +
> +static int xfer_msg(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
> +{
> +       int i, len;
> +       u32 reg;
> +
> +       /* Clear errors */
> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
> +       reg &= ~SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK;
> +       writel(reg, hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
> +
> +       /* Set FIFO direction */
> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
> +       reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
> +       reg |= (msg->flags & I2C_M_RD) ?
> +              SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ :
> +              SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE;
> +       writel(reg, hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
> +
> +       /* Set I2C address */
> +       writel(SUN4I_HDMI_DDC_ADDR_SLAVE(msg->addr),
> +              hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
> +
> +       /* Clear FIFO */
> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
> +       writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
> +              hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
> +       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG,
> +                              reg,
> +                              !(reg & SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR),
> +                              100, 100000))
> +               return -EIO;
> +
> +       /* Set transfer length */
> +       writel(msg->len, hdmi->base + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
> +
> +       /* Set command */
> +       writel(msg->flags & I2C_M_RD ?
> +              SUN4I_HDMI_DDC_CMD_IMPLICIT_READ :
> +              SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE,
> +              hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
> +
> +       /* Start command */
> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
> +       writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
> +              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
> +
> +       /* Transfer bytes */
> +       for (i = 0; i < msg->len; i += len) {
> +               len = fifo_transfer(hdmi, msg->buf + i, msg->len - i,
> +                                   msg->flags & I2C_M_RD);
> +               if (len <= 0)
> +                       return len;
> +       }
> +
> +       /* Wait for command to finish */
> +       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG,
> +                              reg,
> +                              !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
> +                              100, 100000))
> +               return -EIO;
> +
> +       /* Check for errors */
> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG);
> +       if ((reg & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK) ||
> +           !(reg & SUN4I_HDMI_DDC_INT_STATUS_TRANSFER_COMPLETE)) {
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sun4i_hdmi_i2c_xfer(struct i2c_adapter *adap,
> +                              struct i2c_msg *msgs, int num)
> +{
> +       struct sun4i_hdmi *hdmi = i2c_get_adapdata(adap);
> +       u32 reg;
> +       int err, i, ret = num;
> +
> +       for (i = 0; i < num; i++) {
> +               if (!msgs[i].len)
> +                       return -EINVAL;
> +               if (msgs[i].len > SUN4I_HDMI_DDC_BYTE_COUNT_MAX)
> +                       return -EINVAL;
> +       }
> +
> +       /* Reset I2C controller */
> +       writel(SUN4I_HDMI_DDC_CTRL_ENABLE | SUN4I_HDMI_DDC_CTRL_RESET,
> +              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
> +       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
> +                              !(reg & SUN4I_HDMI_DDC_CTRL_RESET),
> +                              100, 2000))
> +               return -EIO;
> +
> +       writel(SUN4I_HDMI_DDC_LINE_CTRL_SDA_ENABLE |
> +              SUN4I_HDMI_DDC_LINE_CTRL_SCL_ENABLE,
> +              hdmi->base + SUN4I_HDMI_DDC_LINE_CTRL_REG);
> +
> +       clk_prepare_enable(hdmi->ddc_clk);
> +       clk_set_rate(hdmi->ddc_clk, 100000);

Indeed the clock rate is 100 kHz.

ChenYu

> +
> +       for (i = 0; i < num; i++) {
> +               err = xfer_msg(hdmi, &msgs[i]);
> +               if (err) {
> +                       ret = err;
> +                       break;
> +               }
> +       }
> +
> +       clk_disable_unprepare(hdmi->ddc_clk);
> +       return ret;
> +}
> +
> +static u32 sun4i_hdmi_i2c_func(struct i2c_adapter *adap)
> +{
> +       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm sun4i_hdmi_i2c_algorithm = {
> +       .master_xfer    = sun4i_hdmi_i2c_xfer,
> +       .functionality  = sun4i_hdmi_i2c_func,
> +};
> +
> +int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
> +{
> +       struct i2c_adapter *adap;
> +       int ret = 0;
> +
> +       ret = sun4i_ddc_create(hdmi, hdmi->tmds_clk);
> +       if (ret)
> +               return ret;
> +
> +       adap = devm_kzalloc(dev, sizeof(*adap), GFP_KERNEL);
> +       if (!adap)
> +               return -ENOMEM;
> +
> +       adap->owner = THIS_MODULE;
> +       adap->class = I2C_CLASS_DDC;
> +       adap->algo = &sun4i_hdmi_i2c_algorithm;
> +       strlcpy(adap->name, "sun4i_hdmi_i2c adapter", sizeof(adap->name));
> +       i2c_set_adapdata(adap, hdmi);
> +
> +       ret = i2c_add_adapter(adap);
> +       if (ret)
> +               return ret;
> +
> +       hdmi->i2c = adap;
> +
> +       return ret;
> +}
> --
> 2.13.1
>
