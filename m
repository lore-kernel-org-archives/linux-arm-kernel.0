From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 15:38:29 +0100
Subject: [PATCH 3/8] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <87pp8ozwb1.fsf@free.fr>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
 <1425043775-3106827-4-git-send-email-arnd@arndb.de> <87pp8ozwb1.fsf@free.fr>
Message-ID: <356997090.ZkRbrlLqgW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 15:12:02 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

> 
> I'm not sure I understand this patch fully, so take with caution my comment.
> If I'm not mistaken, the former behavior was for pxa3xx:
>  - cpu_is_xscale() -> false
>  - cpu_is_xsc3() -> true
>  => this implied PMD_BIT4 was set
> 
> With your patch :
>  - cpu_is_xscale() -> true
>  - cpu_is_xsc3() -> true
>  => this implied PMD_BIT4 is not set
> 
> I like the new meaning for cpu_is_*(), but is the change of PMD_BIT4 the goal of
> this patch (the piece in [1]) ?

> > -     if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
> > +     if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ &&
> > +         !cpu_is_xscale() && !cpu_is_xsc3())
> >               prot |= PMD_BIT4;
> >  
> >       pgd += pgd_index(addr);

I tried to not change the behavior here, and I think you missed this part:

-#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
+#if !defined(CONFIG_CPU_XSCALE)
 #define        cpu_is_xscale() 0
 #else
-#define        cpu_is_xscale() 1
 ...

This means that previously, cpu_is_xscale() returned true for pxa3xx,
while now it returns false, and I added the "&& !cpu_is_xsc3()" to
keep the logic the same as before.

Does that make sense?

	Arnd
