From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 03 Mar 2011 14:40:29 +0800
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <201102011711.31258.jeremy.kerr@canonical.com>
Message-ID: <1299134429.100626.661279191478.0.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These patches are an attempt to allow platforms to share clock code. At
present, the definitions of 'struct clk' are local to platform code,
which makes allocating and initialising cross-platform clock sources
difficult, and makes it impossible to compile a single image containing
support for two ARM platforms with different struct clks.

The three patches are for the architecture-independent kernel code,
introducing the common clk infrastructure. The changelog for the first
patch includes details about the new clock definitions.

Many thanks to the following for their input:
 * Benjamin Herrenschmidt <benh@kernel.crashing.org>
 * Ben Dooks <ben-linux@fluff.org>
 * Baruch Siach <baruch@tkos.co.il>
 * Russell King <linux@arm.linux.org.uk>
 * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
 * Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
 * Vincent Guittot <vincent.guittot@linaro.org>
 * Sascha Hauer <s.hauer@pengutronix.de>
 * Ryan Mallon <ryan@bluewatersys.com>
 * Colin Cross <ccross@google.com>
 * Jassi Brar <jassisinghbrar@gmail.com>
 * Saravana Kannan <skannan@codeaurora.org>

Cheers,


Jeremy

--
v14:
 * make empty clk_prepare & clk_unprepare static inline

v13:
 * Don't expose __clk_get and clk_put - prototypes in clkdev.c instead
 * Add might_sleep to clk_set_rate
 * Comment clarifications & fixups
 * Remove zero initialisers
 * Fold warnings into main clk.c change

v12:
 * Always refcount, even when enable/prepare ops are NULL
 * Unify prepare & enable count checking
 * Update comments for prepare/unprepare
 * Use spin_{lock,unlock}_irqsave
 * Change clk_put to __clk_put, and use the shared clk_put

v11:
 * add prepare/unprepare for non-atomic switching, document atomicity
 * move to drivers/clk/

v10:
 * comment fixups, from Uwe's review
 * added DEFINE_CLK_FIXED

v9:
 * comment improvements
 * kerneldoc fixups
 * add WARN_ON to clk_disable

v8:
 * add atomic clocks, and locking wrappers
 * expand comments on clk and clk_ops

v7:
 * change CLK_INIT to initialise clk->mutex statically

v6:
 * fixed up references to 'clk_operations' in the changelog

v5:
 * uninline main API, and share definitions with !USE_COMMON_STRUCT_CLK
 * add __clk_get
 * delay mutex init
 * kerneldoc for struct clk

v4:
 * use mutex for enable/disable locking
 * DEFINE_CLK -> INIT_CLK, and pass the clk name for mutex init
 * struct clk_operations -> struct clk_ops

v3:
 * do clock usage refcounting in common code
 * provide sample port

v2:
 * no longer ARM-specific
 * use clk_operations

---
Jeremy Kerr (2):
      Add a common struct clk
      clk: Generic support for fixed-rate clocks
