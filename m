From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 13:53:14 +0100
Subject: [PATCH] pinctrl/nomadik: allocate IRQ descriptors dynamically
In-Reply-To: <1348679887-2135-1-git-send-email-linus.walleij@stericsson.com>
References: <1348679887-2135-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120927125314.GD14358@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 07:18:07PM +0200, Linus Walleij wrote:
> +	irq_start = NOMADIK_GPIO_TO_IRQ(pdata->first_gpio);
> +	irq_base = irq_alloc_descs(irq_start, 0, NMK_GPIO_PER_CHIP,
> +				   numa_node_id());
> +	if (IS_ERR_VALUE(irq_base)) {

commit 07ab67c8d0d7c1021343b7d5c045033d6bf7be69
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Thu May 19 22:43:37 2005 -0700

    Fix get_unmapped_area sanity tests

    As noted by Chris Wright, we need to do the full range of tests regardless
    of whether MAP_FIXED is set or not, so re-organize get_unmapped_area()
    slightly to do the sanity checks unconditionally.

diff --git a/include/linux/err.h b/include/linux/err.h
index 17c55df..ff71d2a 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -13,6 +13,8 @@
  * This should be a per-architecture thing, to allow different
  * error and pointer decisions.
  */
+#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)

This is because get_unmapped_area() can return negative numbers which are
not error codes.

My position on this is that IS_ERR_VALUE() should only be used for checking
the return value of a function where some negative numbers are not error
codes, and everywhere else should use "ret < 0".

Just because we have a funky macro is no reason to blindly (ab)use it.
