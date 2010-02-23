From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 22 Feb 2010 21:50:52 -0700
Subject: [PATCH 06/11] OMAP clockdomain: if no autodeps exist,
	don't try to add or remove them
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Message-ID: <20100223045050.18888.84634.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_clkdm_add_autodeps() and _clkdm_del_autodeps() will attempt to dereference
a NULL pointer if no autodeps were supplied to clkdm_init().

Based on a patch from Roel Kluin <roel.kluin@gmail.com> - thanks Roel.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index de4278c..b26d30a 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -173,6 +173,9 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
+	if (!autodeps)
+		return;
+
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
@@ -201,6 +204,9 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
+	if (!autodeps)
+		return;
+
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
