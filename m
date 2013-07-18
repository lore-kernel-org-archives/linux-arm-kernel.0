From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jul 2013 10:17:35 +0100
Subject: [PATCH v1 05/24] clk: wrap I/O access for improved portability
In-Reply-To: <20130718070402.GO7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
 <20130718070402.GO7080@book.gsilab.sittig.org>
Message-ID: <20130718091735.GW24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 09:04:02AM +0200, Gerhard Sittig wrote:
> The common clock API assumes (it's part of the contract) that
> there are potentially expensive operations like get, put, prepare
> and unprepare, as well as swift and non-blocking operations like
> enable and disable.

Let's get something straight here, because what you've said above is
wrong.

1. clk_get() and clk_put() are NOT part of the common clock API.
   They're separate - they're part of the clk API, and the infrastructure
   behind that is clkdev, which is a separately owned thing (by me.)

2. The "contract" of the clk API is defined by the clk API, not by some
   random implementation like the common clock API.  The clk API is
   maintained by myself, and is described in include/linux/clk.h

3. clk_prepare() and clk_unprepare() are functions MUST only be called
   from contexts where sleeping is permitted.  These functions MAY sleep
   for whatever reason they require to, and as long as they require to.
   (This is the whole reason these two functions were created in the
   first place.)

4. clk_enable() and clk_disable() MAY be called from any context, but
   MUST never sleep.  If you need to talk over a non-atomic bus for these,
   then these functions should be no-ops, and the code which does that
   must be executed from the clk_prepare()/clk_unprepare() operations.

That is the "clk API" contract.  The CCF has no bearing on this; if it
disagrees, then the CCF is buggy and is non-conformant.
