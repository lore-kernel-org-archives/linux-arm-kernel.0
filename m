From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Wed, 7 Nov 2018 15:03:17 +0000
Subject: [PATCH 1/2] regulator: act8945: Implement PM functionalities
In-Reply-To: <20181107145349.GA6809@sirena.org.uk>
References: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
 <1540570753-16370-2-git-send-email-claudiu.beznea@microchip.com>
 <20181107145349.GA6809@sirena.org.uk>
Message-ID: <b17eeca5-e517-393e-d9a9-bfb4121c5857@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07.11.2018 16:53, Mark Brown wrote:
> On Fri, Oct 26, 2018 at 04:19:48PM +0000, Claudiu.Beznea at microchip.com wrote:
> 
>> +static unsigned int act8945a_of_map_mode(unsigned int mode)
>> +{
>> +	if (mode == ACT8945A_DCDC_MODE_POWER_SAVING)
>> +		return REGULATOR_MODE_STANDBY;
>> +
>> +	return REGULATOR_MODE_NORMAL;
>> +}
> 
> This should error out if it gets an unknown value rather than silently
> mapping it to normal - we don't know what the user intended to set here.
> There should also be some binding documentation updates saying what the
> values that can be set are.

Sure, I will update it on next version.

> 
>> +static void act8945a_pmic_shutdown(struct platform_device *pdev)
>> +{
>> +	struct act8945a_pmic *act8945a = platform_get_drvdata(pdev);
>> +	struct regmap *regmap = act8945a->regmap;
>> +
>> +	/*
>> +	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
>> +	 */
>> +	regmap_write(regmap, ACT8945A_SYS_CTRL, 0x0);
>>  }
>>  
> 
> This shutdown function appears to be independant of the mode setting and
> would be better split out as a separate patch (you could have one patch
> adding the regmap stuff, one for this and one for the mode setting).
> It makes review a lot simpler if each patch does a minimal set of
> changes.

Ok, I will split them in next version.

Thank you,
Claudiu Beznea

> 
