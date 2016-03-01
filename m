From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 1 Mar 2016 16:10:34 +0100
Subject: [PATCH v4 4/5] arm64/perf: Enable PMCR long cycle counter bit
In-Reply-To: <20160229153934.GB14848@arm.com>
References: <cover.1455810755.git.jglauber@cavium.com>
 <467597048eda3004bd69f1fbe3981aab111e00dd.1455810755.git.jglauber@cavium.com>
 <20160229153934.GB14848@arm.com>
Message-ID: <20160301151034.GA8514@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 03:39:35PM +0000, Will Deacon wrote:
> Hi Jan,
> 
> I've queued this lot on my perf/updates branch, but I just noticed an
> oddity whilst dealing with some potential conflicts with the kvm tree.
> 
> On Thu, Feb 18, 2016 at 05:50:13PM +0100, Jan Glauber wrote:
> > With the long cycle counter bit (LC) disabled the cycle counter is not
> > working on ThunderX SOC (ThunderX only implements Aarch64).
> > Also, according to documentation LC == 0 is deprecated.
> > 
> > To keep the code simple the patch does not introduce 64 bit wide counter
> > functions. Instead writing the cycle counter always sets the upper
> > 32 bits so overflow interrupts are generated as before.
> > 
> > Original patch from Andrew Pinksi <Andrew.Pinksi@caviumnetworks.com>
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 0ed05f6..c68fa98 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -405,6 +405,7 @@ static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
> >  #define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
> >  #define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
> >  #define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
> > +#define ARMV8_PMCR_LC		(1 << 6) /* Overflow on 64 bit cycle counter */
> >  #define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
> >  #define	ARMV8_PMCR_N_MASK	0x1f
> >  #define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
> 
> You haven't extended this mask to cover the LC bit, so it will be ignored
> by armv8pmu_pmcr_write afaict.
> 
> How did you test this? I can easily update the mask, but it would be
> good to know that it doesn't end up cause a breakage.

Please update the mask, I've tested with ARMV8_PMCR_MASK set to 0x7f
and it works fine.

It seems like it would work even without the LC bit set because we
set the upper bits again after an interrupt, but reading the documentation
we should really use ARMV8_PMCR_LC.

thanks,
Jan

> Will
