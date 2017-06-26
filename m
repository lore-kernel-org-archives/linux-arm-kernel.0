From: jic23@jic23.retrosnub.co.uk (Jonathan Cameron)
Date: Mon, 26 Jun 2017 07:01:15 +0200
Subject: [PATCH 2/3] iio: adc: mt7622: add support for suspend/resume.
In-Reply-To: <1498445692.844.5.camel@mhfsdcap03>
References: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
 <1498110274-18678-3-git-send-email-zhiyong.tao@mediatek.com>
 <20170624210043.29569f3a@kernel.org> <1498445692.844.5.camel@mhfsdcap03>
Message-ID: <114E2942-6A96-432A-A4E1-6976440D1883@jic23.retrosnub.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26 June 2017 04:54:52 CEST, zhiyong tao <zhiyong.tao@mediatek.com> wrote:
>On Sat, 2017-06-24 at 21:00 +0100, Jonathan Cameron wrote:
>> On Thu, 22 Jun 2017 13:44:33 +0800
>> Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>> 
>> > This patch supports auxadc suspend/resume flow.
>> > Disable auxadc clk and power in suspend function.
>> > Enable axuadc clk and power in resume function.
>> > 
>> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
>> Worth handling the cases where power management is not configured
>into the
>> kernel properly.
>> 
>> So a few minor suggestions.  Otherwise looks good to me.
>> > ---
>> >  drivers/iio/adc/mt6577_auxadc.c |   37
>+++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 37 insertions(+)
>> > 
>> > diff --git a/drivers/iio/adc/mt6577_auxadc.c
>b/drivers/iio/adc/mt6577_auxadc.c
>> > index 2d104c8..2dd7c74 100644
>> > --- a/drivers/iio/adc/mt6577_auxadc.c
>> > +++ b/drivers/iio/adc/mt6577_auxadc.c
>> > @@ -184,6 +184,37 @@ static int mt6577_auxadc_read_raw(struct
>iio_dev *indio_dev,
>> >  	.read_raw = &mt6577_auxadc_read_raw,
>> >  };
>> >  
>> > +static int mt6577_auxadc_resume(struct device *dev)
>> > +{
>> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> > +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
>> > +	int ret;
>> > +
>> > +	ret = clk_prepare_enable(adc_dev->adc_clk);
>> > +	if (ret) {
>> > +		pr_err("failed to enable auxadc clock\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>> > +			      MT6577_AUXADC_PDN_EN, 0);
>> > +	mdelay(MT6577_AUXADC_POWER_READY_MS);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int mt6577_auxadc_suspend(struct device *dev)
>> Mark these __maybe_unused for the CONFIG_PM but not CONFIG_PM_SLEEP
>case.
Preferred to mark __maybe_unused and use the macro mentioned below.
>
>==> ok, We will add CONFIG_PM_SLEEP for the suspend/resume case in v2.
>thanks!
>
>> > +{
>> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> > +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
>> > +
>> > +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>> > +			      0, MT6577_AUXADC_PDN_EN);
>> > +	clk_disable_unprepare(adc_dev->adc_clk);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> >  static int mt6577_auxadc_probe(struct platform_device *pdev)
>> >  {
>> >  	struct mt6577_auxadc_device *adc_dev;
>> > @@ -269,6 +300,11 @@ static int mt6577_auxadc_remove(struct
>platform_device *pdev)
>> >  	return 0;
>> >  }
>> >  
>> > +static const struct dev_pm_ops mt6577_auxadc_pm_ops = {
>> > +	.suspend = mt6577_auxadc_suspend,
>> > +	.resume = mt6577_auxadc_resume,
>> > +};
>> > +
>> Use the SIMPLE_SYSTEM_PM_OPS macro to make these assignments
>magically go away
>> if PM_CONFIG_SLEEP is not defined.
>
>==> ok, We will use SIMPLE_DEV_PM_OPS macro to change it in v2. Thanks.
>>>  static const struct of_device_id mt6577_auxadc_of_match[] = {
>> >  	{ .compatible = "mediatek,mt2701-auxadc", },
>> >  	{ .compatible = "mediatek,mt8173-auxadc", },
>> > @@ -280,6 +316,7 @@ static int mt6577_auxadc_remove(struct
>platform_device *pdev)
>> >  	.driver = {
>> >  		.name   = "mt6577-auxadc",
>> >  		.of_match_table = mt6577_auxadc_of_match,
>> > +		.pm = &mt6577_auxadc_pm_ops,
>> >  	},
>> >  	.probe	= mt6577_auxadc_probe,
>> >  	.remove	= mt6577_auxadc_remove,
>> 
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
