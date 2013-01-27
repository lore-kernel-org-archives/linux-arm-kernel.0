From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 09:59:26 +0100
Subject: [PATCH v2 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <CAKohpok1w2RB1ncyNTcd04XTNFfnq_S98YEcxNjpWGWMVA7TaQ@mail.gmail.com>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
 <1359215039-2848-2-git-send-email-andrew@lunn.ch>
 <CAKohpok1w2RB1ncyNTcd04XTNFfnq_S98YEcxNjpWGWMVA7TaQ@mail.gmail.com>
Message-ID: <20130127085926.GH29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 09:21:42AM +0530, Viresh Kumar wrote:
> Hi Andrew,
> 
> Few more comments from my side :(

No problems...

> 
> On 26 January 2013 21:13, Andrew Lunn <andrew@lunn.ch> wrote:
> > diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <asm/proc-fns.h>
> > +
> > +#define CPU_SW_INT_BLK BIT(28)
> > +
> > +
> > +#include <linux/clk-private.h>
> 
> Any specific reason for keeping it together with other #includes?

Ah, yes, there is a good reason. I added this in for debugging
purposes. I needed to look inside the clk cookie, which required this
include file. But because it was for debug only, to be removed later,
i kept it separate, easier to find and remove. I just forgot to remove
it :-(

> > +       if (freqs.old != freqs.new) {
> > +               local_irq_disable();
> > +
> > +               /* Disable interrupts to the CPU */
> > +               reg = readl_relaxed(priv.base);
> > +               reg |= CPU_SW_INT_BLK;
> > +               writel(reg, priv.base);
> > +static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
> > +                           unsigned int target_freq,
> > +                           unsigned int relation)
> > +{
> > +       unsigned int index = 0;
> > +
> > +       if (cpufreq_frequency_table_target(policy, kirkwood_freq_table,
> > +                               target_freq, relation, &index))
> > +               return -EINVAL;
> > +
> > +       kirkwood_cpufreq_set_cpu_state(index);
> 
> This routine does have error cases, like: wrong value of "state"
> variable, so returning int from it might make sense. Though i believe
> state can't be anything else then STATE_CPU_FREQ or STATE_DDR_FREQ.
> In which case, switch must be modified?

As you say, state cannot be anything else that the two expected
values. I've just been taught that switch statements should always
have a default clause. I also thought that a BUG() is too strong, no
need to kill the machine. It is better to spam the kernel log so it
gets noticed. I can swap to a WARN_ON(1). I don't really think this is
an error that needs to be reported back to the framework. Its an
implementation problem, not a runtime problem. So i would prefer to
keep to void.

> > +static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > +       return 0;
> > +}
> 
> Hmm.. Exit is normally called in two cases. Either cpufreq driver is
> unregistered
> or cpu is removed. In that case i am not sure if this routine makes sense? As
> we have a uniprocessor SoC here.

The current Kconfig entry does not allow it to be compiled as a
module. But the code does allow for it. With the current trend of
making the ARM kernel multiplatform, its likely that cpufreq drivers
will become modular so that only the appropriate driver gets loaded in
a multiplatform kernel. The question then becomes, is it O.K. not
being able to unload the module?

      Andrew
