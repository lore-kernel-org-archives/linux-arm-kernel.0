From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 19:06:44 +0800
Subject: [PATCH] ARM: cpuidle: declare cpuidle_ops __read_mostly
In-Reply-To: <8191851.HcPOqTYLq8@wuerfel>
References: <1470818997-808-1-git-send-email-jszhang@marvell.com>
 <2118361.tr3K3hSZxF@wuerfel>	<20160810171926.44557e35@xhacker>
 <8191851.HcPOqTYLq8@wuerfel>
Message-ID: <20160810190644.68966492@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Wed, 10 Aug 2016 12:47:21 +0200 Arnd Bergmann wrote:

> On Wednesday, August 10, 2016 5:19:26 PM CEST Jisheng Zhang wrote:
> > Dear Arnd,
> > 
> > On Wed, 10 Aug 2016 10:57:57 +0200 Arnd Bergmann wrote:
> >   
> > > On Wednesday, August 10, 2016 4:49:57 PM CEST Jisheng Zhang wrote:  
> > > > diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> > > > index 7dccc96..762e0929 100644
> > > > --- a/arch/arm/kernel/cpuidle.c
> > > > +++ b/arch/arm/kernel/cpuidle.c
> > > > @@ -19,7 +19,7 @@ extern struct of_cpuidle_method __cpuidle_method_of_table[];
> > > >  static const struct of_cpuidle_method __cpuidle_method_of_table_sentinel
> > > >         __used __section(__cpuidle_method_of_table_end);
> > > >  
> > > > -static struct cpuidle_ops cpuidle_ops[NR_CPUS];
> > > > +static struct cpuidle_ops cpuidle_ops[NR_CPUS] __read_mostly;    
> > > 
> > > Should this perhaps be percpu data instead?
> > >   
> > 
> > Per my understanding, percpu is used for those vars with normal read/write
> > frequency, while the cpuidle_ops is read mostly, so IMHO, __read_mostly
> > is suitable, what do you think?  
> 
> You are right, __read_mostly is better than the normal .data section here,
> but percpu is also better than .data because it saves a little memory
> on machines that have few present CPUs than CONFIG_NR_CPUS.
> 
> So both have their advantages, we just need to pick a preference.
> 
> Actually __ro_after_init would be even better than __read_mostly here
> I think, as this is only updated in an __init function. I guess
> using that would have the added security advantage of preventing
> an attacker from writing to the function pointers when they
> find a way to overflow an access in the percpu data section.
> 

Got it, thanks for the detailed explanations. 

And I think the answer to questions:

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448057.html

and

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448059.html

are both "yes"

Thanks,
Jisheng
