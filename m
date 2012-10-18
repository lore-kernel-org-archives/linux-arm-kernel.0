From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 18 Oct 2012 13:47:59 -0700
Subject: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and
 _od_resume_noirq
In-Reply-To: <20121018193440.GA8609@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Thu, 18 Oct 2012 22:34:40 +0300")
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-2-git-send-email-balbi@ti.com>
 <871ugvivso.fsf@deeprootsystems.com>
 <20121018165525.GA6385@arwen.pp.htv.fi>
 <87ipa7d6cy.fsf@deeprootsystems.com>
 <20121018175027.GA7917@arwen.pp.htv.fi>
 <87vce77hba.fsf@deeprootsystems.com>
 <20121018193440.GA8609@arwen.pp.htv.fi>
Message-ID: <874nlr5wxs.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

[...]

> if the device implements none of the suspend methods, then you
> shouldn't suspend it at all, because you'd be masking a bug in the
> driver, IMHO.

OK, let's start over here, because here's the fundamental difference.  I
don't think missing suspend methods means a bug in the driver at all.

For a moment, let's ignore the limitations/restrictions that exist today
betwen system PM and runtime PM and assume runtime PM can be used
anytime, including anywhere in the suspend/resume path.

In that ideal world, many drivers would not need system suspend methods
at all.  They would just runtime PM to enable/disable themselves based
on driver/device activity.

Stated differently, since the driver is using runtime PM, when system
suspend happens, the device is already idle, and runtime suspended, so
there is nothing for the system PM methods to do.  Therefore, no system
PM callbacks are needed.  No bug in driver.

(yes, this is oversimplified to illustrate the goal/point.  Some drivers
may want to have a ->suspend callback to wait/stop any current
processing, but that is just so runtime PM can kick in.)

This is the "runtime PM centric" view of things that we have been
driving towards with OMAP drivers (we've been doing this with aggressive
clock gating even before runtime PM framework.)  

In other words, if drivers are written with this "runtime PM centric"
view, there should be almost nothing to do in the suspend method, except
quiesce the hardware so runtime PM kicks in.

This runtime PM centric view is the mindset/philosophy behind the PM
domain implementation, and driver PM adaptations that we've been doing
for some time.

In converting/reviewing/testing *many* drivers that have been PM adapted
(for system PM and runtime PM), most folks do not get this right.
Therfore, if driver writers can concentrate on runtime PM, and just use
system PM as a "quiesce HW, let runtime PM take over" method, that is
where I want to go.

Kevin
