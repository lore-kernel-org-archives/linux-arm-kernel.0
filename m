From: dianders@chromium.org (Doug Anderson)
Date: Wed, 27 Apr 2016 13:56:21 -0700
Subject: [PATCH v6] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1461074137-23899-1-git-send-email-david.wu@rock-chips.com>
References: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <1461074137-23899-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=U7Vsnh8RZjZ=an0Sfb+soS=+v1icoH=kL1huCR_9TTgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 19, 2016 at 6:55 AM, David Wu <david.wu@rock-chips.com> wrote:
> From: David Wu <wdc@rock-chips.com>
>
> - new method to caculate i2c timings for rk3399:
>   There was an timing issue about "repeated start" time at the I2C
>   controller of version0, controller appears to drop SDA at .875x (7/8)
>   programmed clk high. On version 1 of the controller, the rule(.875x)
>   isn't enough to meet tSU;STA
>   requirements on 100k's Standard-mode. To resolve this issue,
>   sda_update_config, start_setup_config and stop_setup_config for I2C
>   timing information are added, new rules are designed to calculate
>   the timing information at new v1.
> - pclk and function clk are separated at rk3399.
> - support i2c highspeed mode: 1.7MHz for rk3399

Not sure if it's worth it at this point, but it would have helped me
if the high speed support was separated into a separate CL.  Then I
could have focused on basic support first and later tried to
understand all the high speed stuff.


> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> Changes in v6:
> - add master code send for HS mode
> - use assigned-clocks mechanism for clock rate set form DT (Heiko)
>
> Changes in v5:
> - use compatible to seperate from different version
> - can caculate highspeed clk rate
>
> Changes in v4:
> - pclk and sclk are treated individually
> - use switch-case to seperate from different version (Andy)
> - fix dead loop form Julia's notice
>
> Change in v3:
> - Too many arguments for ops func, use struct for them (Andy)
>
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  36 +-
>  drivers/i2c/busses/i2c-rk3x.c                      | 510 +++++++++++++++++++--
>  2 files changed, 498 insertions(+), 48 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> index f0d71bc..7ebf599 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt

I'd suggest putting the devicetree bindings in a separate patch and CC
the device tree mailing list.  Presumably you can get an Ack for the
bindings.  Once you have an Ack on the bindings, presumably you could
start posting and landing device trees that use the bindings.


> @@ -6,10 +6,16 @@ RK3xxx SoCs.
>  Required properties :
>
>   - reg : Offset and length of the register set for the device
> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c" or
> -               "rockchip,rk3288-i2c".
> + - compatible: should be one of the followings
> +   - "rockchip,rk3066-i2c": for rk3066
> +   - "rockchip,rk3188-i2c": for rk3188
> +   - "rockchip,rk3288-i2c": for rk3288
> +   - "rockchip,rk3399-i2c": for rk3399

I don't think your change applies cleanly to Wolfram's for-next
branch.  Please rebase.  See:

https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

Specifically rk3228 landed there and your patch doesn't account for it.


>   - interrupts : interrupt number
> - - clocks : parent clock
> + - clocks:
> +   - clk(function): APB clock and function clock is the same clock for rk3066,
> +                   rk3188 and rk3288. but separated at rk3399.
> +   - pclk(APB): It is just required for rk3399.

>From the binding it's unclear the the first clock was not specified by
name (it just needed to be the first clock) and that the second clock
needed to be specified by name.

Personally I'd rather see names be part of the binding for newer
hardware, so I'd do something like this:

 - clocks: See ../clock/clock-bindings.txt
   - For older hardware (rk3066, rk3188, rk3228, rk3288):
     - There is one clock that's used both to derive the functional clock
       for the device and as the bus clock.  REQUIRED.
   - For newer hardware (rk3399): specify by name
     - "i2c": REQUIRED. This is used to derive the functional clock.
     - "pclk": REQUIRED. This is the bus clock.

If you thought that a name other than "i2c" made more sense for the
functional clock you could do that.


>  Required on RK3066, RK3188 :
>
> @@ -32,6 +38,10 @@ Optional properties :
>   - i2c-sda-falling-time-ns : Number of nanoseconds the SDA signal takes to fall
>         (t(f) in the I2C specification). If not specified we'll use the SCL
>         value since they are the same in nearly all cases.
> + - assigned-clocks : Function clock of i2c.
> + - assigned-clock-rates : Frequency rate of function clock used(in Hz). If it is
> +       in high speed mode, more than 100MHz assigned is more accurate for i2c SCL
> +       frequency.
>
>  Example:
>
> @@ -39,6 +49,7 @@ aliases {
>         i2c0 = &i2c0;
>  }
>
> +rk3066, rk3188 and rk3288:

This example is not correct for rk3288, which shouldn't have a GRF
specified.  No need to have an example for every SoC, so I'd just say
that this is an example for rk3188 only.


