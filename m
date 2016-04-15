From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 15 Apr 2016 15:30:33 +0800
Subject: [PATCH] i2c: designware-platdrv: implement bus recovery
In-Reply-To: <20160415070746.GA1714@lahna.fi.intel.com>
References: <1460642696-1858-1-git-send-email-jszhang@marvell.com>
 <20160414143916.GY1714@lahna.fi.intel.com>	<20160415140843.4a1e5d0f@xhacker>
 <20160415070746.GA1714@lahna.fi.intel.com>
Message-ID: <20160415153033.5a8c4952@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr 2016 10:07:46 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Fri, Apr 15, 2016 at 02:08:43PM +0800, Jisheng Zhang wrote:
> > Dear Mika,
> > 
> > On Thu, 14 Apr 2016 17:39:16 +0300 Mika Westerberg wrote:
> >   
> > > On Thu, Apr 14, 2016 at 10:04:56PM +0800, Jisheng Zhang wrote:  
> > > > Implement bus recovery methods for i2c designware so we can recover
> > > > from situations where SCL/SDA are stuck low.
> > > > 
> > > > The recovery method is similar as i2c-imx: "config the i2c pinctrl to
> > > > gpio mode by calling pinctrl sleep set function, and then use GPIO to
> > > > emulate the i2c protocol to send nine dummy clock to recover i2c
> > > > device. After recovery, set i2c pinctrl to default group setting.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > > ---
> > > > depends on runtime pm patches
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422202.html
> > > >  .../devicetree/bindings/i2c/i2c-designware.txt     | 12 ++++++
> > > >  drivers/i2c/busses/i2c-designware-core.c           |  6 ++-
> > > >  drivers/i2c/busses/i2c-designware-core.h           |  4 ++
> > > >  drivers/i2c/busses/i2c-designware-platdrv.c        | 50 ++++++++++++++++++++++
> > > >  4 files changed, 71 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > > > index fee26dc..51a55c6 100644
> > > > --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > > > +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > > > @@ -20,6 +20,13 @@ Optional properties :
> > > >   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
> > > >     This value which is by default 300ns is used to compute the tHIGH period.
> > > >  
> > > > + - scl-gpios: specify the gpio related to SCL pin
> > > > +
> > > > + - sda-gpios: specify the gpio related to SDA pin
> > > > +
> > > > + - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
> > > > +   bus recovery, call it "gpio" state
> > > > +
> > > >  Example :
> > > >  
> > > >  	i2c at f0000 {
> > > > @@ -42,4 +49,9 @@ Example :
> > > >  		i2c-sda-hold-time-ns = <300>;
> > > >  		i2c-sda-falling-time-ns = <300>;
> > > >  		i2c-scl-falling-time-ns = <300>;
> > > > +		pinctrl-names = "default", "gpio";
> > > > +		pinctrl-0 = <&pinctrl_i2c1_default>;
> > > > +		pinctrl-1 = <&pinctrl_i2c1_gpio>;
> > > > +		scl-gpios = <&porta 26 GPIO_ACTIVE_HIGH>;
> > > > +		sda-gpios = <&porta 27 GPIO_ACTIVE_HIGH>;
> > > >  	};
> > > > diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> > > > index 4255eaa..be40de1 100644
> > > > --- a/drivers/i2c/busses/i2c-designware-core.c
> > > > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > > > @@ -399,7 +399,10 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
> > > >  	while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
> > > >  		if (timeout <= 0) {
> > > >  			dev_warn(dev->dev, "timeout waiting for bus ready\n");
> > > > -			return -ETIMEDOUT;
> > > > +			i2c_recover_bus(&dev->adapter);
> > > > +			if (dw_readl(dev, DW_IC_STATUS)
> > > > +					& DW_IC_STATUS_ACTIVITY)
> > > > +				return -ETIMEDOUT;
> > > >  		}
> > > >  		timeout--;
> > > >  		usleep_range(1000, 1100);
> > > > @@ -665,6 +668,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> > > >  	/* wait for tx to complete */
> > > >  	if (!wait_for_completion_timeout(&dev->cmd_complete, HZ)) {
> > > >  		dev_err(dev->dev, "controller timed out\n");
> > > > +		i2c_recover_bus(&dev->adapter);
> > > >  		/* i2c_dw_init implicitly disables the adapter */
> > > >  		i2c_dw_init(dev);
> > > >  		ret = -ETIMEDOUT;
> > > > diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> > > > index cd409e7..26c84ee 100644
> > > > --- a/drivers/i2c/busses/i2c-designware-core.h
> > > > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > > > @@ -104,6 +104,10 @@ struct dw_i2c_dev {
> > > >  	u16			fs_lcnt;
> > > >  	int			(*acquire_lock)(struct dw_i2c_dev *dev);
> > > >  	void			(*release_lock)(struct dw_i2c_dev *dev);
> > > > +	struct i2c_bus_recovery_info rinfo;
> > > > +	struct pinctrl		*pinctrl;
> > > > +	struct pinctrl_state	*pinctrl_pins_default;
> > > > +	struct pinctrl_state	*pinctrl_pins_gpio;
> > > >  	bool			pm_runtime_disabled;
> > > >  };
> > > >  
> > > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > > index 1488cea..62bded9 100644
> > > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > > @@ -33,6 +33,7 @@
> > > >  #include <linux/err.h>
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/of_gpio.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm.h>
> > > >  #include <linux/pm_runtime.h>
> > > > @@ -148,6 +149,49 @@ static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void i2c_dw_plat_prepare_recovery(struct i2c_adapter *adap)
> > > > +{
> > > > +	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
> > > > +
> > > > +	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_gpio);
> > > > +}
> > > > +
> > > > +static void i2c_dw_plat_unprepare_recovery(struct i2c_adapter *adap)
> > > > +{
> > > > +	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
> > > > +
> > > > +	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
> > > > +}
> > > > +
> > > > +static void i2c_dw_plat_init_recovery_info(struct dw_i2c_dev *dev,
> > > > +					   struct platform_device *pdev)
> > > > +{
> > > > +	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> > > > +
> > > > +	dev->pinctrl_pins_default = pinctrl_lookup_state(dev->pinctrl,
> > > > +			PINCTRL_STATE_DEFAULT);
> > > > +	dev->pinctrl_pins_gpio = pinctrl_lookup_state(dev->pinctrl,
> > > > +			"gpio");
> > > > +	rinfo->sda_gpio = of_get_named_gpio(pdev->dev.of_node, "sda-gpios", 0);
> > > > +	rinfo->scl_gpio = of_get_named_gpio(pdev->dev.of_node, "scl-gpios", 0);
> > > > +
> > > > +	if (!gpio_is_valid(rinfo->sda_gpio) ||
> > > > +	    !gpio_is_valid(rinfo->scl_gpio) ||
> > > > +	    IS_ERR(dev->pinctrl_pins_default) ||
> > > > +	    IS_ERR(dev->pinctrl_pins_gpio)) {
> > > > +		dev_dbg(&pdev->dev, "recovery information incomplete\n");
> > > > +		return;  
> > 
> > For ACPI, we should return here, right?  
> 
> I hope so. And I do not want to see any useless messages about
> incomplete recovery information on my PC.

Got your points.

> 
> > > > +	}
> > > > +
> > > > +	dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n",
> > > > +		rinfo->sda_gpio, rinfo->scl_gpio);
> > > > +
> > > > +	rinfo->prepare_recovery = i2c_dw_plat_prepare_recovery;
> > > > +	rinfo->unprepare_recovery = i2c_dw_plat_unprepare_recovery;
> > > > +	rinfo->recover_bus = i2c_generic_gpio_recovery;    
> > > 
> > > This whole thing is DT specific and I don't see how we can do the same
> > > for ACPI. Should it be enabled only when the controller was enumerated
> > > from DT?  
> > 
> > Per my understanding, for ACPI, the pinctrl_pins_default, pinctrl_pins_gpio,
> > sda_gpio and scl_gpio will be invalid or err, so we won't setup rinfo
> > at all. However, I have no acpi platform which have i2c designware to double
> > confirm.  
> 
> What happens to those of_get_ functions when you pass NULL of_node? If
> they do not crash then I suppose it is fine.

I just checked the code,
If CONFIG_OF isn't enabled, of_get_* will return error.
If CONFIG_OF is enabled, but NULL of_node is passed, of_get_* will also return
error, so it's fine ;)

> 
> Anyhow it might be good idea to do something like
> 
> 	if (!pdev->dev.of_node)
> 		return;
> 
> in the beginning of that function.

Sounds a good idea, will do in next version.

Thanks for your review,
Jisheng
