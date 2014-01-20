From: jean.pihet@linaro.org (Jean Pihet)
Date: Mon, 20 Jan 2014 22:22:02 +0100
Subject: [PATCH 3/3] Dwarf: unwind the recorded stack frame of different
 target address sizes
In-Reply-To: <1390252922-25889-1-git-send-email-jean.pihet@linaro.org>
References: <1390252922-25889-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <1390252922-25889-4-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When in compat mode, correctly unwind the recorded stack frame. The
returned pointers are cast to the desired target address size.

Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
---
 src/dwarf/Gparser.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/dwarf/Gparser.c b/src/dwarf/Gparser.c
index b251e31..d676861 100644
--- a/src/dwarf/Gparser.c
+++ b/src/dwarf/Gparser.c
@@ -706,6 +706,29 @@ eval_location_expr (struct dwarf_cursor *c, unw_addr_space_t as,
   return 0;
 }
 
+/* Cast pointer content to the type of target address size */
+static inline int cast_value_to_addr_size(unw_word_t *val, int addr_size)
+{
+    switch (addr_size) {
+    /*
+     * Return the value of the type found at binary load time (e.g. from the
+     * ELF format)...
+     */
+    case TARGET_ADDR_SIZE_32:
+	*val = (uint32_t) *val;
+	break;
+    case TARGET_ADDR_SIZE_64:
+	*val = (uint64_t) *val;
+	break;
+    /* ... otherwise leave it as is */
+    case TARGET_ADDR_SIZE_DEFAULT:
+    default:
+	break;
+    }
+
+    return 0;
+}
+
 static int
 apply_reg_state (struct dwarf_cursor *c, struct dwarf_reg_state *rs)
 {
@@ -743,6 +766,8 @@ apply_reg_state (struct dwarf_cursor *c, struct dwarf_reg_state *rs)
 	  regnum = dwarf_to_unw_regnum (rs->reg[DWARF_CFA_REG_COLUMN].val);
 	  if ((ret = unw_get_reg ((unw_cursor_t *) c, regnum, &cfa)) < 0)
 	    return ret;
+	  /* Cast value to the type as found in the ELF binary format */
+	  cast_value_to_addr_size(&cfa, as->target_addr_size);
 	}
       cfa += rs->reg[DWARF_CFA_OFF_COLUMN].val;
     }
@@ -797,6 +822,8 @@ apply_reg_state (struct dwarf_cursor *c, struct dwarf_reg_state *rs)
     ret = dwarf_get (c, c->loc[c->ret_addr_column], &ip);
     if (ret < 0)
       return ret;
+    /* Cast value to the type as found in the ELF binary format */
+    cast_value_to_addr_size(&ip, as->target_addr_size);
     c->ip = ip;
   }
 
-- 
1.7.11.7
