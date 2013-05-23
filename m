From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 13:22:55 +0200
Subject: [PATCH 1/3] ARM: at91: move at91 aic driver to drivers/irqchip
In-Reply-To: <20130523102601.GI9937@game.jcrosoft.org>
References: <1369299909-10078-1-git-send-email-b.brezillon@overkiz.com>
 <1369299909-10078-2-git-send-email-b.brezillon@overkiz.com>
 <20130523090611.GG9937@game.jcrosoft.org>
 <519DE6A8.6040502@overkiz.com> <20130523120920.1df8e23a@skate>
 <20130523100951.GH9937@game.jcrosoft.org>
 <20130523122000.22a9a4d0@skate>
 <20130523102601.GI9937@game.jcrosoft.org>
Message-ID: <20130523132255.3acf4431@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Christophe PLAGNIOL-VILLARD,

On Thu, 23 May 2013 12:26:01 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:

> > Did you read what I write? In arch/arm/mach-at91/pm.c, the only
> > accesses made to the AIC registers are for pr_debug() calls, i.e only
> > to print some debugging messages. I believe those ones can simply be
> > removed to decouple the pm.c code from the irq.c code.
> 
> yes I read and yes I do not want to move code before we do cleanup MANDATORY

Then please explain to our volunteer contributor what sort of cleanup
is required. Simply NACKing without offering any insight as to how
things should be done is completely useless, counter-productive, and a
complete abuse of a maintainer's power over contributors.

> >  * PATCH 1: remove usage of AIC registers for debug messages in pm.c
> NACK I do want this debug, very usefull to debug pm

For the cases where you need to debug this stuff, you can always re-add
some instrumentation in this code to dump whatever you want.

Or, alternatively, we can make the irqchip driver show using
pr_debug() the value of IMR in its ->suspend() hook, the value of IMR &
IPR in its ->resume() hook, and the pm.c code can show the PMC_PCSR on
suspend. This way, you have all the informations you need for debugging.

Having the PM driver and the irqchip driver step on each other register
areas is anyway a bad idea, especially when the only reason to do so is
for two debugging messages that can be implemented differently.

Notice that this solution can always be improved later on if needed,
with further cleanups from you.

But please stop rejecting valid patches from contributors, just because
the code is not coming from you. What Boris is proposing is perfectly
fine, just needs a little bit more work to sort out the header
problems as we discussed, and is a good step in the right direction. And
this step in the right direction doesn't prevent anyone else, including
you, to provide additional patches to move even further in the right
direction.

It would be good if the other AT91 maintainers could raise their voice
here, so that Boris knows whether it is worthwhile doing additional
revisions of this patch set.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
