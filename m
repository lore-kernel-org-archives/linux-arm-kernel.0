From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 30 Mar 2016 15:16:29 +0800
Subject: [PATCH 1/2] ARM: cpuidle: fix !cpuidle_ops[cpu].init case
 during init
In-Reply-To: <56F52502.3060308@linaro.org>
References: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
 <1458796269-6158-2-git-send-email-jszhang@marvell.com>
 <56F52502.3060308@linaro.org>
Message-ID: <20160330151629.0b338365@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 25 Mar 2016 12:46:10 +0100 Daniel Lezcano wrote:

> On 03/24/2016 06:11 AM, Jisheng Zhang wrote:
> > Let's assume cpuidle_ops exists but it doesn't implement the according
> > init member, current arm_cpuidle_init() will return success to its
> > caller, but in fact it should return -EOPNOTSUPP.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >   arch/arm/kernel/cpuidle.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> > index 703926e..f108d8f 100644
> > --- a/arch/arm/kernel/cpuidle.c
> > +++ b/arch/arm/kernel/cpuidle.c
> > @@ -143,8 +143,12 @@ int __init arm_cpuidle_init(int cpu)
> >   		return -ENODEV;
> >
> >   	ret = arm_cpuidle_read_ops(cpu_node, cpu);
> > -	if (!ret && cpuidle_ops[cpu].init)
> > -		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
> > +	if (!ret) {
> > +		if (cpuidle_ops[cpu].init)
> > +			ret = cpuidle_ops[cpu].init(cpu_node, cpu);
> > +		else
> > +			ret = -EOPNOTSUPP;
> > +	}  
> 
> Hi Jisheng,
> 
> this should be handled in the arm_cpuidle_read_ops function.
> 

Thanks for reviewing. After some consideration, I think this patch isn't correct
There may be platforms which doesn't need the init member at all, although
currently I don't see such platforms in mainline, So I'll drop this patch
and send out one v2 only does the optimization.

Thanks a lot,
Jisheng
