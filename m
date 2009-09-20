From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Sun, 20 Sep 2009 23:18:27 +0200
Subject: [PATCH 0/3] Allow Nand and OneNand to coexist
References: <20090920170130.GA19668@mail.gnudd.com>
Message-ID: <cover.1253480933.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three patches are a possible solution to the problem I had with
Nand and OneNand in the nhk-8815.c source file, as described in my
previous RFC post.

The first patch fixes code duplication between nand.h and
bbm.h. Actually, it replicates a fix I made to U-Boot some months ago
for the same reason. Without it, we have the same structure (with the
same name) declared in two different headers.

The second patch unifies nand_state_t and onenand_state_t into
flstate_t. Most states were exactly the same, and no user of those
types is affected by having more states than needed.  This avoid
redefinition errors for FL_READY and similar values. I chose to
keep flstate_t (the NOR one), as it's name is the most generic.

The third, trivial patch, enables OneNand for Nomadik, including both
<linux/mtd/nand.h> and <linux/mtd/onenand.h>, since it's now possible
to do it.

Alessandro Rubini (3):
  mtd: use bbm.h in nand.h
  mtd: unify status enum from three headers
  ARM Nomadik: use new OneNand name and pdata

 arch/arm/mach-nomadik/board-nhk8815.c |   11 ++--
 include/linux/mtd/bbm.h               |   35 ++++++------
 include/linux/mtd/flashchip.h         |    7 +++
 include/linux/mtd/nand.h              |   93 +-------------------------------
 include/linux/mtd/onenand.h           |   19 +------
 5 files changed, 36 insertions(+), 129 deletions(-)
