From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 10 May 2013 16:02:05 +0100
Subject: [PATCH RFC 0/2] clk: add metag specific gate/mux clocks
In-Reply-To: <1368198127-1295-1-git-send-email-james.hogan@imgtec.com>
References: <1368198127-1295-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <1368198127-1295-4-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a metag architecture specific clk-gate and clk-mux which
extends the generic ones to use global lock2 to protect the register
fields. It is common with metag to have an RTOS running on a different
thread or core with access to different bits in the same register (which
contain clock gate/switch bits for other clocks). Access to such
registers must be serialised with a global lock such as the one provided
by the metag architecture port in <asm/global_lock.h>

RFC because despite extending the generic clocks there's still a bit of
duplicated code necessary. One alternative is to add special cases to
the generic clock components for when a global or callback function
based lock is desired instead of a spinlock, but I wasn't sure if that
sort of hack would really be appreciated in the generic drivers.

Comments?

James Hogan (2):
  clk: metag/clk-gate: add metag specific clock gate
  clk: metag/clk-mux: add metag specific clk-mux

 .../bindings/clock/img,meta-gate-clock.txt         |  28 +++
 .../bindings/clock/img,meta-mux-clock.txt          |  33 ++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/metag/Makefile                         |   3 +
 drivers/clk/metag/clk-gate.c                       | 179 +++++++++++++++++
 drivers/clk/metag/clk-mux.c                        | 211 +++++++++++++++++++++
 6 files changed, 455 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/img,meta-gate-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/img,meta-mux-clock.txt
 create mode 100644 drivers/clk/metag/Makefile
 create mode 100644 drivers/clk/metag/clk-gate.c
 create mode 100644 drivers/clk/metag/clk-mux.c

-- 
1.8.1.2
