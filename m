From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 09:39:01 +0800
Subject: [PATCH 12/21] usb: chipidea: msm: Keep device runtime enabled
In-Reply-To: <146724741028.16253.4741331543289283958@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-13-stephen.boyd@linaro.org>
 <20160629064600.GG25236@shlinux2>
 <146724741028.16253.4741331543289283958@sboyd-linaro>
Message-ID: <20160630013901.GC19928@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 05:43:30PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-28 23:46:00)
> > On Sun, Jun 26, 2016 at 12:28:29AM -0700, Stephen Boyd wrote:
> > > Sometimes the usb wrapper device is part of a power domain that
> > > needs to stay on as long as the device is active. Let's get and
> > > put the device in driver probe/remove so that we keep the power
> > > domain powered as long as the device is attached. We can fine
> > > tune this later to handle wakeup interrupts, etc. for finer grain
> > > power management later, but this is necessary to make sure we can
> > > keep accessing the device right now.
> > 
> > Since some of the controllers work abnormal if we enables runtime
> > pm unconditionally, so I use one system flag CI_HDRC_SUPPORTS_RUNTIME_PM
> > for it. I can't understand why you can't access device without enable
> > parent's runtime pm, the controller will not enter runtime suspend
> > without that flag.
> 
> Correct, the child device of ci_hdrc_msm will be able to do runtime PM
> and keep the parent enabled if the CI_HDRC_SUPPORTS_RUNTIME_PM flag is
> set. But even if that flag isn't set, the ci_hdrc_msm driver is calling
> pm_runtime_enable() on the same device that it would be called on if the
> CI_HDRC_SUPPORTS_RUNTIME_PM flag was set. That allows runtime PM
> transition of child devices such as the usb ports (usb1-port1 for
> example) to propagate up all the way to the ci_hdrc_msm device and
> disable any attached power domains.

Sorry, I can't get you.

If the chipidea core's runtime is disabled, the port under the
controller will not be in runtime suspended, only the bus will
be in suspended due to USB core enables runtime PM by default.

> 
> Why don't we call runtime PM functions on the ci->dev for all cases of
> ci->supports_runtime_pm? It seems like the glue drivers should be
> managing their own device power states and the ci->dev should be managed
> by core.c code.
> 

This is current design. Chipidea core manages portsc.phcd and PHY's PM
(through PHY's API), and glue layer manages its own clocks on the system
bus for register visit (and data transfer if necessary).

-- 

Best Regards,
Peter Chen
