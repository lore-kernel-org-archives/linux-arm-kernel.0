From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun,  1 Jul 2018 18:20:57 +0200
Subject: [PATCH 4.17 033/220] lib/vsprintf: Remove atomic-unsafe support for
 %pCr
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
Message-ID: <20180701160909.718293393@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 666902e42fd8344b923c02dc5b0f37948ff4f225 upstream.

"%pCr" formats the current rate of a clock, and calls clk_get_rate().
The latter obtains a mutex, hence it must not be called from atomic
context.

Remove support for this rarely-used format, as vsprintf() (and e.g.
printk()) must be callable from any context.

Any remaining out-of-tree users will start seeing the clock's name
printed instead of its rate.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: 900cca2944254edd ("lib/vsprintf: add %pC{,n,r} format specifiers for clocks")
Link: http://lkml.kernel.org/r/1527845302-12159-5-git-send-email-geert+renesas at glider.be
To: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>
To: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc at vger.kernel.org
Cc: linux-clk at vger.kernel.org
Cc: linux-pm at vger.kernel.org
Cc: linux-serial at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable at vger.kernel.org # 4.1+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/core-api/printk-formats.rst |    3 +--
 lib/vsprintf.c                            |    3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -419,11 +419,10 @@ struct clk
 
 	%pC	pll1
 	%pCn	pll1
-	%pCr	1560000000
 
 For printing struct clk structures. %pC and %pCn print the name
 (Common Clock Framework) or address (legacy clock framework) of the
-structure; %pCr prints the current clock rate.
+structure.
 
 Passed by reference.
 
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1456,9 +1456,6 @@ char *clock(char *buf, char *end, struct
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
-	case 'r':
-		return number(buf, end, clk_get_rate(clk), spec);
-
 	case 'n':
 	default:
 #ifdef CONFIG_COMMON_CLK
