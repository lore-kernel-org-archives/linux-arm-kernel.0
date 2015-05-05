From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 May 2015 15:50:54 +0200
Subject: [PATCHv7 0/8] watchdog: Extend kernel API and add
 early_timeout_sec feature
In-Reply-To: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <20150505135054.GI25193@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I talked to Marc Kleine-Budde about your approach, thought a bit more
about it and want to share a few thoughts with you.

Actually your series addresses three different problems

 a) some watchdog hardware isn't stoppable;
 b) some watchdog hardware has short maximal timeout;
 c) what to do with a watchdog that is already running at probe time?

The common solution is to add a mid-layer between userspace and the
driver that bridges the possible hardware limitations when userspace
wants to stop the watchdog or set a big timeout value. c) is a bit
different but could make use of the infrastructure that is introduced
while fixing a+b). The main difference between a+b) and c) is that for
c) you have to introduce some policy. If the series were mine I'd first
do three commits that address a), b) and c) each. Then convert drivers
to it.

Guenter and I already said something similar, but I will eventually
repeat it here more explicitly: When introducing a midlayer that
abstracts between hardware and it's users the IMHO most important thing
to get right is to be explicit about which side of a midlayer you're
currently working at. That is, be explicit about watchdog_is_running:
Does it mean the hardware is running, or does userspace believe the
watchdog to be active? Same for timeout, stoppable etc.pp.

When you consider changing the unit the watchdog core is using, why not
change to nano seconds and 64 bit variables? You might be able to copy
some algorithms and ideas from the timer core that uses these.

For c), I'd want to have a compile time setting that specifies the
default value for the policy:
 - disable at probe
 - don't touch a running timer
 - start at probe
This is friendly to distributions that might want to set "disable at
probe"-default to be on the safe side. Still make this overridable by a
kernel parameter. I'm not sure that "start at probe" is a sensible
feature. (Either you want to start the watchdog early, in this case even
before Linux starts; or you're not that strict then it doesn't matter
much if it takes yet another little while until your application that
pets the watchdog is up.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
