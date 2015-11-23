From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 16:34:49 +0000
Subject: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
In-Reply-To: <5868782.RxZY0W5S4d@wuerfel>
References: <5868782.RxZY0W5S4d@wuerfel>
Message-ID: <20151123163449.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 05:25:28PM +0100, Arnd Bergmann wrote:
> This patch picks the second choice, and changes the NOP to BUG(), which
> normally stops the execution of the current thread in some form (endless
> loop or a trap). This follows the logic we applied in a4b5d580e078 ("bug:
> Make BUG() always stop the machine").

I think this is a very good thing.  It changes things from "something went
wrong, we'll silently continue as if nothing happened and possibly corrupt
your data" to "something went wrong, halt or reboot the system" (depending
on the config choices and kernel configuration.)

IMHO, for a closed box device, the latter has _always_ got to be better
than the former.

I think people who argue against this forget that BUG() is only supposed
to be used when a serious error which results in data corruption has
occurred.  It isn't a general purpose reimplementation of userspace
assert(), which commonly gets used by programmers as a subsitute for
proper error handling.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
