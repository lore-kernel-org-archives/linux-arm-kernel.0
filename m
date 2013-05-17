From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 18:13:20 +0100
Subject: [PATCH 1/2] ARM: tlb: don't perform inner-shareable invalidation
 for local TLB ops
In-Reply-To: <20130517170411.GJ18614@n2100.arm.linux.org.uk>
References: <1368809678-25818-1-git-send-email-will.deacon@arm.com>
 <20130517170411.GJ18614@n2100.arm.linux.org.uk>
Message-ID: <20130517171320.GV23112@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, May 17, 2013 at 06:04:11PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 17, 2013 at 05:54:37PM +0100, Will Deacon wrote:
> >  	if (possible_tlb_flags & (TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
> > -		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
> > +		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
> >  			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
> >  			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
> >  			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
> >  		}
> > -		put_cpu();
> 
> NAK.  You may wish to read daaeb6c93829806221b2ac533330c64f338ebb89
> which changed this from smp_processor_id() _to_ using get_cpu()/put_cpu().

With these changes, it would be a bug to call a local_* operation from
preemptible context, so the issue described in the commit above will never
trigger from properly written code. Since the flush_* operations are moved
to non-local variants, that shouldn't affect any existing users.

Will
