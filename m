From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 20 Jan 2016 19:29:47 +0200
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <569FC40B.5030902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2016 02:29 PM, Lothar Wa?mann wrote:
> On the AM335x SoC rev. <= 1.0 the "Input Function of the EXTINTn
> Terminal is Inverted", for which the only remedy is to "Use an active
> high interrupt source or use an external inverter to change the
> polarity of any active low interrupt source."
> 
> This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> electronics TX48 module. Make the IRQ optional in the driver and use a
> polling routine instead if no IRQ is specified in DT.
> Otherwise the driver will continuously generate interrupts and make
> the system unusable.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>   drivers/regulator/ltc3589.c | 49 +++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c

[...]

>   }
> @@ -519,6 +539,16 @@ static int ltc3589_probe(struct i2c_client *client,
>   			return ret;
>   		}
>   	}
> +	if (client->irq <= 0) {
> +		dev_warn(dev,
> +			"No interrupt configured; poll for thermal shutdown and undervoltage events\n");
> +
> +		INIT_DELAYED_WORK(&ltc3589->poll_timer, ltc3589_poll_func);
> +		schedule_delayed_work(&ltc3589->poll_timer,
> +				msecs_to_jiffies(POLL_PERIOD));
> +
> +		return 0;
> +	}
>   
>   	ret = devm_request_threaded_irq(dev, client->irq, NULL, ltc3589_isr,
>   					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
					^^^^^^^^^^^^^^^^

I assume you have issue with IRQ because of the above hard-coded flag.
if yes - Over all approach for such kind of issues - do not hard-code IRQ triggering 
flags in code in case of DT boot. DT core will configure it properly.



[...]

-- 
regards,
-grygorii
