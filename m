From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jun 2015 16:44:39 +0100
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <d6d361113992920900137899ae4d1f7b@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1434677895.4767.11.camel@dolka.fr> <5583DD23.90505@arm.com>
 <1434716194.17448.28.camel@x60s>
 <20150619131315.GR7557@n2100.arm.linux.org.uk>
 <d6d361113992920900137899ae4d1f7b@dolka.fr>
Message-ID: <20150619154439.GS7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 03:46:45PM +0200, Benjamin Cama wrote:
> Hi Russell,
> Do not misunderstand me: I am not at all for keeping the situation like
> this! What I ask is just for users to be notified of this new requirement:
> for my case, my board simply couldn't boot anymore, without any
> explanation.

It's not a new requirement.  It's something that's been there all along,
and is finally starting to bite places where it never used to bite before.
It's a latent bug in platform code, that's all.

This "IRQ0 is bad" has been known for quite some while - you've already
been pointed at Linus' rant about it, dated 25 Jan 2007.  If you do a bit
of research, you'll find that the orion code was contributed _after_ that
date.

While it's easy to stick a warning into orion_irq_init() (or whatever the
function is called), it's utterly pointless now that it's been found -
just fix all the users of orion_irq_init() now and be done with it.

As for "shouldn't this have had a warning in the past", well, maybe, but
consider this task:

	Please go and look at the other mach-* directories, and find
	all those which might use IRQ0, and arrange for them to print
	a warning.

I'm sure you'll see what a task it is that you're asking for.

What you're asking for is actually unreasonable.


(I am aware that Dove broke exactly for this reason, and I've been
carrying a patch since December 2014 to fix Dove - but I just don't have
the time to get it merged - like most of my other Dove work.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
