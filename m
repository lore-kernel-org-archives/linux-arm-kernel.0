From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Feb 2012 11:38:14 +0100
Subject: [PATCH] ARM/sp810: introduce API to change system mode
In-Reply-To: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
References: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
Message-ID: <CACRpkdaG2e12fdCFDUoQ_n71VcqU3ZpkH0raHW+EAZg==JOxrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 10:13 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> sp810 controller can change system's working mode to various power save
> states. Introduce an API to accomplish the same.

OK...

> +static inline int sysctl_change_mode(void __iomem *base, int mode)

Why do you make this a static inline?

And why is the present soft reset code also static inlined?

When I look at how this is used in arch/arm/mach-vexpress/v2m.c
it's apparently glued back-to-back with the SP804
so I think it should be some CONFIG_HAS_SP810
and put directly into common/timer-sp.c.

#ifdef CONFIG_HAS_SP810

/* Put SP810 specific support functions here */

void __init sp810_clockevents_init(void __iomem *sp804_base, void
__iomem *sp810_base, unsigned int irq, const char *name)
{
  /* Do some SP810 magic stuff */
  /* Calls sp804_clockevents_init() */
}

#endif

Maybe I'm delusional but I think this could help centralizing the use
of the SP* cells, since they're obviously used in both SPEAr and
versatile express.

Yours,
Linus Walleij
