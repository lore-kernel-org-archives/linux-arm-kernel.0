From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 10:20:13 +0100
Subject: [PATCH v5 3/4] regulator: max77686: Add suspend disable for some
 LDOs
In-Reply-To: <20141028223121.GH18557@sirena.org.uk>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-4-git-send-email-k.kozlowski@samsung.com>
 <20141028223121.GH18557@sirena.org.uk>
Message-ID: <1414574413.18868.6.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-10-28 at 22:31 +0000, Mark Brown wrote:
> On Mon, Oct 27, 2014 at 01:11:49PM +0100, Krzysztof Kozlowski wrote:
> 
> > @@ -247,6 +250,8 @@ static struct regulator_ops max77686_ldo_ops = {
> >  	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> >  	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> >  	.set_suspend_mode	= max77686_ldo_set_suspend_mode,
> > +	.set_suspend_disable	= max77686_set_suspend_disable,
> > +	.set_suspend_enable	= max77686_enable,
> 
> This looks wrong, you're using the regular enable operation as suspend
> enable.  How does that work without disrupting the current runtime
> state?

Currently it shouldn't disrupt state of regulator because during runtime
it may only be only: on (0x3) or off (0x0). Suspend enable in max77686
writes 0x3 to the register which means - always on.

If regulator was disabled before suspend then it has to be enabled
during suspend_enable() call which is exactly what max77686_enable does.
If it was enabled then nothing happens.

Best regards,
Krzysztof
