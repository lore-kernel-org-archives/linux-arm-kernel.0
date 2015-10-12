From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 14:46:54 -0700
Subject: [PATCH 00/37] ARM: dts: Fix fixed regulators enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20151012214654.GE23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [151012 14:17]:
> Hello,
> 
> While working on regulators, GPIOs and DT I noticed that many of our DT source
> files incorrectly describe fixed regulators. The common error patterns are
> 
> - Usage of the undefined (and never parsed) enable-active-low property
> - Usage of the enable-active-high property without specifying an enable GPIO
> - Typos in the enabl GPIO property name (gpios instead of gpio)
> - Mismatch between the enable-active-high property (or the lack thereof) and
>   the enable GPIO flags
> 
> This patch series fixes those issues in all the DT sources after locating the
> errors using the following script.
> 
> ------------------------------------------------------------------------------
> #!/bin/sh
> 
> echo $1
> cat $1 | awk '
> BEGIN {
> 	open_drain = 0;
> 	active_high = 0;
> 	gpio = 0;
> 	flags = 0;
> }
> 
> match($0, /([a-zA-Z0-9 at _-]*) {/, ary) {
> 	name = ary[1];
> }
> 
> /compatible.*"regulator-fixed"/ {
> 	found = 1;
> }
> 
> /enable-active-high/ {
> 	active_high = 1;
> }
> 
> /gpio-open-drain/ {
> 	open_drain = 1;
> }
> 
> match($0, /gpio += <.* ([^ ]*)>/, ary) {
> 	gpio = 1;
> 	flags = ary[1];
> 	if (flags == 0)
> 		flags = "GPIO_ACTIVE_HIGH";
> }
> 
> /}/ {
> 	if (found) {
> 		if (gpio) {
> 			print "\t" name ": active high " active_high " " flags " open drain " open_drain;
> 			if ((active_high && flags == "GPIO_ACTIVE_LOW") ||
> 			    (!active_high && flags == "GPIO_ACTIVE_HIGH"))
> 				print "WARNING: enable-active-high and flags do not match"
> 		} else {
> 			if (active_high)
> 				print "WARNING: active high without GPIO"
> 			if (open_drain)
> 				print "WARNING: open drain without GPIO"
> 		}
> 	}
> 
> 	gpio = 0;
> 	found = 0;
> 	active_high = 0;
> 	open_drain = 0;
> 	flags = 0;
> }
> '
> ------------------------------------------------------------------------------
> 
> All patches except for the ones touching omap3-beagle-xm and omap3-overo-base
> are untested as I lack test hardware.
> 
> As there's no dependency between the patches touching different source files
> the appropriate maintainers could take their share of the patches in their
> tree. Alternatively I could send a single pull request after collecting all
> acks but that might be more complex.

Nice clean-up. For omaps, there's an earlier patch posted by
Javier Martinez Canillas <javier@osg.samsung.com> as "[PATCH] ARM: dts: Use
defined GPIO constants in flags cell for OMAP2+ boards". Can you guys do some
cross checking and let me know which combination I should appluy for omaps?

Regards,

Tony
