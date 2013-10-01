From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Oct 2013 23:14:49 +0200
Subject: [PATCH 10/10] pwm-backlight: Allow backlight to remain disabled
 on boot
In-Reply-To: <524B198B.3010609@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-11-git-send-email-treding@nvidia.com>
 <524B198B.3010609@wwwdotorg.org>
Message-ID: <20131001211448.GE9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:50:51PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> > The default for backlight devices is to be enabled immediately when
> > registering with the backlight core. This can be useful for setups that
> > use a simple framebuffer device and where the backlight cannot otherwise
> > be hooked up to the panel.
> > 
> > However, when dealing with more complex setups, such as those of recent
> > ARM SoCs, this can be problematic. Since the backlight is usually setup
> > separately from the display controller, the probe order is not usually
> > deterministic. That can lead to situations where the backlight will be
> > powered up and the panel will show an uninitialized framebuffer.
> > 
> > Furthermore, subsystems such as DRM have advanced functionality to set
> > the power mode of a panel. In order to allow such setups to power up the
> > panel at exactly the right moment, a way is needed to prevent the
> > backlight core from powering the backlight up automatically when it is
> > registered.
> > 
> > This commit introduces a new boot_off field in the platform data (and
> > also implements getting the same information from device tree). When set
> > the initial backlight power mode will be set to "off".
> 
> > diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> 
> > +  - backlight-boot-off: keep the backlight disabled on boot
> 
> A few thoughts:
> 
> 1) Does this property indicate that:
> 
> a) The current state of the backlight at boot. In which case, this will
> need bootloader involvement to modify the value in the DT at boot time
> based on whether the bootloader turned on the backlight:-(

I was pretty much following the regulator bindings here. But the meaning
is different indeed, see below.

> b) That the driver should not turn on the backlight immediately? That
> seems to describe driver behaviour more than HW. Is it appropriate to
> put that into DT?

That's what it was supposed to mean. The idea is, and I mentioned that
in the commit message, that when wired up with a higher-level API such
as DRM, then usually that framework knows exactly when to enable the
backlight. Having the backlight enable itself on probe may cause the
panel to light up with no content or garbage.

> Your suggestion to make the backlight not turn on by default might be a
> better fix?

I think so too, but the problem in this case is that users of this
driver heretofore assumed that it would be turned on by default. I think
that's been common practice for all backlight drivers. Adding a property
to DT was supposed to be a way to keep backwards compatibility with any
existing users while at the same time allowing the backlight to be used
in a more "modern" system. I don't really have any other ideas how to
achieve this.

It is quite possible that the only reason why turning on the backlight
at probe time is the current default is because backlight_properties'
.power field is by default initialized to 0, which turns out to be the
value of FB_BLANK_UNBLANK. That's been the source of quite a bit of
confusion (I could tell you stories of how people tried to convince me
that there must be a bug in the Linux kernel because writing a 0 to the
backlight's bl_power field in sysfs turns the backlight on instead of
off). The same is true for DPMS modes in DRM and X, where "on" has the
value 0.

Now there have been plans to overhaul the backlight subsystem for quite
some time. One of the goals was to decouple it from the FB subsystem,
which might help solve this to some degree. At the same time sysfs is an
ABI, so we can't just go and change it randomly. The same is true for
the default behaviour of enabling the backlight at boot. That can
equally be considered an ABI and changing it will cause the majority of
devices to regress, and that's not something that I look forward to
taking the blame for...

> 2) Should the driver instead attempt to read the current state of the
> GPIO output to determine whether the backlight is on? This may not be
> possible on all HW.
> 
> 3) Doesn't the following code in probe() (added in a previous patch)
> need to be updated?
> 
> > +	if (gpio_is_valid(pb->enable_gpio)) {
> > +		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> > +			gpio_set_value(pb->enable_gpio, 0);
> > +		else
> > +			gpio_set_value(pb->enable_gpio, 1);
> > +	}
> 
> ... That assumes that the backlight is on at boot, and hence presumably
> after this patch still always turns on the backlight, only to turn it
> off very quickly once the following code in this patch executes:
> 
> (and perhaps we also need to avoid turning the backlight off then on if
> it was already on at boot)

Yes, that's a good point. Depending on the outcome of the above
discussion I'll update this to match the expectations.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/1eeb9e36/attachment.sig>
