From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Oct 2013 23:23:06 +0200
Subject: [PATCH 05/10] ARM: SAMSUNG: Initialize PWM backlight enable_gpio
 field
In-Reply-To: <524B376E.6060507@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-6-git-send-email-treding@nvidia.com>
 <524B14E8.5040302@wwwdotorg.org>
 <20131001204335.GB9201@ulmo.nvidia.com>
 <524B376E.6060507@wwwdotorg.org>
Message-ID: <20131001212305.GF9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 02:58:22PM -0600, Stephen Warren wrote:
> On 10/01/2013 02:43 PM, Thierry Reding wrote:
> > On Tue, Oct 01, 2013 at 12:31:04PM -0600, Stephen Warren wrote:
> >> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> >>> The GPIO API defines 0 as being a valid GPIO number, so this
> >>> field needs to be initialized explicitly.
> >> 
> >>> static void __init smdkv210_map_io(void)
> >> 
> >>> @@ -70,6 +70,7 @@ static struct samsung_bl_drvdata
> >>> samsung_dfl_bl_data __initdata = { .max_brightness = 255, 
> >>> .dft_brightness = 255, .pwm_period_ns  = 78770, +		.enable_gpio
> >>> = -1, .init           = samsung_bl_init, .exit           =
> >>> samsung_bl_exit, }, @@ -121,6 +122,10 @@ void __init
> >>> samsung_bl_set(struct samsung_bl_gpio_info *gpio_info, 
> >>> samsung_bl_data->lth_brightness = bl_data->lth_brightness; if
> >>> (bl_data->pwm_period_ns) samsung_bl_data->pwm_period_ns =
> >>> bl_data->pwm_period_ns; +	if (bl_data->enable_gpio) +
> >>> samsung_bl_data->enable_gpio = bl_data->enable_gpio; +	if
> >>> (bl_data->enable_gpio_flags) +
> >>> samsung_bl_data->enable_gpio_flags =
> >>> bl_data->enable_gpio_flags;
> >> 
> >> Won't this cause the core pwm_bl driver to request/manipulate the
> >> GPIO, whereas this driver already does that inside the
> >> samsung_bl_init/exit callbacks? I think you either need to adjust
> >> those callbacks, or not set the new standard GPIO property in
> >> samsung_bl_data.
> > 
> > I don't think so. The samsung_bl_data is a copy of
> > samsung_dfl_bl_data augmented by board-specific settings. So in
> > fact copying these values here is essential to allow boards to
> > override the enable_gpio and flags fields. Currently no board sets
> > the enable_gpio to a valid GPIO so it's all still handled by the
> > callbacks only.
> 
> Oh yes, you're right. I was confusing the new enable_gpio field in
> pwm_bl's platform data with some other field in a custom data structure.
> 
> One minor point though:
> 
> >>> +	if (bl_data->enable_gpio) +		samsung_bl_data->enable_gpio =
> >>> bl_data->enable_gpio;
> 
> That assumes that enable_gpio==0 means "none", whereas you've gone to
> great pains in the rest of the series to allow 0 to be a valid GPIO
> ID. right now, the default value of samsung_bl_data->enable_gpio is
> -1, and if !bl_data->enable_gpio, that value won't be propagated across.

Right, that check should now be:

	if (bl_data->enable_gpio >= 0)

Well, it depends. It would be possible for the default to specify a
valid GPIO and for a board to override it with -1 (and provide a set of
corresponding callbacks). In that case the right thing to do here would
be not to check at all.

Then again, I don't think that will ever happen, because no fixed GPIO
will ever be a good default. So changing to >= 0 instead of != 0 should
work fine.

Again, starting with 3.13 this should become a lot easier to handle
since the GPIO subsystem will gain functionality to use a per-board
lookup table, similarly to what the regulator and PWM subsystems do.
Once that's in place I plan to make another pass over all users of the
pwm-backlight driver and replace the enable_gpio field with a GPIO
lookup table, so that the driver can uniformly request them using a
simple gpiod_get().

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/0ff774f6/attachment.sig>
