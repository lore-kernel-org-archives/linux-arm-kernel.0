From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 21 Jun 2014 00:27:13 +0200
Subject: [PATCH 6/7] pwm: st: Add new driver for ST's PWM IP
In-Reply-To: <53A2F342.7030606@st.com>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-6-git-send-email-lee.jones@linaro.org>
 <20140618231127.GF26514@mithrandir>
 <20140619084404.GA26560@lee--X1> <53A2F342.7030606@st.com>
Message-ID: <20140620222712.GB29400@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 07:57:14PM +0530, Ajit Pal wrote:
> On Thursday 19 June 2014 02:14 PM, Lee Jones wrote:
> >On Thu, 19 Jun 2014, Thierry Reding wrote:
> >>On Wed, Jun 18, 2014 at 03:52:51PM +0100, Lee Jones wrote:
[...]
> >>>+                   cdata->max_prescale + 1, sizeof(unsigned long),
> >>>+                   st_pwm_cmp_periods);
> >>>+   if (!found) {
> >>>+           dev_err(dev, "failed to find matching period\n");
> >>>+           return -EINVAL;
> >>>+   }
> >>>+
> >>>+   prescale = found - &pc->pwm_periods[0];
> >>
> >>This is somewhat unconventional. None of the other drivers precompute
> >>possible periods and I'm not convinced that it's an advantage. Setting
> >>the period (and configuring the PWM in general) is a fairly uncommon
> >>operation.
> >
> >Another one for Ajit I feel.
> 
> For ST PWM IP, the PWM period is fixed to 256 local clock pulses.There is no
> register interface to select PWM periods.To change the period we have to
> change the prescaler.
> We precompute the possible periods, so as to avoid the calculations
> everytime the .config function is called. Based upon a matching period we
> then select the prescaler.
> Sorry but why do you think precomputing is not helpful ?

Mostly I dislike it here because it sticks out as nobody else is doing
it. Secondly I'm not convinced that it gives you much of a performance
gain since the computations aren't that involved and typically the
period isn't changed all that often.

Also computing the value directly in .config() makes the code much
easier to follow.

> >>>+static int st_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >>>+{
> >>>+   struct st_pwm_chip *pc = to_st_pwmchip(chip);
> >>>+   struct device *dev = pc->dev;
> >>>+   int ret;
> >>>+
> >>>+   ret = clk_enable(pc->clk);
> >>>+   if (ret)
> >>>+           return ret;
> >>>+
> >>>+   ret = regmap_field_write(pc->pwm_en, 1);
> >>>+   if (ret)
> >>>+           dev_err(dev, "%s,pwm_en write failed\n", __func__);
> 
> >>
> >>This error message is somewhat cryptic, perhaps:
> >>
> >>       "failed to enable PWM"
> >
> >Agreed.  I also can't believe I missed that nasty __func__ too.
> >
> >>? Also what implications does this have on controllers with multiple
> >>channels?
> >
> >I believe this enables both channels, but I'm sure Ajit will correct
> >me if I'm wrong.
> 
> Yes it enables all channels.Unfortunately we do not have the facility to
> enable/disable individual channels on the ST PWM IP.

That's bad. If you can't control them separately then there's no way you
can guarantee the semantics of the PWM framework.

> >>>+   dev_dbg(dev, "pwm counter :%u\n", val);
> >>>+
> >>>+   clk_disable(pc->clk);
> >>>+}
> >>>+
> >>>+static const struct pwm_ops st_pwm_ops = {
> >>>+   .config = st_pwm_config,
> >>>+   .enable = st_pwm_enable,
> >>>+   .disable = st_pwm_disable,
> >>>+   .owner = THIS_MODULE,
> >>>+};
> >>>+
> >>>+static int st_pwm_probe_dt(struct st_pwm_chip *pc)
> >>>+{
> >>>+   struct device *dev = pc->dev;
> >>>+   const struct reg_field *reg_fields;
> >>>+   struct device_node *np = dev->of_node;
> >>>+   struct st_pwm_compat_data *cdata = pc->cdata;
> >>>+   u32 num_chan;
> >>>+
> >>>+   of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
> >>>+   if (num_chan)
> >>>+           cdata->num_chan = num_chan;
> >>
> >>I don't like this very much. What influences the number of channels? Is
> >>it that specific SoC revisions have one and others have two?
> >
> >Ajit?
> >
> Depends on the board type on which the SoC is used.

I don't understand. How can the board influence the number of PWM
channels that the SoC supports? It does make sense for a board to define
how many of them are actually *used*, but that's nothing that DT should
contain nor that the driver should care about. The driver (and DT for
that matter) should expose the hardware block's full capabilities. The
use-case is what should determine what's used and what not.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/d90bb109/attachment.sig>
