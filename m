From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 May 2015 09:48:14 +0200
Subject: [PATCHv7 0/8] watchdog: Extend kernel API and add
 early_timeout_sec feature
In-Reply-To: <5549C20F.4010605@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <20150505135054.GI25193@pengutronix.de>
 <5549C20F.4010605@offcode.fi>
Message-ID: <20150506074814.GR25193@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 06, 2015 at 10:26:07AM +0300, Timo Kokkonen wrote:
> On 05.05.2015 16:50, Uwe Kleine-K?nig wrote:
> >Hello,
> >
> >I talked to Marc Kleine-Budde about your approach, thought a bit more
> >about it and want to share a few thoughts with you.
> >
> >Actually your series addresses three different problems
> >
> >  a) some watchdog hardware isn't stoppable;
> >  b) some watchdog hardware has short maximal timeout;
> >  c) what to do with a watchdog that is already running at probe time?
> >
> >The common solution is to add a mid-layer between userspace and the
> >driver that bridges the possible hardware limitations when userspace
> >wants to stop the watchdog or set a big timeout value. c) is a bit
> >different but could make use of the infrastructure that is introduced
> >while fixing a+b). The main difference between a+b) and c) is that for
> >c) you have to introduce some policy. If the series were mine I'd first
> >do three commits that address a), b) and c) each. Then convert drivers
> >to it.
> 
> The infrastructure needed for both a and b is the same, the actual
> code to implement either a or b is also touching the same functions
> and quite slim, so I think it may not be feasible to separate those
> in their own patches. But I'll think about it and see if logical
> separation makes sense.
Yeah, probably you have to actually try it to see if it's sensible.

> >Guenter and I already said something similar, but I will eventually
> >repeat it here more explicitly: When introducing a midlayer that
> >abstracts between hardware and it's users the IMHO most important thing
> >to get right is to be explicit about which side of a midlayer you're
> >currently working at. That is, be explicit about watchdog_is_running:
> >Does it mean the hardware is running, or does userspace believe the
> >watchdog to be active? Same for timeout, stoppable etc.pp.
> 
> Yes, I agree. Thanks for clarifying this. I will keep this in mind
> and try to be explicit when naming functions and variables. The best
> way would be to also rename the existing variables too, but that
> would also touch all the existing drivers. Keeping the current
> naming scheme in place no doubt is less explicit about which side of
> the new midlayer they are working on. But luckily the logic of the
> existing driver doesn't change, they are all exposing things
> directly to userland and they can be documented as is. The new
> variables and functions add interfaces only between the new midlayer
> and HW, so they are explicit as well. So I think it is a fair
> compromise to leave all existing interface towards the user space as
> is.
Maybe a good first step before addressing a+b+c) is to cleanup the
naming? Not sure how well this works though.

> >When you consider changing the unit the watchdog core is using, why not
> >change to nano seconds and 64 bit variables? You might be able to copy
> >some algorithms and ideas from the timer core that uses these.
> 
> Yes, sounds like a good idea. I will look into it.
I wouldn't be surprised if you had to build a parallel watchdog device
model for that and assert that both work until all drivers are converted
to the new model. Sounds like fun :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
