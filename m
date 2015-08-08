From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 20:34:12 +0100
Subject: [BUG, RFC] MTD Execute in Place on ARM breaks build
In-Reply-To: <55C64FE6.40007@tul.cz>
References: <55C51319.2010901@tul.cz> <1564596.BEQS8u7XSM@wuerfel>
 <20150808134708.GK7557@n2100.arm.linux.org.uk>
 <55C64FE6.40007@tul.cz>
Message-ID: <20150808193412.GP7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 08:52:22PM +0200, Petr Cvek wrote:
> How often are these chips erased/written? If it is only for system
> image update, it could be done with special code (something like
> BIOS flashing).

I have no idea what the use case is for this.  Nicolas did all the
development work while working for Montavista...  It's entirely
possible that people use jffs2 or some other writable filesystem.

> Anyway, is my patch proposal for build fixing OK?

I don't think so - it effectively hides the broken nature of it,
which really isn't what kernel maintanence is about.  If something
is wrong, either it needs to be fixed properly, or it needs to stay
as a reportable bug so it reminds people that it needs to be fixed.
Papering over a bug with something that doesn't work isn't a way
forward.

Arnd suggested getting around some of the issue with:

	#define xip_currtime()  readl_relaxed(OSCR)

which would be a step in the right direction - that should issue
correct code on PXA to read the OSCR register from the __xipram
marked code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
