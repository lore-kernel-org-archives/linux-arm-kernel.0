From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 24 Dec 2014 10:13:28 +1300
Subject: [RFC/PATCHv2 1/5] dtc: Use quotes to include header files
In-Reply-To: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <1419369212-17047-2-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in arch and driver code that needs early access to the
flattened device tree it is necessary to add specific CFLAGS so that
when scripts/dtc/libfdt/libfdt.h is included the C preprocessor is able
to locate the libfdt versions of libfdt_env.h and fdt.h without
generating an error.

We already provide an alternative linux-specific
version of libfdt_env.h and directly include scripts/dtc/libfdt/fdt.h
so the inclusion by scripts/dtc/libfdt/libfdt.h is a no-op thanks to the
inclusion guards.

By using quotes in scripts/dtc/libfdt/libfdt.h it picks up fdt.h and
libfdt_env.h from the source directory without needing to add CFLAGS for
the sources that happen to include linux/libfdt.h.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
For the files that include linux/libfdt.h we currently also have to
specify additional CFLAGS to satisfy the CPP.

  $ git grep '<linux/libfdt.h>'
  arch/mips/cavium-octeon/octeon-platform.c:#include <linux/libfdt.h>
  arch/mips/cavium-octeon/setup.c:#include <linux/libfdt.h>
  arch/mips/mti-sead3/sead3-setup.c:#include <linux/libfdt.h>
  arch/powerpc/kernel/prom.c:#include <linux/libfdt.h>
  drivers/firmware/efi/libstub/fdt.c:#include <linux/libfdt.h>
  drivers/of/fdt.c:#include <linux/libfdt.h>
  drivers/of/fdt_address.c:#include <linux/libfdt.h>

  $ git grep -e '-I.*dtc/libfdt'
  arch/mips/cavium-octeon/Makefile:CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
  arch/mips/cavium-octeon/Makefile:CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
  arch/mips/mti-sead3/Makefile:CFLAGS_sead3-setup.o = -I$(src)/../../../scripts/dtc/libfdt
  arch/powerpc/kernel/Makefile:CFLAGS_prom.o              = -I$(src)/../../../scripts/dtc/libfdt
  drivers/firmware/efi/libstub/Makefile:CFLAGS_fdt.o += -I$(srctree)/scripts/dtc/libfdt/
  drivers/of/Makefile:CFLAGS_fdt.o = -I$(src)/../../scripts/dtc/libfdt
  drivers/of/Makefile:CFLAGS_fdt_address.o = -I$(src)/../../scripts/dtc/libfdt
  lib/Makefile:   $(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))

Simply by switching to using quotes we can avoid having this extra step.

 scripts/dtc/libfdt/libfdt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 73f4975..ea1ddcd 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -51,8 +51,8 @@
  *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <libfdt_env.h>
-#include <fdt.h>
+#include "libfdt_env.h"
+#include "fdt.h"
 
 #define FDT_FIRST_SUPPORTED_VERSION	0x10
 #define FDT_LAST_SUPPORTED_VERSION	0x11
-- 
2.2.0.rc0
