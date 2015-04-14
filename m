From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 16:52:14 +0100
Subject: [RFC PATCH 3/5] arm64: introduce CPU_OF_TABLES for cpu ops
 selection
In-Reply-To: <3133453.Cys8lc6CAy@wuerfel>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-4-git-send-email-galak@codeaurora.org>
 <3133453.Cys8lc6CAy@wuerfel>
Message-ID: <20150414155214.GJ28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 10:17:06PM +0100, Arnd Bergmann wrote:
> On Thursday 09 April 2015 12:37:09 Kumar Gala wrote:
> > @@ -67,4 +67,9 @@ extern const struct cpu_operations *cpu_ops[NR_CPUS];
> >  int __init cpu_read_ops(struct device_node *dn, int cpu);
> >  void __init cpu_read_bootcpu_ops(void);
> >  
> > +#define CPU_METHOD_OF_DECLARE(name, __ops)                             \
> > +       static const struct cpu_operations *__cpu_method_table_##name   \
> > +       __used __section(__cpu_method_of_table)                         \
> > +       = __ops;
> > +
> >  #endif /* ifndef __ASM_CPU_OPS_H */
> > 
> 
> I'd rather not add this, to avoid giving the appearance that platforms
> can just add another one here.

Likewise.

SMP bringup is always hairy, and giving the appearance that such code
should be hidden away somewhere (and missing critical review) is a bad
idea.

While this seemed like a good idea in the past for 32-bit, we've only
seen marginal decoupling, and very little in the way of actual semantics
defined for the enable-methods. Which effectively spreads implementation
details further rather than separating them from the interface.

Mark.
