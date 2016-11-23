From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Nov 2016 20:35:48 -0500 (EST)
Subject: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
In-Reply-To: <20161123120436.18dc21e7@roar.ozlabs.ibm.com>
References: <20161122110557.1533467-1-arnd@arndb.de>
 <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
 <20161123120436.18dc21e7@roar.ozlabs.ibm.com>
Message-ID: <alpine.LFD.2.20.1611222030050.1814@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Nov 2016, Nicholas Piggin wrote:

> On Tue, 22 Nov 2016 11:34:48 -0500 (EST)
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
> > On Tue, 22 Nov 2016, Arnd Bergmann wrote:
> > 
> > > This adds an asm/asm-prototypes.h header for ARM to fix the broken symbol
> > > versioning for symbols exported from assembler files.
> > > 
> > > I couldn't find the correct prototypes for the compiler builtins,
> > > so I went with the fake 'void f(void)' prototypes that we had
> > > before, restoring the state before they were moved.
> > > 
> > > Originally I assumed that the problem was just a harmless warning
> > > in unusual configurations, but as Uwe found, we actually need this
> > > to load most modules when symbol versioning is enabled, as it is
> > > in many distro kernels.
> > > 
> > > Cc: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> > > Fixes: 4dd1837d7589 ("arm: move exports to definitions")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > Compared to the earlier version, I dropped the changes to the
> > > csumpartial files, which now get handled correctly by Kbuild
> > > even when the export comes from a macro, and I also dropped the
> > > changes to the bitops files, which were already fixed in a
> > > patch from Nico.
> > > 
> > > The patch applies cleanly on top of the rmk/fixes tree but has
> > > no effect there, as it also needs 4efca4ed05cb ("kbuild: modversions
> > > for EXPORT_SYMBOL() for asm") and cc6acc11cad1 ("kbuild: be more
> > > careful about matching preprocessed asm ___EXPORT_SYMBOL").
> > > 
> > > With the combination of rmk/fixes, torvalds/master and these two
> > > patches, symbol versioning works again on ARM. As it is still
> > > broken on almost all other architectures (powerpc is fixed,
> > > x86 has a patch), I wonder if we should make CONFIG_MODVERSIONS
> > > as broken for everything else.  
> > 
> > I'm not sure I like this at all.
> > 
> > The goal for moving EXPORT_SYMBOL() to assembly code where symbols were 
> > defined is to make things close together and avoid those centralized 
> > list of symbols that you can easily miss when modifying the actual code.
> 
> Right.
> 
> > 
> > This series is therefore bringing back a centralized list of symbols in 
> > a slightly different form, nullifying the advantages from having moved 
> > EXPORT_SYMBOL() to asm code.  To me this looks like a big step backward.
> 
> Exported symbols have C declarations in headers already. For the most
> part, anyway -- these ones Arnd adds are for compiler runtime which is
> why some architectures haven't had the prototypes.

Hmmm. That's right.  That makes it much more justifiable.
My main objection is withdrawn.

However there is a bunch of includes added to asm-prototypes.h:

+#include <linux/arm-smccc.h>
+#include <linux/bitops.h>
+#include <linux/ftrace.h>
+#include <linux/io.h>
+#include <linux/platform_data/asoc-imx-ssi.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <asm/checksum.h>
+#include <asm/div64.h>
+#include <asm/memory.h>

Are those necessary at all?


Nicolas
