From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Tue, 1 Sep 2009 18:14:02 +0200
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <4A9D0896.2000007@gmail.com>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<200909011256.10882.sleep_walker@suse.cz>
	<4A9D0896.2000007@gmail.com>
Message-ID: <200909011814.03109.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne ?t 1. z??? 2009 13:42:14 Eric Miao napsal(a):
> Tom?? 'Sleep_Walker' ?ech wrote:
> > Hi,
> > 
> > Dne ?t 1. z??? 2009 11:49:24 Eric Miao napsal(a):
> >> Tom?? 'Sleep_Walker' ?ech wrote:
> >>> Hi,
> >>>
> >>> Dne Po 31. srpna 2009 19:34:51 Marek Vasut napsal(a):
> >>>> Dne Po 31. srpna 2009 19:25:58 Tom?? ?ech napsal(a):
> >>>>> From: Tom?? ?ech <sleep walker@suse.cz>
> >>>>>
> >>>>>
> >>>>> Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
> >>>>> ---
> >>>>>  arch/arm/mach-pxa/treo680.c |   10 +---------
> >>>>>  1 files changed, 1 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
> >>>>> index 050ad8e..57bccc3 100644
> >>>>> --- a/arch/arm/mach-pxa/treo680.c
> >>>>> +++ b/arch/arm/mach-pxa/treo680.c
> >>>>> @@ -254,16 +254,9 @@ static int treo680_backlight_init(struct device *dev)
> >>>>>  	ret = gpio_direction_output(GPIO_NR_TREO680_BL_POWER, 0);
> >>>>>  	if (ret)
> >>>>>  		goto err2;
> >>>>> -	ret = gpio_request(GPIO_NR_TREO680_LCD_POWER, "LCD POWER");
> >>>>> -	if (ret)
> >>>>> -		goto err2;
> >>>>> -	ret = gpio_direction_output(GPIO_NR_TREO680_LCD_POWER, 0);
> >>>>> -	if (ret)
> >>>>> -		goto err3;
> >>>>>
> >>>>>  	return 0;
> >>>>> -err3:
> >>>>> -	gpio_free(GPIO_NR_TREO680_LCD_POWER);
> >>>>> +
> >>>>>  err2:
> >>>>>  	gpio_free(GPIO_NR_TREO680_BL_POWER);
> >>>>>  err:
> >>>>> @@ -279,7 +272,6 @@ static int treo680_backlight_notify(int brightness)
> >>>>>  static void treo680_backlight_exit(struct device *dev)
> >>>>>  {
> >>>>>  	gpio_free(GPIO_NR_TREO680_BL_POWER);
> >>>>> -	gpio_free(GPIO_NR_TREO680_LCD_POWER);
> >>>>>  }
> >>>>>
> >>>>>  static struct platform_pwm_backlight_data treo680_backlight_data = {
> >>>> Why was that GPIO there before then? Does this have any effect on the boot 
> >>>> problems you are experiencing with Centro/T680? Otherwise seems OK to me
> >>> I used it first in brightness setting for 0 value. I found it not good idea. I removed it from function, but I wanted to keep GPIO registered and direction set. But it can work well even without that and I'd like to add some function to export some control GPIOs through /sys/class/gpio interface (bluetooth power, GSM power, GSM reset...) - this GPIO will be also exported there...
> >>>
> >> The name sounds like a GPIO for the power of the LCD panel itself,
> >> does it make sense to have this somewhere in the LCD power_{on,off}
> >> hooks?
> >>
> > 
> > Yes, it would be much better.
> > I was looking for the right place - did you mean pxafb_mach_info.pxafb_lcd_power?
> > 
> 
> I think so.
>

There can be problem with this. It's easy to create such function, but there is no place for initialization so I would need to call gpio_register() and gpio_direction_output() in machine init function or even elsewhere which I find a bit nasty. Should I try to update pxafb to support LCD power through GPIO too or go nasty way?

Thanks

Best regards,

Tomas Cech
