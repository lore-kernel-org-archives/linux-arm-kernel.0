From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 29 Jan 2014 14:31:11 +0900
Subject: [PATCH 1/2] arm64: use num_possible_cpus() instead of NR_CPUS
In-Reply-To: <52E78241.4020502@arm.com>
References: <001d01cf1bc9$452569d0$cf703d70$%han@samsung.com>
 <52E78241.4020502@arm.com>
Message-ID: <001301cf1cb3$51e130b0$f5a39210$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 28, 2014 7:11 PM, Sudeep Holla wrote:
> On 28/01/14 01:35, Jingoo Han wrote:
> > Use num_possible_cpus() instead of direct use of NR_CPUS. Also,
> > it fixes the following checkpatch warning.
> >
> >   WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(),
> for_each_possible_cpu(), etc
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  arch/arm64/kernel/smp.c |   10 +++++-----
> >  arch/arm64/mm/context.c |    2 +-
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 1b7617a..09ff7d4 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -320,7 +320,7 @@ void __init smp_init_cpus(void)
> >  		 * cpu_logical_map was initialized to INVALID_HWID to
> >  		 * avoid matching valid MPIDR values.
> >  		 */
> > -		for (i = 1; (i < cpu) && (i < NR_CPUS); i++) {
> > +		for (i = 1; (i < cpu) && (i < num_possible_cpus()); i++) {
> >  			if (cpu_logical_map(i) == hwid) {
> >  				pr_err("%s: duplicate cpu reg properties in the DT\n",
> >  					dn->full_name);
> > @@ -352,7 +352,7 @@ void __init smp_init_cpus(void)
> >  			continue;
> >  		}
> >
> > -		if (cpu >= NR_CPUS)
> > +		if (cpu >= num_possible_cpus())
> 
> Have you tested this patch ? IIUC this will not work as cpu_possible mask is
> populated completely and correctly only at the end of this function.
> 
> >  			goto next;
> >
> >  		if (cpu_read_ops(dn, cpu) != 0)
> > @@ -368,9 +368,9 @@ next:
> >  	}
> >
> >  	/* sanity check */
> > -	if (cpu > NR_CPUS)
> > +	if (cpu > num_possible_cpus())
> >  		pr_warning("no. of cores (%d) greater than configured maximum of %d - clipping\n",
> > -			   cpu, NR_CPUS);
> > +			   cpu, num_possible_cpus());
> >
> >  	if (!bootcpu_valid) {
> >  		pr_err("DT missing boot CPU MPIDR, not enabling secondaries\n");
> > @@ -381,7 +381,7 @@ next:
> >  	 * All the cpus that made it to the cpu_logical_map have been
> >  	 * validated so set them as possible cpus.
> >  	 */
> > -	for (i = 0; i < NR_CPUS; i++)
> > +	for (i = 0; i < num_possible_cpus(); i++)
> >  		if (cpu_logical_map(i) != INVALID_HWID)
> >  			set_cpu_possible(i, true);
> 
> This is what I am referring above, where is possible mask set before this.
> If it's already populated correctly then we can remove this completely.

OK, you're right.
Please, ignore this patch.
I really appreciate your comment. :-)

Best regards,
Jingoo Han