>  i2c0: i2c at 2002d000 {
>         compatible = "rockchip,rk3188-i2c";
>         reg = <0x2002d000 0x1000>;
> @@ -54,3 +65,22 @@ i2c0: i2c at 2002d000 {
>         i2c-scl-rising-time-ns = <800>;
>         i2c-scl-falling-time-ns = <100>;
>  };
> +
> +rk3399:
> +i2c0: i2c at 2002d000 {
> +       compatible = "rockchip,rk3399-i2c";
> +       reg = <0x2002d000 0x1000>;
> +       interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       clock-names = "i2c", "pclk";
> +       clocks = <&cru SCLK_I2C0_PMU>, <&cru PCLK_I2C0_PMU>;
> +
> +       assigned-clocks = <&cru SCLK_I2C0_PMU>;
> +       assigned-clock-rates = <200000000>;
> +
> +       i2c-scl-rising-time-ns = <50>;
> +       i2c-scl-falling-time-ns = <20>;
> +       clock-frequency = <1700000>;
> +};
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index c4b0d89..73b16ac 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -58,6 +58,10 @@ enum {
>  #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last received byte */
>  #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
>
> +#define REG_CON_SDA_CNT(cnt)  ((cnt) << 8)
> +#define REG_CON_STA_CNT(cnt)  ((cnt) << 12)
> +#define REG_CON_STO_CNT(cnt)  ((cnt) << 14)
> +
>  /* REG_MRXADDR bits */
>  #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]ADDR valid */
>
> @@ -75,21 +79,79 @@ enum {
>  #define WAIT_TIMEOUT      1000 /* ms */
>  #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
>
> +#define I2C_MASTERCODE 0x08 /* Mastercodes are 0000_1xxxb */

I don't know nothin' about I2C, but some searching finds this
<http://www.i2c-bus.org/addressing/high-speed/>:

* The master codes are selectable by the designer and allow up to
eight high speed masters to be connected in one system

* master code ?00001000? should be reserved for test and diagnostic purposes

Presumably you should pick something else (like 0x09) and add a note
that if we need to support multi-master we should allow per-board
configuration (device tree?) for this.


> +#define I2C_FS_TX_CLOCK        400000

nit: include a unit (HZ), so: I2C_FS_TX_CLOCK_HZ

> +
>  enum rk3x_i2c_state {
>         STATE_IDLE,
> +       STATE_MC,
>         STATE_START,
>         STATE_READ,
>         STATE_WRITE,
>         STATE_STOP
>  };
>
> +enum rk3x_i2c_bus_speed {
> +       I2C_FS_SPD,
> +       I2C_HS_SPD
> +};
> +
> +struct rk3x_i2c;

Why do you need this forward definition?  Seems like it's not
necessary.  Remove?

> +
> +/**
> + * struct rk3x_i2c_calced_timings:
> + * @div_low: Divider output for low
> + * @div_high: Divider output for high
> + * @sda_update_cfg: Used to config sda change state when scl is low,
> + * used to adjust setup/hold time
> + * @stp_sta_cfg: Start setup config for setup start time and hold start time
> + * @stp_sto_cfg: Stop setup config for setup stop time
> + */
> +struct rk3x_i2c_calced_timings {
> +       unsigned long div_low;
> +       unsigned long div_high;
> +       unsigned int sda_update_cfg;
> +       unsigned int stp_sta_cfg;
> +       unsigned int stp_sto_cfg;
> +};

Can you add some sort of comment indicating that sda_update_cfg,
stp_sta_cfg, and stp_sto_cfg should all be 0 for old hardware (anyone
using rk3x_i2c_v0_calc_timings)?

> +
>  /**
>   * @grf_offset: offset inside the grf regmap for setting the i2c type
> + * @calc_timings: Callback function for i2c timing information calculated
>   */
>  struct rk3x_i2c_soc_data {
>         int grf_offset;
> +       int (*calc_timings)(unsigned long, struct i2c_timings *,
> +                           struct rk3x_i2c_calced_timings *);
>  };
>
> +/**
> + * struct rk3x_i2c - private data of the controller
> + * @adap: corresponding I2C adapter
> + * @dev: device for this controller
> + * @soc_data: related soc data struct
> + * @regs: virtual memory area
> + * @pclk: APB clock for rk3399
> + * @clk: function clk for rk3399 or function & APB clks for others
> + * @clk_rate_nb: function clk rate change notify
> + * @t: I2C known timing information
> + * @t_fs: I2C F/S mode timing information need to be calculated
> + * @t_hs: I2C HS mode timing information need to be calculated
> + * @speed_mode: flag of F/S or HS mode
> + * @fs_clock: SCL clock frequency of F/S mode
> + * @hs_clock: SCL clock frequency of HS mode
> + * @lock: spinlock for the i2c bus
> + * @wait: the waitqueue to wait for i2c transfer
> + * @busy: the condition for the event to wait for
> + * @msg: current i2c message
> + * @addr: addr of i2c slave device
> + * @mode: mode of i2c transfer
> + * @is_last_msg: flag determines whether it is the last msg in this transfer
> + * @state: state of i2c transfer
> + * @processed: byte length which has been send or received
> + * @error: error code for i2c transfer
> + */
> +
>  struct rk3x_i2c {
>         struct i2c_adapter adap;
>         struct device *dev;
> @@ -97,11 +159,19 @@ struct rk3x_i2c {
>
>         /* Hardware resources */
>         void __iomem *regs;
> +       struct clk *pclk;
>         struct clk *clk;
>         struct notifier_block clk_rate_nb;
>
>         /* Settings */
>         struct i2c_timings t;
> +       struct rk3x_i2c_calced_timings t_fs;
> +       struct rk3x_i2c_calced_timings t_hs;
> +
> +       /* Controller operating frequency */
> +       enum rk3x_i2c_bus_speed speed_mode;
> +       unsigned int fs_clock;
> +       unsigned int hs_clock;

nit: include a unit, so fs_clock_hz and hs_clock_hz.  This also helps
make it more obvious that these are not pointers to a 'struct clk'.


>         /* Synchronization & notification */
>         spinlock_t lock;
> @@ -116,7 +186,7 @@ struct rk3x_i2c {
>
>         /* I2C state machine */
>         enum rk3x_i2c_state state;
> -       unsigned int processed; /* sent/received bytes */
> +       unsigned int processed;
>         int error;
>  };
>
> @@ -131,6 +201,20 @@ static inline u32 i2c_readl(struct rk3x_i2c *i2c, unsigned int offset)
>         return readl(i2c->regs + offset);
>  }
>
> +static inline u32 rk3x_i2c_get_fs_count(struct rk3x_i2c *i2c)
> +{
> +       return REG_CON_SDA_CNT(i2c->t_fs.sda_update_cfg) |
> +              REG_CON_STA_CNT(i2c->t_fs.stp_sta_cfg) |
> +              REG_CON_STO_CNT(i2c->t_fs.stp_sto_cfg);
> +}
> +
> +static inline u32 rk3x_i2c_get_hs_count(struct rk3x_i2c *i2c)
> +{
> +       return REG_CON_SDA_CNT(i2c->t_hs.sda_update_cfg) |
> +              REG_CON_STA_CNT(i2c->t_hs.stp_sta_cfg) |
> +              REG_CON_STO_CNT(i2c->t_hs.stp_sto_cfg);
> +}

nit: "count" is confusing here.  A better word would be "adjustment"
or "tuning", like:

rk3x_i2c_get_fs_adjustment
  -or-
rk3x_i2c_get_fs_tuning

Also: is there really a reason to do all these shifts and ORs every
time?  Why not just calculate the proper initial u32 and just store it
somewhere?


> +
>  /* Reset all interrupt pending bits */
>  static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
>  {
> @@ -138,17 +222,52 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
>  }
>
>  /**
> + * Generate a Master Code condition, which triggers a REG_INT_NAKRCV interrupt.
> + *
> + * @error: Error code to return in rk3x_i2c_xfer

There is no error parameter.  Remove comment?

Might not hurt to mention in the comment that this is only used in
high speed mode?

> + */
> +static void rk3x_i2c_send_master_code(struct rk3x_i2c *i2c)
> +{
> +       u32 ctrl;
> +
> +       i2c->state = STATE_MC;
> +       i2c_writel(i2c, REG_INT_NAKRCV, REG_IEN);
> +
> +       i2c_writel(i2c, (i2c->t_fs.div_high << 16) |
> +                  (i2c->t_fs.div_low & 0xffff), REG_CLKDIV);
> +       ctrl = rk3x_i2c_get_fs_count(i2c);
> +
> +       /* enable adapter with correct mode, send START condition */
> +       ctrl = ctrl | REG_CON_EN | REG_CON_MOD(REG_CON_MOD_TX) | REG_CON_START;

nit: use "ctrl |=" instead of "ctrl = ctrl |"

> +       i2c_writel(i2c, ctrl, REG_CON);
> +
> +       /* write master code 0x00001xxx */
> +       i2c_writel(i2c, I2C_MASTERCODE, TXBUFFER_BASE);
> +       i2c_writel(i2c, 1, REG_MTXCNT);
> +}
> +
> +/**
>   * Generate a START condition, which triggers a REG_INT_START interrupt.
>   */
>  static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>  {
>         u32 val;
>
> -       rk3x_i2c_clean_ipd(i2c);

I guess you removed this because it was redundant?  It looks like
previously we would always call rk3x_i2c_setup() before
rk3x_i2c_start() and the last thing in setup was to clean the IPD, so
no reason to do it at the beginning of start.  Is that right?

Would be very helpful to do that in a change by itself because then I
wouldn't have had to figure all this out myself.  ...and it would be
more obvious to other readers that this is an unrelated change.

> +       i2c->state = STATE_START;
>         i2c_writel(i2c, REG_INT_START, REG_IEN);
>
> +       if (i2c->speed_mode == I2C_HS_SPD) {
> +               i2c_writel(i2c, (i2c->t_hs.div_high << 16) |
> +                          (i2c->t_hs.div_low & 0xffff), REG_CLKDIV);
> +               val = rk3x_i2c_get_hs_count(i2c);
> +       } else {
> +               i2c_writel(i2c, (i2c->t_fs.div_high << 16) |
> +                          (i2c->t_fs.div_low & 0xffff), REG_CLKDIV);
> +               val = rk3x_i2c_get_fs_count(i2c);
> +       }
> +
>         /* enable adapter with correct mode, send START condition */
> -       val = REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
> +       val = val | REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;

nit: use "val |="

>
>         /* if we want to react to NACK, set ACTACK bit */
>         if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
> @@ -261,8 +380,23 @@ static void rk3x_i2c_fill_transmit_buf(struct rk3x_i2c *i2c)
>         i2c_writel(i2c, cnt, REG_MTXCNT);
>  }
>
> -
>  /* IRQ handlers for individual states */

Nit: preserve blank lines around this comment.  2 before.  1 after.
This is not a function comment but a section comment.

> +static void rk3x_i2c_handle_master_code(struct rk3x_i2c *i2c, unsigned int ipd)
> +{
> +       if (!(ipd & REG_INT_NAKRCV)) {
> +               rk3x_i2c_stop(i2c, -EIO);
> +               dev_warn(i2c->dev, "unexpected irq in MC: 0x%x\n", ipd);
> +               rk3x_i2c_clean_ipd(i2c);
> +               return;
> +       }
> +
> +       /* clean all interrupt */
> +       rk3x_i2c_clean_ipd(i2c);
> +
> +       /* generate a repeat start signal */
> +       i2c_writel(i2c, 0, REG_CON);
> +       rk3x_i2c_start(i2c);
> +}
>
>  static void rk3x_i2c_handle_start(struct rk3x_i2c *i2c, unsigned int ipd)
>  {
> @@ -390,7 +524,7 @@ static irqreturn_t rk3x_i2c_irq(int irqno, void *dev_id)
>         /* Clean interrupt bits we don't care about */
>         ipd &= ~(REG_INT_BRF | REG_INT_BTF);
>
> -       if (ipd & REG_INT_NAKRCV) {
> +       if ((ipd & REG_INT_NAKRCV) && ((i2c->state != STATE_MC))) {
>                 /*
>                  * We got a NACK in the last operation. Depending on whether
>                  * IGNORE_NAK is set, we have to stop the operation and report
> @@ -409,6 +543,9 @@ static irqreturn_t rk3x_i2c_irq(int irqno, void *dev_id)
>                 goto out;
>
>         switch (i2c->state) {
> +       case STATE_MC:
> +               rk3x_i2c_handle_master_code(i2c, ipd);
> +               break;
>         case STATE_START:
>                 rk3x_i2c_handle_start(i2c, ipd);
>                 break;
> @@ -431,21 +568,22 @@ out:
>  }
>
>  /**
> - * Calculate divider values for desired SCL frequency
> + * Calculate timing values for desired SCL frequency
>   *
>   * @clk_rate: I2C input clock rate
>   * @t: Known I2C timing information.
>   * @div_low: Divider output for low
>   * @div_high: Divider output for high
> + * @t_calc: Caculated rk3x private timings that would
> + * be written into regs

Remove @div_low and @div_high, which are no longer parameters to this function.


>   *
>   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
>   * a best-effort divider value is returned in divs. If the target rate is
>   * too high, we silently use the highest possible rate.
>   */
> -static int rk3x_i2c_calc_divs(unsigned long clk_rate,
> -                             struct i2c_timings *t,
> -                             unsigned long *div_low,
> -                             unsigned long *div_high)
> +static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
> +                                   struct i2c_timings *t,
> +                                   struct rk3x_i2c_calced_timings *t_calc)
>  {
>         unsigned long spec_min_low_ns, spec_min_high_ns;
>         unsigned long spec_setup_start, spec_max_data_hold_ns;
> @@ -552,8 +690,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>                  * Time needed to meet hold requirements is important.
>                  * Just use that.
>                  */
> -               *div_low = min_low_div;
> -               *div_high = min_high_div;
> +               t_calc->div_low = min_low_div;
> +               t_calc->div_high = min_high_div;
>         } else {
>                 /*
>                  * We've got to distribute some time among the low and high
> @@ -582,25 +720,222 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>
>                 /* Give low the "ideal" and give high whatever extra is left */
>                 extra_low_div = ideal_low_div - min_low_div;
> -               *div_low = ideal_low_div;
> -               *div_high = min_high_div + (extra_div - extra_low_div);
> +               t_calc->div_low = ideal_low_div;
> +               t_calc->div_high = min_high_div + (extra_div - extra_low_div);
>         }
>
>         /*
>          * Adjust to the fact that the hardware has an implicit "+1".
>          * NOTE: Above calculations always produce div_low > 0 and div_high > 0.
>          */
> -       *div_low = *div_low - 1;
> -       *div_high = *div_high - 1;
> +       t_calc->div_low -= 1;
> +       t_calc->div_high -=  1;

nit: you have an extra space before the "1".  Clean up.

optional: you could use "t_calc->div_high--" but no idea if it's cleaner.

>
>         /* Maximum divider supported by hw is 0xffff */
> -       if (*div_low > 0xffff) {
> -               *div_low = 0xffff;
> +       if (t_calc->div_low > 0xffff) {
> +               t_calc->div_low = 0xffff;
>                 ret = -EINVAL;
>         }
>
> -       if (*div_high > 0xffff) {
> -               *div_high = 0xffff;
> +       if (t_calc->div_high > 0xffff) {
> +               t_calc->div_high = 0xffff;
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * Calculate timing values for desired SCL frequency
> + *
> + * @clk_rate: I2C input clock rate
> + * @t: Known I2C timing information
> + * @t_calc: Caculated rk3x private timings that would
> + * be written into regs
> + * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> + * a best-effort divider value is returned in divs. If the target rate is
> + * too high, we silently use the highest possible rate.
> + * The following formulas are v1's method to calculate timings.
> + *
> + * l = divl + 1;
> + * h = divh + 1;
> + * s = sda_update_config + 1;
> + * u = start_setup_config + 1;
> + * p = stop_setup_config + 1;
> + * T = Tclk_i2c;
> +
> + * tHigh = 8 * h * T;
> + * tLow = 8 * l * T;
> +
> + * tHD;sda = (l * s + 1) * T;
> + * tSU;sda = [(8 - s) * l + 1] * T;
> + * tI2C = 8 * (l + h) * T;
> +
> + * tSU;sta = (8h * u + 1) * T;
> + * tHD;sta = [8h * (u + 1) - 1] * T;
> + * tSU;sto = (8h * p + 1) * T;
> + */

Side note: I didn't review this function a whole lot.


> +static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
> +                                   struct i2c_timings *t,
> +                                   struct rk3x_i2c_calced_timings *t_calc)
> +{
> +       unsigned long spec_min_low_ns, spec_min_high_ns;
> +       unsigned long spec_min_setup_start_ns, spec_min_stop_setup_ns;
> +       unsigned long spec_min_data_setup_ns, spec_max_data_hold_ns;
> +
> +       unsigned long min_low_ns, min_high_ns, min_total_ns;
> +       unsigned long min_setup_start_ns, min_setup_data_ns;
> +       unsigned long min_stop_setup_ns, max_hold_data_ns;
> +
> +       unsigned long clk_rate_khz, scl_rate_khz;
> +
> +       unsigned long min_low_div, min_high_div;
> +
> +       unsigned long min_div_for_hold, min_total_div;
> +       unsigned long extra_div, extra_low_div;
> +       unsigned long sda_update_cfg;
> +
> +       int ret = 0;
> +
> +       /* Support standard-mode, fast-mode and highspeed-mode */
> +       if (WARN_ON(t->bus_freq_hz > 3400000))
> +               t->bus_freq_hz = 3400000;
> +
> +       /* prevent scl_rate_khz from becoming 0 */
> +       if (WARN_ON(t->bus_freq_hz < 1000))
> +               t->bus_freq_hz = 1000;
> +
> +       /*
> +        * min_low_ns: The minimum number of ns we need to hold low to
> +        *             meet I2C specification, should include fall time.
> +        * min_high_ns: The minimum number of ns we need to hold high to
> +        *              meet I2C specification, should include rise time.
> +        */
> +       if (t->bus_freq_hz <= 100000) {
> +               spec_min_low_ns = 4700;
> +               spec_min_high_ns = 4000;
> +
> +               spec_min_setup_start_ns = 4700;
> +               spec_min_stop_setup_ns = 4000;
> +
> +               spec_min_data_setup_ns = 250;
> +               spec_max_data_hold_ns = 3450;
> +       } else if (t->bus_freq_hz <= 400000) {
> +               spec_min_low_ns = 1300;
> +               spec_min_high_ns = 600;
> +
> +               spec_min_setup_start_ns = 600;
> +               spec_min_stop_setup_ns = 600;
> +
> +               spec_min_data_setup_ns = 100;
> +               spec_max_data_hold_ns = 900;
> +       } else if (t->bus_freq_hz <= 1700000) {
> +               spec_min_low_ns = 320;
> +               spec_min_high_ns = 120;
> +
> +               spec_min_setup_start_ns = 160;
> +               spec_min_stop_setup_ns = 160;
> +
> +               spec_min_data_setup_ns = 10;
> +               spec_max_data_hold_ns = 150;
> +       } else {
> +               spec_min_low_ns = 160;
> +               spec_min_high_ns = 60;
> +
> +               spec_min_setup_start_ns = 160;
> +               spec_min_stop_setup_ns = 160;
> +
> +               spec_min_data_setup_ns = 10;
> +               spec_max_data_hold_ns = 70;
> +       }

Boy, sure seems like it would be nice to somehow share these values
between the two functions.  Maybe we can create some structures with
the union of both sets of data and then add a function that gets the
right structure?  Like:

struct i2c_spec_values {
  unsigned long min_low_ns;
  unsigned long setup_start_ns;
  unsigned long stop_setup_ns; /* should be setup_stop_ns ? */
  unsigned long min_high_ns;
  unsigned long min_data_setup_ns;
  unsigned long max_data_hold_n;
  unsigned long hold_buffer_ns;
};

const struct standard_spec = {
  .min_low_ls = 4700,
  .setup_start_ns = 4700,
  ...
};

Then use with:

spec = rk3x_get_spec(t->bus_freq_hz);

> +
> +       /* caculate min-divh and min-divl */
> +       clk_rate_khz = DIV_ROUND_UP(clk_rate, 1000);
> +       scl_rate_khz = t->bus_freq_hz / 1000;
> +       min_total_div = DIV_ROUND_UP(clk_rate_khz, scl_rate_khz * 8);
> +
> +       min_high_ns = t->scl_rise_ns + spec_min_high_ns;
> +       min_high_div = DIV_ROUND_UP(clk_rate_khz * min_high_ns, 8 * 1000000);
> +
> +       min_low_ns = t->scl_fall_ns + spec_min_low_ns;
> +       min_low_div = DIV_ROUND_UP(clk_rate_khz * min_low_ns, 8 * 1000000);
> +
> +       /* Final divh and divl must be greater than 0, otherwise the
> +        * hardware would not output the i2c clk.
> +        */
> +       min_high_div = (min_high_div < 1) ? 2 : min_high_div;
> +       min_low_div = (min_low_div < 1) ? 2 : min_low_div;
> +
> +       /* These are the min dividers needed for min hold times. */
> +       min_div_for_hold = (min_low_div + min_high_div);
> +       min_total_ns = min_low_ns + min_high_ns;
> +
> +       /*
> +        * This is the maximum divider so we don't go over the maximum.
> +        * We don't round up here (we round down) since this is a maximum.
> +        */
> +        if (min_div_for_hold >= min_total_div) {
> +               /*
> +                * Time needed to meet hold requirements is important.
> +                * Just use that.
> +                */
> +               t_calc->div_low = min_low_div;
> +               t_calc->div_high = min_high_div;
> +       } else {
> +               /*
> +                * We've got to distribute some time among the low and high
> +                * so we don't run too fast.
> +                * We'll try to split things up by the scale of min_low_div and
> +                * min_high_div, biasing slightly towards having a higher div
> +                * for low (spend more time low).
> +                */
> +               extra_div = min_total_div - min_div_for_hold;
> +               extra_low_div = DIV_ROUND_UP(min_low_div * extra_div,
> +                                            min_div_for_hold);
> +
> +               t_calc->div_low = min_low_div + extra_low_div;
> +               t_calc->div_high = min_high_div + (extra_div - extra_low_div);
> +       }
> +
> +       /*
> +        * calculate sda data hold count by the rules, data_upd_st:3
> +        * is a appropriate value to reduce calculated times.
> +        */
> +       for (sda_update_cfg = 3; sda_update_cfg > 0; sda_update_cfg--) {
> +               max_hold_data_ns =  DIV_ROUND_UP((sda_update_cfg
> +                                                * (t_calc->div_low) + 1)
> +                                                * 1000000, clk_rate_khz);
> +               min_setup_data_ns =  DIV_ROUND_UP(((8 - sda_update_cfg)
> +                                                * (t_calc->div_low) + 1)
> +                                                * 1000000, clk_rate_khz);
> +               if ((max_hold_data_ns < spec_max_data_hold_ns) &&
> +                   (min_setup_data_ns > spec_min_data_setup_ns)) {
> +                       t_calc->sda_update_cfg = sda_update_cfg;
> +                       break;
> +               }
> +       }
> +
> +       /* caculate setup start config */

s/caculate/calculate

> +       min_setup_start_ns = t->scl_rise_ns + spec_min_setup_start_ns;
> +       t_calc->stp_sta_cfg = DIV_ROUND_UP(clk_rate_khz * min_setup_start_ns
> +                          - 1000000, 8 * 1000000 * (t_calc->div_high));
> +
> +       /* caculate setup stop config */

s/caculate/calculate

> +       min_stop_setup_ns = t->scl_rise_ns + spec_min_stop_setup_ns;
> +       t_calc->stp_sto_cfg = DIV_ROUND_UP(clk_rate_khz * min_stop_setup_ns
> +                          - 1000000, 8 * 1000000 * (t_calc->div_high));
> +
> +       t_calc->stp_sta_cfg -= 1;
> +       t_calc->stp_sto_cfg -= 1;
> +       t_calc->sda_update_cfg -= 1;
> +
> +       t_calc->div_low -= 1;
> +       t_calc->div_high -= 1;
> +
> +       /* Maximum divider supported by hw is 0xffff */
> +       if ((t_calc->div_low > 0xffff) || (t_calc->div_high > 0xffff)) {
> +               t_calc->div_low = 0xffff;
> +               t_calc->div_high = 0xffff;

You have slightly different logic than _v0 because if either div_low
or div_high needs to be too big you'll set them _both_ to max.

Specifically imagine if div_low = 0x10000 and div_high = 0x8000.  The
_v0 code would end up picking div_low = 0xffff and leaving div_high at
0x8000.  Your code will set them both to 0xffff.  I would argue that
the old code is slightly more correct, but I guess that could be up
for debate.

Does it matter since we're returning an error code?  Probably not, but
you never know.  The error code is used to try to stop clock
transitions, but if (somehow) the clock transition happens anyway or
if you've got to deal with a bad clock at boot time then it _could_
matter.

It's unlikely that we'll get into this situation in a well-designed
system, so it probably doesn't matter too much but:

* We should minimize unnecessary diffs between _v0 and _v1 so they're
easier to compare and reason about.  So if we pick your new scheme we
should change the _v0 code to match.  ...and it would be nice if this
were in a separate patch to make things easier to reason about.

* The old code isn't broken that I know of, so I'd prefer not to
change it and just have _v1 match.

>                 ret = -EINVAL;
>         }
>
> @@ -610,24 +945,46 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>  static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
>  {
>         struct i2c_timings *t = &i2c->t;
> -       unsigned long div_low, div_high;
> +       struct rk3x_i2c_calced_timings *t_fs = &i2c->t_fs;
> +       struct rk3x_i2c_calced_timings *t_hs = &i2c->t_hs;
>         u64 t_low_ns, t_high_ns;
> -       int ret;
> -
> -       ret = rk3x_i2c_calc_divs(clk_rate, t, &div_low, &div_high);
> -       WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
> +       int ret = 0;
>
> -       clk_enable(i2c->clk);
> -       i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV);
> -       clk_disable(i2c->clk);
> +       if (i2c->soc_data->calc_timings) {

Why the "if" test.  Presumably it's illegal to have calc_timings be NULL?

> +               t->bus_freq_hz = i2c->fs_clock;

This is pretty ugly.  Probably better to make two copies of these
timings at probe time and then modify it then.  It's unexpected that
you'd be dynamically modifying this structure during operation that is
populated at probe time.

Note: that means you can totally remove your fs_clock and hs_clock
variables I think.


> +               ret = i2c->soc_data->calc_timings(clk_rate, t, t_fs);
> +               WARN_ONCE(ret != 0, "Could not reach FS SCL freq %u",
> +                         t->bus_freq_hz);
> +
> +               if (i2c->speed_mode) {

Please compare against I2C_HS_SPD.  Don't assume that I2C_FS_SPD is 0.

> +                       t->bus_freq_hz = i2c->hs_clock;
> +                       ret = i2c->soc_data->calc_timings(clk_rate, t, t_hs);
> +                       WARN_ONCE(ret != 0, "Could not reach HS SCL freq %u",
> +                                 t->bus_freq_hz);
> +               }
> +       }
>
> -       t_low_ns = div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate);
> -       t_high_ns = div_u64(((u64)div_high + 1) * 8 * 1000000000, clk_rate);
> +       t_low_ns = div_u64(((u64)t_fs->div_low + 1) * 8 * 1000000000,
> +                          clk_rate);
> +       t_high_ns = div_u64(((u64)t_fs->div_high + 1) * 8 * 1000000000,
> +                           clk_rate);
>         dev_dbg(i2c->dev,
> -               "CLK %lukhz, Req %uns, Act low %lluns high %lluns\n",
> +               "FS CLK %lukHz, Req %uns, Act low %lluns high %lluns\n",
>                 clk_rate / 1000,
> -               1000000000 / t->bus_freq_hz,
> +               1000000000 / i2c->fs_clock,
>                 t_low_ns, t_high_ns);
> +
> +       if (i2c->speed_mode) {

Please compare against I2C_HS_SPD.  Don't assume that I2C_FS_SPD is 0.

> +               t_low_ns = div_u64(((u64)t_hs->div_low + 1) * 8 * 1000000000,
> +                                  clk_rate);
> +               t_high_ns = div_u64(((u64)t_hs->div_high + 1) * 8 * 1000000000,
> +                                   clk_rate);
> +               dev_dbg(i2c->dev,
> +                       "HS CLK %lukHz, Req %uns, Act low %lluns high %lluns\n",
> +                       clk_rate / 1000,
> +                       1000000000 / i2c->hs_clock,
> +                       t_low_ns, t_high_ns);
> +       }
>  }
>
>  /**
> @@ -652,12 +1009,16 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
>  {
>         struct clk_notifier_data *ndata = data;
>         struct rk3x_i2c *i2c = container_of(nb, struct rk3x_i2c, clk_rate_nb);
> -       unsigned long div_low, div_high;
> +       struct i2c_timings *t = &i2c->t;
> +       struct rk3x_i2c_calced_timings *t_calc;
>
>         switch (event) {
>         case PRE_RATE_CHANGE:
> -               if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t,
> -                                      &div_low, &div_high) != 0)
> +               t_calc = (i2c->speed_mode == I2C_HS_SPD) ?
> +                                       &i2c->t_hs : &i2c->t_fs;

As I understand it, this is wrong.  If you get a rate change you need
to make sure you'll be able to properly make _both_ the high speed and
full speed clocks (or, if you have no high speed clock, just the full
speed clock).

Remember that this bit of code is just supposed to do error checking
so that we can stop a bad rate change before it happens.  Actually,
adding a comment to that effect wouldn't hurt...

> +
> +               if (i2c->soc_data->calc_timings(ndata->new_rate,
> +                                               t, t_calc) != 0)

* CRASH *

...at least that's what happened when I ran this code in the virtual
machine of my brain.  calc_timings() now stores its results in the
memory pointed to by the last parameter.  In your case I think that
points into LaLa land.

It would probably be sane to find some way to run this code.  Perhaps
you can find someone nearby that has one of the old rockchip SoCs
where the i2c clock is based off the same PLL as cpufreq?


>                         return NOTIFY_STOP;
>
>                 /* scale up */
> @@ -753,7 +1114,6 @@ static int rk3x_i2c_setup(struct rk3x_i2c *i2c, struct i2c_msg *msgs, int num)
>
>         i2c->addr = msgs[0].addr;
>         i2c->busy = true;
> -       i2c->state = STATE_START;

OK, so you moved this into rk3x_i2c_start() because sometimes you
don't go straight to that state.  Makes sense.  For debugging
purposes, do you think it makes sense to add a STATE_SETUP?  That way
we can still init to something here and if we ever get an unexpected
interrupt we'll know that we did the setup but never made it to start
or mastercode?

>         i2c->processed = 0;
>         i2c->error = 0;
>
> @@ -767,11 +1127,14 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>  {
>         struct rk3x_i2c *i2c = (struct rk3x_i2c *)adap->algo_data;
>         unsigned long timeout, flags;
> +       unsigned int ctrl;
>         int ret = 0;
>         int i;
>
>         spin_lock_irqsave(&i2c->lock, flags);
>
> +       if (i2c->pclk)
> +               clk_enable(i2c->pclk);
>         clk_enable(i2c->clk);
>
>         i2c->is_last_msg = false;
> @@ -793,7 +1156,16 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>
>                 spin_unlock_irqrestore(&i2c->lock, flags);
>
> -               rk3x_i2c_start(i2c);
> +               /*
> +                * Need to send master code firstly, when it is in
> +                * high speed mode. And we would get nack irq
> +                * after master code sended, to restart normal
> +                * i2c transfer there.
> +                */
> +               if ((i2c->speed_mode == I2C_HS_SPD) && (i == 0))
> +                       rk3x_i2c_send_master_code(i2c);
> +               else
> +                       rk3x_i2c_start(i2c);

Technically you could probably disable the pclk while waiting for the
interrupt.  Not sure if it's worth it.  Might be a small power
savings...

>
>                 timeout = wait_event_timeout(i2c->wait, !i2c->busy,
>                                              msecs_to_jiffies(WAIT_TIMEOUT));
> @@ -806,7 +1178,11 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>
>                         /* Force a STOP condition without interrupt */
>                         i2c_writel(i2c, 0, REG_IEN);
> -                       i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
> +                       ctrl = (i2c->speed_mode == I2C_HS_SPD) ?
> +                               rk3x_i2c_get_hs_count(i2c) :
> +                               rk3x_i2c_get_fs_count(i2c);
> +                       i2c_writel(i2c, ctrl | REG_CON_EN | REG_CON_STOP,
> +                                  REG_CON);
>
>                         i2c->state = STATE_IDLE;
>
> @@ -821,6 +1197,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>         }
>
>         clk_disable(i2c->clk);
> +       if (i2c->pclk)
> +               clk_disable(i2c->pclk);
>         spin_unlock_irqrestore(&i2c->lock, flags);
>
>         return ret < 0 ? ret : num;
> @@ -836,16 +1214,30 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
>         .functionality          = rk3x_i2c_func,
>  };
>
> -static struct rk3x_i2c_soc_data soc_data[3] = {
> -       { .grf_offset = 0x154 }, /* rk3066 */
> -       { .grf_offset = 0x0a4 }, /* rk3188 */
> -       { .grf_offset = -1 },    /* no I2C switching needed */
> +static struct rk3x_i2c_soc_data soc_data[] = {
> +       {
> +               .grf_offset = 0x154,
> +               .calc_timings = rk3x_i2c_v0_calc_timings,
> +       },
> +       {
> +               .grf_offset = 0x0a4,
> +               .calc_timings = rk3x_i2c_v0_calc_timings,
> +       },
> +       {
> +               .grf_offset = -1,
> +               .calc_timings = rk3x_i2c_v0_calc_timings,
> +       },
> +       {
> +               .grf_offset = -1,
> +               .calc_timings = rk3x_i2c_v1_calc_timings,
> +       },
>  };
>
>  static const struct of_device_id rk3x_i2c_match[] = {
>         { .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
>         { .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
>         { .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
> +       { .compatible = "rockchip,rk3399-i2c", .data = (void *)&soc_data[3] },

This is getting unwieldly.  No reason to group these into arrays.
While you're at it, make them const.

AKA:

static const struct rk3x_i2c_soc_data rk3066_soc_data = {
    .grf_offset = 0x154,
    .calc_timings = rk3x_i2c_v0_calc_timings,
};

static const struct rk3x_i2c_soc_data rk3188_soc_data = {
    .grf_offset = 0x0a4,
    .calc_timings = rk3x_i2c_v0_calc_timings,
};

static const struct rk3x_i2c_soc_data rk3288_soc_data = {
    .grf_offset = -1,
    .calc_timings = rk3x_i2c_v0_calc_timings,
};

static const struct rk3x_i2c_soc_data rk3399_soc_data = {
    .grf_offset = -1,
    .calc_timings = rk3x_i2c_v1_calc_timings,
};

static const struct of_device_id rk3x_i2c_match[] = {
  { .compatible = "rockchip,rk3066-i2c", .data = (void *)&rk3066_soc_data },
  { .compatible = "rockchip,rk3188-i2c", .data = (void *)&rk3188_soc_data },
  { .compatible = "rockchip,rk3228-i2c", .data = (void *)&rk3288_soc_data },
  { .compatible = "rockchip,rk3288-i2c", .data = (void *)&rk3288_soc_data },
  { .compatible = "rockchip,rk3399-i2c", .data = (void *)&rk3399_soc_data },
  {},
};


>         {},
>  };
>  MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
> @@ -871,6 +1263,14 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>
>         /* use common interface to get I2C timing properties */
>         i2c_parse_fw_timings(&pdev->dev, &i2c->t, true);
> +       if (i2c->t.bus_freq_hz > I2C_FS_TX_CLOCK) {
> +               i2c->speed_mode = I2C_HS_SPD;
> +               i2c->fs_clock = I2C_FS_TX_CLOCK;

Technically there could be reasons why someone would want a different
fs_clock here (like if there were 100kHz devices on the same bus as a
High Speed device), but I guess that's unlikely and we can always deal
with it when we get there.


> +               i2c->hs_clock = i2c->t.bus_freq_hz;
> +       } else {
> +               i2c->speed_mode = I2C_FS_SPD;
> +               i2c->fs_clock = i2c->t.bus_freq_hz;
> +       }
>
>         strlcpy(i2c->adap.name, "rk3x-i2c", sizeof(i2c->adap.name));
>         i2c->adap.owner = THIS_MODULE;
> @@ -879,7 +1279,6 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>         i2c->adap.dev.of_node = np;
>         i2c->adap.algo_data = i2c;
>         i2c->adap.dev.parent = &pdev->dev;
> -

Please, no unrelated whitespace changes.

>         i2c->dev = &pdev->dev;
>
>         spin_lock_init(&i2c->lock);
> @@ -946,15 +1345,31 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>
>         ret = clk_prepare(i2c->clk);
>         if (ret < 0) {
> -               dev_err(&pdev->dev, "Could not prepare clock\n");
> +               dev_err(&pdev->dev, "Could not prepare i2c clock\n");
>                 return ret;
>         }
>
> +       ret = of_property_match_string(np, "clock-names", "pclk");

As you could maybe tell from the bindings, I'd do this differently.

Old code and old bindings specified no name for the clocks.  So for
old hardware we need to preserve the call:

  devm_clk_get(&pdev->dev, NULL);

For new hardware I think it probably makes sense to require names.  So
I'd probably do something like:

1. Put all clock getting together.  No reason to get one clock at the
top of the function and the other clock down here.

2. Check for new hardware with "soc_data->calc_timings ==
rk3x_i2c_v1_calc_timings".  If new hardware, get by name.

3. I don't see any reason for the extra 'of_property_match_string(np,
"clock-names", "pclk");' bit.  Just try to get the clocks if it's new
hardware.

4. Technically I think you need to check for -EPROBE_DEFER when getting clocks


> +       if (ret >= 0) {
> +               i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
> +               if (IS_ERR(i2c->pclk)) {
> +                       dev_err(i2c->dev, "Could not get i2c pclk\n");
> +                       ret = PTR_ERR(i2c->pclk);
> +                       goto err_clk;
> +               }
> +
> +               ret = clk_prepare(i2c->pclk);
> +               if (ret) {
> +                       dev_err(i2c->dev, "Could not prepare pclk\n");
> +                       goto err_clk;
> +               }
> +       }
> +
>         i2c->clk_rate_nb.notifier_call = rk3x_i2c_clk_notifier_cb;
>         ret = clk_notifier_register(i2c->clk, &i2c->clk_rate_nb);
>         if (ret != 0) {
>                 dev_err(&pdev->dev, "Unable to register clock notifier\n");
> -               goto err_clk;
> +               goto err_pclk;
>         }
>
>         clk_rate = clk_get_rate(i2c->clk);
> @@ -972,6 +1387,9 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>
>  err_clk_notifier:
>         clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
> +err_pclk:
> +       if (i2c->pclk)
> +               clk_unprepare(i2c->pclk);
>  err_clk:
>         clk_unprepare(i2c->clk);
>         return ret;
> @@ -985,6 +1403,8 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
>
>         clk_notifier_unregister(i2c->clk, &i2c->clk_rate_nb);
>         clk_unprepare(i2c->clk);
> +       if (i2c->pclk)
> +               clk_unprepare(i2c->pclk);
>
>         return 0;
>  }
> --
> 1.9.1
>
>
