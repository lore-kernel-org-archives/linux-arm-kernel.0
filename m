From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Jul 2017 10:42:19 +0100
Subject: prefetch inconsistency in copy_page()
Message-ID: <CAKv+Gu9hGwLJxBCMCTK2fsK31SgX7E=qc3PQcNXZA6OP2uUs8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

No big deal, but I spotted an inconsistency in how copy_page() does
its prefetching. With the code as-is, it prefetches 2 lines at the
start of the function, but it is off by one line in the loop, i.e., it
prefetches 3 lines ahead (and skips a line at entry). So imo, we need
either

"""
@@ -30,9 +30,10 @@
  */
 ENTRY(copy_page)
 alternative_if ARM64_HAS_NO_HW_PREFETCH
-       # Prefetch two cache lines ahead.
+       # Prefetch three cache lines ahead.
        prfm    pldl1strm, [x1, #128]
        prfm    pldl1strm, [x1, #256]
+       prfm    pldl1strm, [x1, #384]
 alternative_else_nop_endif

        ldp     x2, x3, [x1]
"""

or

"""
@@ -50,7 +51,7 @@ alternative_else_nop_endif
        subs    x18, x18, #128

 alternative_if ARM64_HAS_NO_HW_PREFETCH
-       prfm    pldl1strm, [x1, #384]
+       prfm    pldl1strm, [x1, #256]
 alternative_else_nop_endif

        stnp    x2, x3, [x0]

"""

to make things consistent again.

Thoughts?

-- 
Ard.
