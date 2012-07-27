From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jul 2012 22:40:24 +0100
Subject: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
In-Reply-To: <20120727210637.GA16377@n2100.arm.linux.org.uk>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org>
 <20120625005134.GA2342@S2101-09.ap.freescale.net>
 <20120625084905.GD19226@n2100.arm.linux.org.uk>
 <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com>
 <5012CC98.60206@ti.com>
 <20120727204447.GA10024@mudshark.cambridge.arm.com>
 <20120727210637.GA16377@n2100.arm.linux.org.uk>
Message-ID: <20120727214024.GA10249@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jul 27, 2012 at 10:06:37PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 27, 2012 at 09:44:47PM +0100, Will Deacon wrote:
> > I did comment on this one:
> > 
> >   http://thread.gmane.org/gmane.linux.kernel/1303115
> > 
> > and I really think we should fix the cause of the problem, rather than
> > point patching this instance of it.
> 
> What do you think needs fixing there?

Well, we certainly need to fix the NULL dereference and the original patch
does do that. I just think it might be nicer to remove the possibility of a
NULL dereference instead.

> We support booting a kernel on systems with or without SMP support, even
> with a SMP kernel.  When the kernel is booted on such a system, it is
> undefined whether smp_cross_call() is a valid function pointer.

So let's define it to point at a dummy function which explodes with a BUG if
the cpumask passed in isn't empty. That allows SMP kernels to do things like
`cross call to all other cores' without having to worry about whether there
are any other cores or not.

> In any case, when we have only one CPU online in the system, it is
> pointless even calling smp_cross_call().

Pointless, but also error-prone and requiring explicit cpumask checks at
each call-site.

> That is why I explicitly suggested this solution.  This is the solution
> _I_ want, because it is the most sane solution all round.

Adding a dummy implementation is straightforward [ok, this is untested]:


diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 2c7217d..ffa411f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -329,7 +329,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
        }
 }
 
-static void (*smp_cross_call)(const struct cpumask *, unsigned int);
+static void dummy_smp_cross_call(const struct cpumask *mask, unsigned int irq)
+{
+       BUG_ON(!cpumask_empty(mask));
+}
+
+static void (*smp_cross_call)(const struct cpumask *, unsigned int) =
+       dummy_smp_cross_call;
 
 void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
 {


If you still prefer checking at the call-site then the original patch will
certainly work. Otherwise, I'm happy to submit the above after some testing.

Will
