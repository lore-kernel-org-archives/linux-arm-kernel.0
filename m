From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 20 Nov 2018 18:49:31 +0100 (CET)
Subject: [PATCH 0/8] BCM2835 PM driver
In-Reply-To: <20181120172000.15102-1-eric@anholt.net>
References: <20181120172000.15102-1-eric@anholt.net>
Message-ID: <1299453058.112996.1542736171394@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 18:19 geschrieben:
> 
> 
> This series moves the BCM2835 WDT driver that controls a fraction of
> the PM block out to soc/ and adds most of the rest of its
> functionality.  My motivation has been to have V3D be functional
> without firmware calls, probably improve its interactivity (since
> we'll be able to power on/off without RPC to the firmware that may be
> busy with other tasks), and (in a patch not submitted in this series)
> extend its binding to use the reset controller instead of trying to
> reset by toggling its power domain.
> 
> I've tested V3D with a few hours of running a V3D test, sleep(1) (to
> trigger PM domain off); running a GPU hang job (to trigger reset);
> sleep(1).  The non-hanging success-case job always passed, and dmesg
> had no complaints from bcm2835-pm.  The other power domains are not
> tested, but I've done my best.
> 
> This series will probably also be of interest to the
> https://github.com/christinaa/rpi-open-firmware project for enabling USB.
> 

apologize to give you my feedback after you send out the series.

I know you won't be happy about it, but i think we need a little more complex but future proof solution for this power driver. According to the register definition of the PM block, we have multiple functions here (power domains, watchdog, pads/pinctrl, ...). Since this is common for ARM SoCs there is a subsystem called mfd (multi function device) [1] to abstract all resources of the IP block.

This has the advantage that we don't need a monolithic driver which takes care of all functions.

According to this approach we would have the following drivers:
mfd/bcm2835.c
soc/bcm/bcm2835-power.c
watchdog/bcm2835_wdt.c

Best regards
Stefan

[1] - http://events17.linuxfoundation.org/sites/events/files/slides/belloni-mfd-regmap-syscon_0.pdf
