From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 13 Feb 2014 13:48:40 -0600
Subject: [PATCH v2 1/5] drivers: of: add initialization code for reserved
 memory
In-Reply-To: <52FA87B8.8040203@gmail.com>
References: <1391515773-6112-2-git-send-email-m.szyprowski@samsung.com>
 <20140205110538.99E47C40A89@trevor.secretlab.ca>
 <52FA0D6E.9090304@samsung.com>
 <20140211121316.24032C40C4D@trevor.secretlab.ca>
 <52FA33E2.4050004@samsung.com>
 <20140211190104.7E6C5C4140E@trevor.secretlab.ca>
 <1392148971.3835.15.camel@pasglop> <52FA8245.5050707@gmail.com>
 <20140211201933.GI841@joshc.qualcomm.com>
 <52FA87B8.8040203@gmail.com>
Message-ID: <20140213194840.GO841@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:27:36PM +0100, Tomasz Figa wrote:
> On 11.02.2014 21:19, Josh Cartwright wrote:
> >On Tue, Feb 11, 2014 at 09:04:21PM +0100, Tomasz Figa wrote:
> > >On 11.02.2014 21:02, Benjamin Herrenschmidt wrote:
> > > >On Tue, 2014-02-11 at 19:01 +0000, Grant Likely wrote:
> > > > > > except that the former IMHO better suits the definition of memory
> > > > > > region, which I see as a single contiguous range of memory and can be
> > > > > > simplified to have a single reg entry per region.
> > > > >
> > > > > My point is rather if multiple reg tuples are found in a reserved memory
> > > > > node, the kernel must respect them and reserve the memory. I'm not
> > > > > arguing about whether or not that makes for a good binding.
> > > >
> > > > agreed.
> > >
> > > My point is why, if the binding defines that just a single tuple should be
> > > provided.
> >
> > FWIW, the usecase I had mentioned in reply to Grant in the patch 5/5
> > thread [1] could make use of this.  The shared memory region is split
> > into a main chunk and several "auxiliary" chunk, but collectively these
> > regions all share the same heap state.
> >
> >   Josh
> >
> > 1: http://lkml.kernel.org/r/20140205192502.GO20228 at joshc.qualcomm.com
>
> The use case seems fine, but I believe it could be properly represented in
> device tree using multiple single-reg regions as well, unless the consumer
> can request a block of memory that crosses boundary of two sub-regions
> specified by reg entries of single region.

I could probably make a only-one-reg-entry policy work for me, but it
makes things a bit more awkward.  I'd lose the ability to describe
"this set of regions need to be logically handled together" directly in
the reserved memory node, and would need to push it up a layer.

	reserved-memory {
		smem: smem {
			reg = <...>;
		};
		aux1: auxiliary1 {
			reg = <...>;
		};
		aux2: auxiliary2 {
			reg = <...>;
		};
		...
	};

	heap : heap {
		compatible = "qcom,shared-memory";
		memory-region = <&smem &aux1 &aux2>;
		#smem-cells = <2>;
	};

	actual_consumer1 {
		compatible = "...";
		smem = <&heap IDENTIFIER1 0x1000>;
	};

	actual_consumer2 {
		compatible = "...";
		smem = <&heap IDENTIFIER2 0x1000>;
	};

Maybe that's better off, I don't know.  This would also eliminate my
need for a #memory-region-cells property.

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
