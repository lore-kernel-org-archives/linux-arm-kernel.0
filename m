From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 10:03:21 +0100
Subject: i.MX consolidation patches
In-Reply-To: <20110622083257.GK6069@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
	<20110622075615.GJ6069@pengutronix.de>
	<20110622081141.GN23234@n2100.arm.linux.org.uk>
	<20110622083257.GK6069@pengutronix.de>
Message-ID: <20110622090321.GO23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 10:32:57AM +0200, Sascha Hauer wrote:
> LOADADDR ends up being 0xA0008000 when all of the above are enabled.
> Another idea I had was to replace the := with += so that we can
> count the words in zreladdr-y and bail out if we have multiple
> zreladdrs. I haven't really followed this approach as it means adjusting
> all Makefile.boot.
> 
> CONFIG_AUTO_ZRELADDR=y also does not necessarily mean that the resulting
> uImage will not work. In the above example the image will work on i.MX27

But conversely, PATCH_PHYS_TO_VIRT doesn't mean that the uImage won't
work either - I already build several kernels with it enabled for
testing purposes, and the result boots fine.

That's rather my point: PATCH_PHYS_TO_VIRT=y does not mean that the
uImage is unbootable - it's only unbootable if the uImage has a
load/start address which is invalid for the platform.

So, maybe the idea of changing LOADADDR is better.  Or maybe providing
Makefile.boot with a new variable 'nouimage' which can provide the
same functionality - and you may wish to provide LOADADDR on the command
line and detect that, in which case it should override this lockout.

Lastly, as PATCH_PHYS_TO_VIRT is relatively cheap, it's possible that
we may eventually end up with it enabled mostly everywhere, which with
the current approach would mean we might as well rip out the uboot
targets from the kernel entirely.
