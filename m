From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 16:42:12 +0100
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
Message-ID: <20130127154212.GJ29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 08:19:56PM +0530, Viresh Kumar wrote:
> On 27 January 2013 15:37, Andrew Lunn <andrew@lunn.ch> wrote:
> > diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> > +static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
> > +{
> 
> > +       if (freqs.old != freqs.new) {
> 
> > +               switch (state) {
> > +               case STATE_CPU_FREQ:
> > +                       clk_disable(priv.powersave_clk);
> > +                       break;
> > +               case STATE_DDR_FREQ:
> > +                       clk_enable(priv.powersave_clk);
> > +                       break;
> > +               default:
> > +                       WARN_ON(1);
> 
> I still don't feel this case is required :)

O.K, i will take it out.

> > +static struct platform_driver kirkwood_cpufreq_platform_driver = {
> > +       .probe = kirkwood_cpufreq_probe,
> > +       .remove = kirkwood_cpufreq_remove,
> > +       .driver = {
> > +               .name = "kirkwood-cpufreq",
> > +               .owner = THIS_MODULE,
> > +       },
> > +};
> 
> Two things. Any reason why you created an extra layer of platform_driver?
> You could have called cpufreq_probe/remove (with names modified) from
> module init/exit.

And how would the module get loaded? There is no hardware anchor to
make the module load. No enumeration of some bus causing it to be
loaded. In the ARM world, platform drivers are the norm.

	Andrew
