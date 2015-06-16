From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jun 2015 21:07:58 -0600
Subject: [PATCH v2 2/3] watchdog: bcm2835: Add poweroff code for the
 Raspberry Pi
In-Reply-To: <1434195541-28368-2-git-send-email-noralf@tronnes.org>
References: <1434195541-28368-1-git-send-email-noralf@tronnes.org>
 <1434195541-28368-2-git-send-email-noralf@tronnes.org>
Message-ID: <557F930E.8010002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2015 05:39 AM, Noralf Tr?nnes wrote:
> This adds a new poweroff function to the watchdog driver for the
> Raspberry Pi. Currently poweroff/halt results in a reboot.
> 
> The Raspberry Pi firmware uses the RSTS register to know which
> partiton to boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
> 
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh

I don't understand why we need a new compatible value here; why not
simply modify the existing bcm2835_power_off() function. That is written
to do something that's interpreted by the RPi firmware, not something
that the bcm2835 HW does.

Admittedly the current name is a bit misleading, but fixing that should
be a separate change to fixing the implementation to do what the current
firmware expects.
