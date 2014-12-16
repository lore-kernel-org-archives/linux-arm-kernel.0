From: uwe@kleine-koenig.org (=?windows-1252?Q?Uwe_Kleine-K=F6nig?=)
Date: Tue, 16 Dec 2014 11:08:57 +0100
Subject: [PATCHv1 1/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <db1f0eecbdc5062a61232b99699ecfa6e0a2a956.1418687005.git.arno@natisbad.org>
References: <cover.1418687005.git.arno@natisbad.org>
 <db1f0eecbdc5062a61232b99699ecfa6e0a2a956.1418687005.git.arno@natisbad.org>
Message-ID: <549004B9.2060402@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnaud,

On 12/16/2014 12:54 AM, Arnaud Ebalard wrote:
> 
> This patch adds alarm support to Intersil ISL12057 driver. The chip
> supports two separate alarms:
> 
>  - Alarm1: works up to one month in the future and accurate to the
>            second, associated w/ IRQ#2 pin
>  - Alarm2: works up to one month in the future and accurate to the
>            minute, associated w/ IRQ#1 or IRQ#2 pin (configuable).
> 
> This patch only adds support for Alarm1 which allows to configure
> the chip to generate an interrupt on IRQ#2 pin when current time
> matches the alarm.
> 
> This patch was tested on a Netgear ReadyNAS 102 after some soldering
> of the IRQ#2 pin of the RTC chip to a MPP line of the SoC (the one
> used usually handles the reset button). The test was performed using
> a modified .dts file reflecting this change (see below) and rtc-test.c
> program available in Documentation/rtc.txt. This test program ran as
> expected, which validates alarm supports, including interrupt support.
> 
> As a side note, the ISL12057 remains in the list of trivial devices,
> i.e. no specific DT binding being added by this patch: i2c core
> automatically handles extraction of IRQ line info from .dts file. For
> instance, if one wants to reference the interrupt line for the
> alarm in its .dts file, adding interrupt and interrupt-parent
> properties works as expected (if the primary function of your
> interrupt pin is not GPIO, you will need some additional pinctrl
> properties):
> 
>           isl12057: isl12057 at 68 {
>                   compatible = "isil,isl12057";
>                   interrupt-parent = <&gpio0>;
>                   interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
>                   reg = <0x68>;
>           };
> 
> FWIW, if someone is looking for a way to test alarm support this can
> be done in the following way:
> 
>     # echo `date '+%s' -d '+ 1 minutes'` > /sys/class/rtc/rtc0/wakealarm
>     # shutdown -h now
> 
> With the commands above, after a minute, the system comes back to life.
This paragraph belongs into the 2nd patch, right?

> diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
> index 6e1fcfb5d7e6..3ec73ad7f2d8 100644
> --- a/drivers/rtc/rtc-isl12057.c
> +++ b/drivers/rtc/rtc-isl12057.c
> @@ -79,8 +79,10 @@
>  #define ISL12057_MEM_MAP_LEN	0x10
>  
>  struct isl12057_rtc_data {
> +	struct rtc_device *rtc;
>  	struct regmap *regmap;
>  	struct mutex lock;
> +	int irq;
interrupts are usually unsigned values. Hmm, I see that it simplifies a
bit here, as the function to determine the irq returns the actual value
or a negative error. As there would be problems anyhow for irq values >
INT_MAX probably this comment isn't that important.

> +/*
> + * Note: as we only read from device and do not perform any update, there is
> + * no need for an equivalent function which would try and get driver's main
> + * lock. Here, it is safe for everyone if we just use regmap internal lock
> + * on the device when reading.
> + */
> +static int _isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
>  	u8 regs[ISL12057_RTC_SEC_LEN];
>  	unsigned int sr;
>  	int ret;
>  
> -	mutex_lock(&data->lock);
>  	ret = regmap_read(data->regmap, ISL12057_REG_SR, &sr);
>  	if (ret) {
>  		dev_err(dev, "%s: unable to read oscillator status flag (%d)\n",
> @@ -187,8 +222,6 @@ static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  			__func__, ret);
>  
>  out:
> -	mutex_unlock(&data->lock);
> -
>  	if (ret)
>  		return ret;
>  

Is this locking update worth a separate change?

Best regards
Uwe
