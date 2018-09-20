From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Sep 2018 10:21:29 +0100
Subject: [PATCH 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
In-Reply-To: <1d5260c4-6d4f-a6c9-210e-25b8aeda1bde@arm.com>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <E1g2Z6e-0003es-CI@rmk-PC.armlinux.org.uk>
 <1d5260c4-6d4f-a6c9-210e-25b8aeda1bde@arm.com>
Message-ID: <20180920092129.GJ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 10:04:44AM +0100, Julien Thierry wrote:
> Hi Russell,
> 
> On 19/09/18 10:49, Russell King wrote:
> >In big.Little systems, some CPUs require the Spectre workarounds in
> >paths such as the context switch, but other CPUs do not.  In order
> >to handle these differences, we need per-CPU vtables.
> >
> >We are unable to use the kernel's per-CPU variables to support this
> >as per-CPU is not initialised at times when we need access to the
> >vtables, so we have to use an array indexed by logical CPU number.
> >
> >Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >---
> >  arch/arm/include/asm/proc-fns.h | 14 ++++++++++++++
> >  arch/arm/kernel/setup.c         |  5 +++++
> >  arch/arm/kernel/smp.c           | 31 +++++++++++++++++++++++++++++++
> >  arch/arm/mm/proc-v7-bugs.c      | 17 ++---------------
> >  4 files changed, 52 insertions(+), 15 deletions(-)
> >
> >diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> >index 571a1346245b..ddbb25cb8968 100644
> >--- a/arch/arm/include/asm/proc-fns.h
> >+++ b/arch/arm/include/asm/proc-fns.h
> >@@ -104,11 +104,25 @@ extern void cpu_do_resume(void *);
> >  #else
> >  extern struct processor processor;
> >+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> >+#include <linux/smp.h>
> >+/*
> >+ * This can't be a per-cpu variable because we need to access it before
> >+ * per-cpu has been initialised.
> >+ */
> >+extern struct processor *cpu_vtable[];
> >+#define PROC_VTABLE(f)			cpu_vtable[smp_processor_id()]->f
> >+static inline void init_proc_vtable(const struct processor *p)
> >+{
> >+	*cpu_vtable[smp_processor_id()] = *p;
> >+}
> 
> As you stated, 32-bit ARM can only have up to 8 logical CPUs. So, do we save
> much by having an added level of indirection? (i.e. having a table of
> pointers instead of directly having a table of struct processor)

Yes we do - in a word, security.

If we made this a table of struct processor, because it is written to
after boot, it would need to be writable for the lifetime of the kernel.
Since it is in the kernel's static data section, it will be at a well-
known offset, which means it's a target for attackers to change the
function pointers.

Exactly this was true of the 'processor' variable, which gained a
__ro_after_init annotation a while back - and going to a table of
struct processor would mean that we end up back in that situation.

Having a table of pointers to struct processor means there is an
additional level of complexity for attackers to get around - they would
first need to copy an existing table, change its contents, and then
change the appropriate CPU's cpu_vtable pointer to point to their table.
Having a table of struct processor just means an attacker would only
need to poke one 32-bit word in the array for the appropriate CPU to
gain control.

So yes, this is slightly more complex, but it's that way to avoid
undoing the benefits that have previously been gained through
facilities such as read-only data after kernel initialisation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
