From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Oct 2010 12:07:06 +0200
Subject: [PATCHv3] cpufreq for freescale mx51
In-Reply-To: <AANLkTik=UWF0PpAUKGE3KwmJbZNgxUj-8o6ouD+LYcSx@mail.gmail.com>
References: <1287390105-3706-1-git-send-email-yong.shen@linaro.org>
	<20101018101314.GA4395@pengutronix.de>
	<AANLkTik=UWF0PpAUKGE3KwmJbZNgxUj-8o6ouD+LYcSx@mail.gmail.com>
Message-ID: <20101019100706.GR28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 05:28:51PM +0800, Yong Shen wrote:
> >
> >
> >
> > > +#include <linux/kernel.h>
> > > +
> > > +static struct cpu_op mx51_cpu_op[] = {
> > > +     {
> > > +     .cpu_rate = 160000000,},
> > > +     {
> > > +     .cpu_rate = 800000000,},
> > > +};
> >
> > Why did you remove the values between 800MHz and 160MHz? 400MHz and
> > 200Mhz should work also, no?
> >
> > It proved that those operating points don't work well.

ok

> > > +static struct cpu_op *cpu_op_tbl;
> > > +
> > > +static int set_cpu_freq(int freq)
> > > +{
> > > +     int ret = 0;
> > > +     int org_cpu_rate;
> > > +
> > > +     org_cpu_rate = clk_get_rate(cpu_clk);
> > > +     if (org_cpu_rate == freq)
> > > +             return ret;
> >
> > You already checked this in mxc_set_target. Once is enough.
> >
> 
> Well, this fucntion is not only used in mxc_set_target, so it is safer to
> still keep checking here.

Then you can skip the check in the calling function.

> > > +
> > > +static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
> > > +{
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     printk(KERN_INFO "i.MXC CPU frequency driver\n");
> > > +
> > > +     if (policy->cpu != 0)
> > > +             return -EINVAL;
> > > +
> > > +     cpu_clk = clk_get(NULL, "cpu_clk");
> > > +     if (IS_ERR(cpu_clk)) {
> > > +             printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
> > > +             return PTR_ERR(cpu_clk);
> > > +     }
> > > +
> > > +     cpu_op_tbl = get_cpu_op(&cpu_op_nr);
> >
> > This will crash every board except the babbage board which happens to
> > set this function pointer.
> >
> Add a checking here should avoid that.

indeed

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
