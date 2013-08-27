From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 27 Aug 2013 15:02:48 -0600
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <521D063F.4040404@gmail.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
Message-ID: <20130827210248.GA19625@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:04:15PM +0200, Sebastian Hesselbarth wrote:

> In the current use of watchdog even for non-DT boards, you do not
> have to clear the interrupt cause. It will ultimately lead to a
> reset in any way. Maybe it is not a big deal to remove it now
> even without non-DT replacement.

But that is the likely reason..

AFAIK, to be immune to bootloader left over you must do these steps in
order:
 - Gain control of the WDT timer, so that it doesn't trigger
 - Clear the cause register
 - Enable the reset out function

Which is what orion_wdt_start does today.

If you fiddle with the order you risk creating an errant WDT trigger,
depending on what the bootloader did.

eg having cause asserted and then setting the reset out bit will
reboot the board.

Hoisting the reset out register write into board code now requires
that the bootloader left the WDT subsystem in some kind of sane state,
probably not great..

The cause register clear should be done by the IRQ driver when the
wdt driver attaches to the interrupt, so the order must be:
 - program WDT timer registers, zero base counter, halt counting
 - attach interrupt (clears cause prior to attach)
 - enable reset out function
 - enable WDT timers

You'll need to hook the WDT interrupt (just call panic) to make this
work properly.

Our systems have a delay after the RSTOUT pin is asserted but before
the Armada is reset. This delay is designed to be long enough for an
oops to make it out of the serial port. Thus, I'm using this as the
WDT interrupt:

+static irqreturn_t orion_wdt_handler(int irq, void *arg)
+{
+       console_verbose();
+       pr_crit("Oops: Watchdog Timeout");
+       show_regs(get_irq_regs());
+       panic("Watchdog Timeout");
+       return IRQ_HANDLED;
+}

Which produces a detailed report of what was holding the CPU and
preventing userspace from running. On other hardware you can get the
oops by not enabling RSTOUTn..

Since this is so complex, maybe it is OK to abandon support for non-DT
boards in the WDT driver? Watchdog is not critical functionality, so
nobody should be critically impacted. Boards would have to migrate
to DT to get WDT back?

Jason
