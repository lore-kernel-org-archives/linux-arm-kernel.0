From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 13 Jul 2017 17:40:00 +0200
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <20170711084855.GA4193@localhost>
References: <27b46938-ae23-9750-e0c7-09fa472d3297@arm.com>
 <CAFpQJXVVeAB7RgGKGX-hwo-0ZU8KHzy9ipgbXN0NHorUpk-5Kw@mail.gmail.com>
 <bee8ac5a-b19f-8112-5529-485c269f3501@arm.com>
 <CAFpQJXXPfBEP+_3rzkRo7Ydb31GKFokQB1bmOVHXSd1Pu0zsyA@mail.gmail.com>
 <ed7416f2-e60b-bf8c-cdbe-8a83e83ca529@arm.com>
 <CAFpQJXUm5tEyaBURzx9OtssBt8+ThO0dmPqtdjjGRJzY5cMv-w@mail.gmail.com>
 <09fa2b5a-9039-0902-4f57-6a6c2a5f7c37@arm.com>
 <6ea9d5df-d15f-a8a6-2442-e2f628b29816@codeaurora.org>
 <03162741-2ddc-fe3d-7f5d-4eafb8209ef5@arm.com>
 <20170711084855.GA4193@localhost>
Message-ID: <20170713154000.GA18024@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.07.17 08:48:56, Jayachandran C wrote:
> On Mon, Jul 10, 2017 at 04:15:28PM +0100, Marc Zyngier wrote:
> > On 10/07/17 15:57, Shanker Donthineni wrote:

> > > I believe ITS driver should provide NUMA aware allocations just like x86 Linux drivers. How much
> > > performance improvement we observer is based on the individual SOC implementation, inter NODE
> > > latency, inter node traffic, cache capacity, and type of the test used to measure results.
> > > 
> > > Please consider this patch irrespective of the test results running on a specific hardware. We
> > > need this patch for upcoming Qualcomm server chips. 
> > 
> > "I believe" and "We need" are not a proof of the usefulness of this. We
> > can argue all day, or you can provide a set of convincing results. Your
> > choice. But I can guarantee you the the latter is a much better method
> > than the former.
> > 
> > If you (or Cavium) cannot be bothered to provide tangible results that
> > this is useful, why should I take this at face value? This is just like
> > any other improvement we make to the kernel. We back it *with data*.
> 
> At Cavium, most of the ThunderX2 boards we have are multi-node, and we
> are interested in enabling NUMA optimizations.
> 
> But, in this case, we do not see (or expect to see - given the nature of
> access) any significant improvement in any standard benchmark. Ganapat's
> LPI injection test to find interrupt latency was probably the best option
> we had so far. We could come up with another contrived test case to see
> if there is any change in behavior when we overload the interconnect,
> but I don't think we will get any data to really justify the patch.
> 
> Allocating the tables on the node is a good thing since it avoids
> unnecessary traffic over the interconnect, so I do not see the
> problem in merging a simple patch for that. Is there any specific
> issue here?
> 
> Anyway, for ThunderX2, the patch is good to have, but not critical.
> And as Ganapat noted, the patch can be improved a bit. Also going thru
> the patch, I think the chip data is better allocated using node as well.

There is another thing to consider here. We will need cma and devm for
ITS. There are only a few per node allocation functions that can be
used then, so per-node allocation should only be used in rare cases
where really needed. I am going to repost my cma device table
allocation series after the merge window closes.

-Robert
