From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Apr 2015 12:58:33 +0100
Subject: [PATCH V2] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <552E40F6.1010504@arm.com>
References: <20150409144029.GE9648@leverpostej>
 <1428591425-17330-1-git-send-email-msalter@redhat.com>
 <552E40F6.1010504@arm.com>
Message-ID: <20150415115833.GB18864@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 11:44:06AM +0100, Suzuki K. Poulose wrote:
> On 09/04/15 15:57, Mark Salter wrote:
> > Currently in validate_group(), there is a static initializer
> > for fake_pmu.used_mask which is based on CPU_BITS_NONE but
> > the used_mask array size is based on CCI_PMU_MAX_HW_EVENTS.
> > CCI_PMU_MAX_HW_EVENTS is not based on NR_CPUS, so CPU_BITS_NONE
> > is not correct and will cause a build failure if NR_CPUS
> > is set high enough to make CPU_BITS_NONE larger than used_mask.
> >
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > ---
> >   drivers/bus/arm-cci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > index 84fd660..759e41c 100644
> > --- a/drivers/bus/arm-cci.c
> > +++ b/drivers/bus/arm-cci.c
> > @@ -684,7 +684,7 @@ validate_group(struct perf_event *event)
> >   		 * Initialise the fake PMU. We only need to populate the
> >   		 * used_mask for the purposes of validation.
> >   		 */
> > -		.used_mask = CPU_BITS_NONE,
> > +		.used_mask = { 0 },
> >   	};
> >
> >   	if (!validate_event(&fake_pmu, leader))
> >
> I have a series of patches to add CCI-500 PMU, targeting 4.2, which 
> changes the used_mask to a pointer and changes it to depend on the 
> number of counters available on the CCI PMU.  I will post it in very 
> soon here, which could make this patch obsolete. Let me know if you 
> don't mind getting this sorted out through my series. I am fine either way.

I'd rather have the fix in for 4.1 and then have your CCI-500 patches based
on that.

Will
