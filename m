From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 11:49:50 +0000
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <CAKohpok7aD-J-undUisxaOotbXWimPo46jqOH4ok04kg_hMWHA@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
 <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
 <20130307005119.GY17833@n2100.arm.linux.org.uk>
 <CAKohpok7aD-J-undUisxaOotbXWimPo46jqOH4ok04kg_hMWHA@mail.gmail.com>
Message-ID: <20130307114950.GF17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:03:28AM +0800, Viresh Kumar wrote:
> On 7 March 2013 08:51, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Thu, Mar 07, 2013 at 08:32:37AM +0800, Viresh Kumar wrote:
> >> On 5 March 2013 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> >> > On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
> >> >> +     clk[cluster] = clk_get(NULL, name);
> >> >> +     if (!IS_ERR_OR_NULL(clk[cluster])) {
> >> >
> >> > NAK.  Two reasons.
> >> >
> >> > 1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
> >> >    times.
> >>
> >> Hey, i had a second thought about this one and i have some other opinion
> >> here. This is a cpufreq driver and we need clock support for sure here, we
> >> can't work without it. And so here is the latest fixup:
> >
> > NAK.  You just don't understand.
> 
> Poor me!!
> 
> I still remember the huge discussions we had during "clk: Add non
> CONFIG_HAVE_CLK routines" patchset.
> 
> For others: https://lkml.org/lkml/2012/4/24/389
> 
> Back to the discussion, I understand that clk_get() just returns a cookie and
> NULL is not an error and so it shouldn't be treated specially. And that's what
> we do with most of our drivers as all other clk routines (clk_get[set]_rate())
> have safe guards against the NULL clk, and they wouldn't complain.
> 
> The special case we have in a cpufreq driver is, we can't work with
> zero returned
> from clk_get_rate()... That will make cpufreq driver work badly.

So how is this different from any other clock which may also return zero
from its clk_get_rate() ?

If that's the condition you want to check for, call clk_get_rate() after
a successful clk_get*() and check for the condition.  Don't go treating
the cookie somehow specially.  You're *assuming* a behaviour that is
inappropriate for the side of the interface you're working with.
