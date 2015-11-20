From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 12:19:43 +0000
Subject: [PATCH v11 4/5] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <20151117173557.GN30101@arm.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1511101410550.5676@kaball.uk.xensource.com>
 <20151117172914.GL30101@arm.com> <564B652C.8060409@arm.com>
 <20151117173557.GN30101@arm.com>
Message-ID: <alpine.DEB.2.02.1511201212190.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, Will Deacon wrote:
> On Tue, Nov 17, 2015 at 05:34:36PM +0000, Marc Zyngier wrote:
> > On 17/11/15 17:29, Will Deacon wrote:
> > > On Tue, Nov 10, 2015 at 02:11:38PM +0000, Stefano Stabellini wrote:
> > >> On Thu, 5 Nov 2015, Stefano Stabellini wrote:
> > >>> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
> > >>> Necessary duplication of paravirt.h and paravirt.c with ARM.
> > >>>
> > >>> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> > >>> runtime pvops patching needed.
> > >>>
> > >>> This allows us to make use of steal_account_process_tick for stolen
> > >>> ticks accounting.
> > >>>
> > >>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > >>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > >>
> > >> Ping?
> > >>
> > >> Catalin, Will,
> > >> are you happy with this change?
> > > 
> > > I'm happy if Marc's happy. Marc?
> > 
> > My Ack is already on the tin! ;-)
> 
> Ah yes, I only saw the cc line. In which case, I assume Stefano will
> take this via the xen tree.

Unfortunately I am still missing Russell's ack on the arm patch (3/5).

Would you be OK if I dropped stolen time support for arm, only keeping
the arm64 part? The price to pay is two small ifdefs in arch/arm/xen/enlighten.c:

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 15621b1..87e2fec 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -16,7 +16,9 @@
 #include <asm/xen/hypercall.h>
 #include <asm/arch_timer.h>
 #include <asm/system_misc.h>
+#ifdef ARM64
 #include <asm/paravirt.h>
+#endif
 #include <linux/jump_label.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
@@ -289,9 +291,10 @@ static int __init xen_guest_init(void)
 
 	register_cpu_notifier(&xen_cpu_notifier);
 
+#ifdef ARM64
 	pv_time_ops.steal_clock = xen_stolen_accounting;
 	static_key_slow_inc(&paravirt_steal_enabled);
-
+#endif
 	return 0;
 }
 early_initcall(xen_guest_init);
