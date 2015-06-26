From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Jun 2015 15:17:37 +0200
Subject: [PATCH] ARM64: kernel: psci: use restart_handlers instead of
 arm_pm_restart
In-Reply-To: <558D169F.7000804@arm.com>
References: <1622532.VhvqsHJ0rH@diego> <558D169F.7000804@arm.com>
Message-ID: <3078335.RozZuJC7dp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 26. Juni 2015, 10:08:47 schrieb Sudeep Holla:
> +Mark, Lorenzo
> 
> On 26/06/15 00:33, Heiko St?bner wrote:
> > Instead of hogging the arm_pm_restart callback, register a restart_handler
> > to make it possible for machines to register more board-specific
> > restart functionality.
> 
> Just curious to know why do you need board specific restart handlers in
> Linux. The firmware implementing PSCI is board specific and can deal
> with all board specific handling in the firmware.

I guess in most consumer devices it will be more of a

	s/and can deal/and is supposed to deal/


> > The priority is set to 127, 1 below the "default" to facilitate for
> > example the use of regular per-soc restart handlers at their default
> > priority 128 and others like the gpio-restart at priority 129 or above.
> > 
> > Non-psci restarts can be necessary when either the psci implementation
> > is faulty and does not implement the restart callback or devices need
> 
> Interesting, SYSTEM_RESET is mandatory from PSCIv0.2 and why only
> exception for faulty PSCI system reset while it's assumed all other
> features are never faulty. IMO it needs to be fixed in the firmware.

I've asked Rockchip to also implement the SYSTEM_RESET in their psci firmware, 
but of course there are already quite some devices on the market and the psci 
firmware part seems to be considered non-replaceable in some devices too.

In general I think people not reading the specification fully, will sadly 
happen way to often and in the case of the rk3368 they have added a "nice"

	#ifndef CONFIG_ARCH_ROCKCHIP
		arm_pm_restart = psci_sys_reset;

		pm_power_off = psci_sys_poweroff;
	#endif

in their vendor kernel. Also this psci firmware-part sadly is not publically 
available, so fixing this myself is also not possible.


> > even more custom restart operations, like recent rk3288-chromebooks.
> > While the soc-level restart could restart those, an external component
> > needed to be also reset (via gpio-restart) to allow the device to even
> > boot again.
> 
> Again firmware implementing PSCI is platform specific and can deal any
> such customization required.

I don't believe the common board manufacturer (using a soc-vendor bsp) has the 
knowledge or cares to much about following the psci specification and 
implementing his board-specific restart method there. And in the case of the 
Rockchip psci-implementation, I'm currently not sure if they even get the 
sources for the psci code.


So yes, I of course know this is not ideal, switching over to restart handlers 
allows to circumvent these lapses in firmware implementation without damaging 
sane psci implementations. And I guess once secondary cpu core come up, often 
developers will stop reading the spec.


> By the way, I am not arguing against usage of register_restart_handler
> over arm_pm_restart, but the reasoning given here.

ok - I can of course leave the reasoning out of the patch description, if this 
helps yours (or anybodies) conscience :-D


Heiko
