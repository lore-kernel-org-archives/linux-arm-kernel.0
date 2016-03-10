From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 10 Mar 2016 14:56:46 +0000
Subject: [PATCH] bus: arm-ccn: Fix cpu notifier priority
In-Reply-To: <20160310143455.GA9998@hardcore>
References: <1457439273-5998-1-git-send-email-jglauber@cavium.com>
 <1457512845.22102.113.camel@arm.com> <20160310143455.GA9998@hardcore>
Message-ID: <1457621806.22102.142.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-03-10 at 15:34 +0100, Jan Glauber wrote:
> On Wed, Mar 09, 2016 at 08:40:45AM +0000, Pawel Moll wrote:
> > On Tue, 2016-03-08 at 13:14 +0100, Jan Glauber wrote:
> > > Fix cpu priority of notifier block that was erroneously set to
> > > return value of next statement.
> > > 
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > > ---
> > >  drivers/bus/arm-ccn.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> > > index 7082c72..d4a939e 100644
> > > --- a/drivers/bus/arm-ccn.c
> > > +++ b/drivers/bus/arm-ccn.c
> > > @@ -1271,7 +1271,7 @@ static int arm_ccn_pmu_init(struct arm_ccn
> > > *ccn)
> > >  	 * picked to have a chance to migrate events before perf
> > > is
> > > notified.
> > >  	 */
> > >  	ccn->dt.cpu_nb.notifier_call = arm_ccn_pmu_cpu_notifier;
> > > -	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1,
> > > +	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1;
> > >  	err = register_cpu_notifier(&ccn->dt.cpu_nb);
> > >  	if (err)
> > >  		goto error_cpu_notifier;
> > 
> > Damn, of course! I have never made (or heard about) such a typo
> > before 
> > - I wish the compiler warned about it :-(
> 
> actually my patch description is wrong. The compiler evaluates both
> statements but does _not_ overwrite the value of the first statement
> (would require parenthesis to do so).

I must admit I looked at the code change rather than at the
description, but thinking about it now, comma has the lowest
precedence, so the assignments will win. Still, with gcc 6 now warning
about suspicious indentations, my wish still stays a wish ;-)

>  So it is just a cosmetical change, feel free to drop it.

Oh no, it's still a bug (only maybe not a "stable-class" one). And one
I'll remember :-) 

Thanks!

Pawel
