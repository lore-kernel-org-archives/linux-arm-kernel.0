From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 16:14:06 +0100
Subject: [PATCH] sched/rt: hide push_irq_work_func declaration
In-Reply-To: <20151112094739.0168e191@gandalf.local.home>
References: <3810009.VdDTV0h1Qp@wuerfel>
 <20151112094739.0168e191@gandalf.local.home>
Message-ID: <4129441.9nXLnMzV6v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 09:47:39 Steven Rostedt wrote:
> > -#ifdef CONFIG_SMP
> > +#if IS_ENABLED(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
> 
> Why IS_ENABLED() and not defined()?
>
> #if defined(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
> 
> I thought IS_ENABLED() is used for C code, like:
> 
>         if (IS_ENABLED(CONFIG_SMP)) {
>                 [...]
>         }

"#if IS_ENABLED(CONFIG_foo)" has another property, which is
to evaluate to true when Kconfig has set the symbol to "=m".
Obviously that cannot happen for CONFIG_SMP, but some
maintainers prefer using IS_ENABLED() consistently for all
config symbols.

I don't care much either way, and it's easily changed if
we still want the patch and you prefer a plain #if defined().

	Arnd
