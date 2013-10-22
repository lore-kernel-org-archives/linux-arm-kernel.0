From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 22:48:12 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <52665314.2040904@imgtec.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org> <5265AFED.1040503@roeck-us.net>
 <52665314.2040904@imgtec.com>
Message-ID: <20131022204811.GD8037@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 11:27:32AM +0100, James Hogan wrote:
> On 21/10/13 23:51, Guenter Roeck wrote:
> > In my opinion, not being able to describe behavior (or what people refer
> > to as "describe how the hardware is used") is a severe limitation of
> > devicetree usage in Linux. That is not a devicetree limitation per se,
> > though, it is simply a matter of choice (or, in some cases, the ability
> > of those arguing for new bindings to sell those bindings as "hardware
> > description").
> 
> I agree this is a real problem, and I think it hinders upstream
> submission, since platform data was permitted to describe behaviour as
> well as describe the hardware, and platform data is being replaced with
> DT which is only permitted to describe the hardware. How then should we
> specify the behaviour to the kernel?
> 
> I've already mentioned specific examples of this on the "Clock DT
> bindings" thread, and would be very interested if anybody has thoughts
> about it:
> http://lkml.kernel.org/r/520E1DF5.4030409 at imgtec.com

I've certainly run into similar problems. To be specific, one such
instance involved backlight devices. In a nutshell, Linux' backlight
subsystem by default enables a backlight when it is probed (well, the
subsystem doesn't do that, but pretty much every driver does). This
seems to have worked very well, but when you hook up a backlight with
something high-level such as DRM, the fact that you no longer control
when the backlight is turned on becomes a problem. DRM knows very
precisely when a backlight or panel should be turned on, because it's
tightly coupled with when the display controller starts sending data to
the display. If the backlight is turned on by default at some
unpredictable point during the boot process, you end up with a powered
backlight that shows you all sorts of artifacts while the display is
being initialized.

My first attempt at solving this was to add a backlight-boot-off
property to the device tree, which would make the device driver keep the
backlight turned off on boot by default so that the DRM driver would be
able to turn it on only after the display was properly initialized.

Obviously that doesn't represent the hardware but some random bit of
software policy. The bad thing about it is that there's no other place
to put this bit of information. I can't change the default behaviour of
the backlight driver either because it is generic and used by many other
boards. So what's the solution to that? Perhaps duplicate the driver
with only the boot on default changed? Or add a new compatible value
"pwm-backlight-disabled-on-boot"? Guess that won't be acceptable either
because it encodes behaviour. "pwm-backlight-v2" wouldn't encode any
behaviour...

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/c67ec51a/attachment.sig>
