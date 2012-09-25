From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Sep 2012 11:18:26 +0200
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <5061754E.9050204@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1348531338-16624-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120925053542.GK14266@lunn.ch> <5061754E.9050204@gmail.com>
Message-ID: <20120925111826.6f4086ee@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Tue, 25 Sep 2012 11:11:42 +0200, Sebastian Hesselbarth wrote:

> I didn't try to post all the dove on mach-mvebu patches in the current
> release cycle, because mach-mvebu is still evolving to fast for me to keep
> up with my limited spare time. But I have dove running on mach-mvebu...

Yes, this work is really great. However, I think that instead of making
a big change at once, we should rather follow something like:

 * Make mach-dove, mach-kirkwood, mach-orion5x, mach-mv78xx0 use the
   new gpio/pinctrl code

 * Remove the plat-orion gpio/pinctrl code

 * Make mach-dove, mach-kirkwood, mach-orion5x, mach-mv78xx0 use DT for
   everything.

 * Remove the plat-orion common.c file (once all devices are probed
   through DT, common.c is no longer needed).

 * Add clock framework support for everybody, with the code in
   drivers/clk/.

 * Refactor the PCI code so that it can cover all cases. We should soon
   be working on PCI support on Armada 370/XP, so it will show what are
   the differences/issues in having something that covers all cases.

 * And then, only, merge everybody in mach-mvebu.

The idea here is to make the existing
mach-{dove,kirkwood,orion5x,mv78xx0} gradually converge to DT,
pinctrl/gpio, clock and other things, and only after that merge into
mach-mvebu. It will be much easier to do the merge as most of the code
in those mach- directory will have disappeared, as well as the code in
plat-orion.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
