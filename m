From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 23 Mar 2011 00:32:26 +0900
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
Message-ID: <20110322153226.GC30303@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 12:22:05AM +0900, Magnus Damm wrote:
> On Tue, Mar 22, 2011 at 11:33 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, Mar 22, 2011 at 02:28:55PM +0000, Mark Brown wrote:
> >> On Tue, Mar 22, 2011 at 11:26:19PM +0900, Magnus Damm wrote:
> >>
> >> > The tca6416 driver makes use of the I2C bus for chatting
> >> > with the actual hardware device. Without this patch both
> >> > the I2C bus driver and the tca6416 driver are initialized
> >> > at the subsys_initcall() level. This may lead to problems
> >> > with the tca6416 driver being initialized before the I2C
> >> > bus driver.
> >>
> >> While this change seems reasonable I'm curious what the problems caused
> >> by out of order registration are?
> >
> > I'm also curious as to why link order isn't a sufficient gaurantee like
> > it is for everyone else?
> 
> I believe all other i2c keyboard drivers use module_init().
> 
We do not change initcall ordering around unless there is a reason to do
so, as it's assumed that a given initcall has been chosen for a reason.
You have hit upon a bug or at least something timing related causing you
a delay and so have elected to push it down a level. That is of course
fine, but none of that is anywhere in your commit text leaving us to try
and figure out what exactly the point of this exercise is.

Usually "because everyone else is doing it" and another driver is not,
there's a reason for that driver doing things differently. There are
certainly enough cases where initcall and link ordering is strongly
ordered for a reason that cosmetic/janitorial fixes are best rejected out
of hand.

You had a reason, great. Next time put it in your commit text.
