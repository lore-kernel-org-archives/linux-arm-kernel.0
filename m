From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 04 Jun 2010 09:29:43 +0200
Subject: [PATCH 2/2] backlight: Fix blanking for L4F00242T03 LCD
In-Reply-To: <1275630748-10722-2-git-send-email-marek.vasut@gmail.com>
References: <1275630748-10722-1-git-send-email-marek.vasut@gmail.com>
	<1275630748-10722-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275636583.3210.37.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-06-04 at 07:52 +0200, Marek Vasut wrote:
> The LCD was turned on if the variable power was > 0, but that was incorrect. The
> LCD has to be turned on in every case but POWERDOWN.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Ack

> ---
>  drivers/video/backlight/l4f00242t03.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
> index 9093ef0..ac20b2e 100644
> --- a/drivers/video/backlight/l4f00242t03.c
> +++ b/drivers/video/backlight/l4f00242t03.c
> @@ -78,7 +78,7 @@ static int l4f00242t03_lcd_power_set(struct lcd_device *ld, int power)
>  	const u16 slpin = 0x10;
>  	const u16 disoff = 0x28;
>  
> -	if (power) {
> +	if (power < FB_BLANK_POWERDOWN) {
>  		if (priv->lcd_on)
>  			return 0;
>  

lcd.h states:
struct lcd_ops {
	/* Get the LCD panel power status (0: full on, 1..3: controller
	   power on, flat panel power off, 4: full off), see FB_BLANK_XXX */
	int (*get_power)(struct lcd_device *);
	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
	int (*set_power)(struct lcd_device *, int power);

AFAIK the gray area between FB_BLANK_NORMAL and FB_BLANK_HSYNC_SUSPEND
can be chosen as needs.

Why not:

+ #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)

...

-	if (power) {
+	if (POWER_IS_ON(power)) {
 		if (priv->lcd_on)
 			return 0;

So with FB_BLANK_NORMAL the lcd is active and on -> low latencies
in re-enabling the video out, but for !POWER_IS_ON(power) we will send  
the lcd to standby.

It have to be implemented for power == FB_BLANK_POWERDOWN to turn off the 
regulators of the lcd.

What do you think about?

Regards,

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
