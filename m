From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 28 Sep 2015 11:19:56 +0200
Subject: [PATCH v6 5/5] leds: netxbig: set led_classdev max_brightness
In-Reply-To: <5608F41B.4020307@samsung.com>
References: <1443301358-2131-1-git-send-email-simon.guinot@sequanux.org>
 <1443301358-2131-6-git-send-email-simon.guinot@sequanux.org>
 <5608F41B.4020307@samsung.com>
Message-ID: <20150928091956.GY7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 10:02:35AM +0200, Jacek Anaszewski wrote:
> Hi Simon,

Hi Jacek,

> 
> Does your device support reading the brightness currently set?

No it don't.

> If so, it would be good to implement brightness_get op, because
> AFAIR you mentioned that the firmware you are working with sets
> always maximum brightness value. Having the op implemented would
> allow to find this out.

I don't understand how this can help. I mean, the only issue is that at
startup the initial LED state is unknown. And the software brightness
value could be false. But once the LED is configured, the brightness
values for software and hardware are synchronized. The brightness value
is stored/cached in led_classdev and it can be retrieved by the user via
sysfs...

For my own knowledge, is there some interest in having brightness_get(),
aside of guessing the LED initial state ?

What does the embedded firmware is writing 255 or 0 into the brightness
sysfs attribute. The max_brightness value is ignored. After this patch,
writing 255 and 0 still allows to configure the LED in the same way:
maximum brightness or off. Thus, I believe there is no compatibility
issue.

But of course, I will update the firmware as well :)

Thanks,

Simon

> 
> On 09/26/2015 11:02 PM, Simon Guinot wrote:
> >This patch sets the led_classdev max_brightness to the maximum level
> >value supported by hardware. This allows to get rid of the brightness
> >conversion operation (from software [0:LED_FULL] to hardware ranges) in
> >brightness_set().
> >
> >Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >---
> >  drivers/leds/leds-netxbig.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
> >index b166fd9f4186..4b88b93244be 100644
> >--- a/drivers/leds/leds-netxbig.c
> >+++ b/drivers/leds/leds-netxbig.c
> >@@ -116,7 +116,6 @@ struct netxbig_led_data {
> >  	int			mode_addr;
> >  	int			*mode_val;
> >  	int			bright_addr;
> >-	int			bright_max;
> >  	struct			netxbig_led_timer *timer;
> >  	int			num_timer;
> >  	enum netxbig_led_mode	mode;
> >@@ -178,7 +177,7 @@ static void netxbig_led_set(struct led_classdev *led_cdev,
> >  	struct netxbig_led_data *led_dat =
> >  		container_of(led_cdev, struct netxbig_led_data, cdev);
> >  	enum netxbig_led_mode mode;
> >-	int mode_val, bright_val;
> >+	int mode_val;
> >  	int set_brightness = 1;
> >  	unsigned long flags;
> >
> >@@ -204,12 +203,9 @@ static void netxbig_led_set(struct led_classdev *led_cdev,
> >  	 * SATA LEDs. So, change the brightness setting for a single
> >  	 * SATA LED will affect all the others.
> >  	 */
> >-	if (set_brightness) {
> >-		bright_val = DIV_ROUND_UP(value * led_dat->bright_max,
> >-					  LED_FULL);
> >+	if (set_brightness)
> >  		gpio_ext_set_value(led_dat->gpio_ext,
> >-				   led_dat->bright_addr, bright_val);
> >-	}
> >+				   led_dat->bright_addr, value);
> >
> >  	spin_unlock_irqrestore(&led_dat->lock, flags);
> >  }
> >@@ -306,11 +302,11 @@ static int create_netxbig_led(struct platform_device *pdev,
> >  	 */
> >  	led_dat->sata = 0;
> >  	led_dat->cdev.brightness = LED_OFF;
> >+	led_dat->cdev.max_brightness = template->bright_max;
> >  	led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
> >  	led_dat->mode_addr = template->mode_addr;
> >  	led_dat->mode_val = template->mode_val;
> >  	led_dat->bright_addr = template->bright_addr;
> >-	led_dat->bright_max = template->bright_max;
> >  	led_dat->timer = pdata->timer;
> >  	led_dat->num_timer = pdata->num_timer;
> >  	/*
> >
> 
> 
> -- 
> Best Regards,
> Jacek Anaszewski
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150928/58676f37/attachment-0001.sig>
