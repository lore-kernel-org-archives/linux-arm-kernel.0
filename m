From: yh.huang@mediatek.com (YH Huang)
Date: Fri, 30 Oct 2015 15:41:40 +0800
Subject: [PATCH v2] pwm-backlight: fix the panel power sequence
In-Reply-To: <1446133259.3274.52.camel@pengutronix.de>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
 <1444988219.3541.3.camel@pengutronix.de>
 <1445526750.27586.8.camel@mtksdaap41>
 <1446133259.3274.52.camel@pengutronix.de>
Message-ID: <1446190900.17558.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hpilipp,

On Thu, 2015-10-29 at 16:40 +0100, Philipp Zabel wrote:
> Hi YH,
> 
> Am Donnerstag, den 22.10.2015, 23:12 +0800 schrieb YH Huang:
> > In the case of the panel disabled by the bootloader,
> > your patch still has the following code and always enables the backlight
> > in the probe function.
> > pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> > -						  GPIOD_OUT_HIGH);
> 
> You are right.
> 
> > What do you think if I remove these two lines in my patch?
> > if (pb->enable_gpio)
> > 	gpiod_direction_output(pb->enable_gpio, 0);
> 
> That won't work if the gpio is still configured as input. How about I
> add the GPIOD_ASIS change to my patch you remove that and the above from
> yours?

I revise these two lines 
if (pb->enable_gpio)
	gpiod_direction_output(pb->enable_gpio, 0);
into
if (pb->enable_gpio) {
	if(gpiod_get_value(pb->enable_gpio) == 0)
		gpiod_direction_output(pb->enable_gpio, 0);
	else
		gpiod_direction_output(pb->enable_gpio, 1);
}

I am not sure what "phandle" is working for.
My change is like your patch but remove the "phandle related" and
"gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT".
Do we really need these?

Also, do you think it is right that I do the "pwm_enable(pb->pwm);"
before "gpiod_set_value(pb->enable_gpio, 1);" in power on function?

Regards,
YH Huang
