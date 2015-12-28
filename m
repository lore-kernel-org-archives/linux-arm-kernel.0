From: milo.kim@ti.com (Milo Kim)
Date: Mon, 28 Dec 2015 09:56:20 +0900
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151223115632.GS16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
Message-ID: <568088B4.6090207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 23/12/15 20:56, Mark Brown wrote:
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
>
>> +	gpio = lp->pdata->enable_gpio;
>> +	if (!gpio_is_valid(gpio))
>> +		return 0;
>> +
>> +	/* Always set enable GPIO high. */
>> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
>> +	if (ret) {
>> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
>> +		return ret;
>> +	}
>
> This isn't really adding support for the enable GPIO as the changelog
> suggests, it's requesting but not managing the GPIO.  Since there is
> core support for manging enable GPIOs this seems especially silly,
> please tell the core about the GPIO and then it will work at runtime
> too.
>

With reference to my previous mail, external GPIOs for LDO3 and BUCK2 in 
LP8725 can be specified through regulator_config.ena_gpio. BUCK2 only 
can be controlled by external pin when CONFIG pin is grounded.

Please see the description at page 5 of the datasheet.

	http://www.ti.com/lit/ds/symlink/lp8725.pdf

Best regards,
Milo
