From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Oct 2013 22:43:35 +0200
Subject: [PATCH 05/10] ARM: SAMSUNG: Initialize PWM backlight enable_gpio
 field
In-Reply-To: <524B14E8.5040302@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-6-git-send-email-treding@nvidia.com>
 <524B14E8.5040302@wwwdotorg.org>
Message-ID: <20131001204335.GB9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:31:04PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> > The GPIO API defines 0 as being a valid GPIO number, so this field needs
> > to be initialized explicitly.
> 
> >  static void __init smdkv210_map_io(void)
> 
> > @@ -70,6 +70,7 @@ static struct samsung_bl_drvdata samsung_dfl_bl_data __initdata = {
> >  		.max_brightness = 255,
> >  		.dft_brightness = 255,
> >  		.pwm_period_ns  = 78770,
> > +		.enable_gpio    = -1,
> >  		.init           = samsung_bl_init,
> >  		.exit           = samsung_bl_exit,
> >  	},
> > @@ -121,6 +122,10 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
> >  		samsung_bl_data->lth_brightness = bl_data->lth_brightness;
> >  	if (bl_data->pwm_period_ns)
> >  		samsung_bl_data->pwm_period_ns = bl_data->pwm_period_ns;
> > +	if (bl_data->enable_gpio)
> > +		samsung_bl_data->enable_gpio = bl_data->enable_gpio;
> > +	if (bl_data->enable_gpio_flags)
> > +		samsung_bl_data->enable_gpio_flags = bl_data->enable_gpio_flags;
> 
> Won't this cause the core pwm_bl driver to request/manipulate the GPIO,
> whereas this driver already does that inside the samsung_bl_init/exit
> callbacks? I think you either need to adjust those callbacks, or not set
> the new standard GPIO property in samsung_bl_data.

I don't think so. The samsung_bl_data is a copy of samsung_dfl_bl_data
augmented by board-specific settings. So in fact copying these values
here is essential to allow boards to override the enable_gpio and flags
fields. Currently no board sets the enable_gpio to a valid GPIO so it's
all still handled by the callbacks only.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/a24201f7/attachment.sig>
