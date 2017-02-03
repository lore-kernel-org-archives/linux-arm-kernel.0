From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Feb 2017 11:51:59 +0000
Subject: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170203014538.GA29585@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170201182506.GA30584@leverpostej>
 <20170202103905.GF13549@linaro.org>
 <20170202115425.GJ31394@leverpostej>
 <20170203014538.GA29585@linaro.org>
Message-ID: <20170203115158.GD30497@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 03, 2017 at 10:45:39AM +0900, AKASHI Takahiro wrote:
> On Thu, Feb 02, 2017 at 11:54:25AM +0000, Mark Rutland wrote:
> > On Thu, Feb 02, 2017 at 07:39:06PM +0900, AKASHI Takahiro wrote:
> > > On Wed, Feb 01, 2017 at 06:25:06PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > > > Another question is (how) does hyp map this region?
> > > 
> > > I don't get your point here.
> > > Hyp mode does care only physical memory in intermediate address, doesn't it?
> > 
> > My concern was that hyp may map the region; and thus buggy code at hyp
> > can corrupt the region (and/or hyp may conflict w.r.t. attributes).
> 
> Grep'ing create_hyp_mappings() under arch/arm(64)/kvm shows that
> we have only a few small regions of memory mapped in hyp mode.
> I also confirmed that there is no active mapping for crash dump kernel
> memory by checking mmu tables with DS-5 debugger.

Ok, that sounds fine.

I was under the mistaken impression that hyp had a copy of the whole
linear mapping, but it seems it lazily maps that in (at page
granularity) as required. So there should be no alias for the
crashkernel region.

> > We mght have to ensure hyp doesn't map the crashkernel region, and to
> > case us pain, disallow freeing of any part of the region.
> 
> So I don't believe we need to worry such a case.

I agree.

Thanks,
Mark.
