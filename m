From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 8 Mar 2016 09:34:36 +0100
Subject: [PATCH v14 2/6] Documentation, dt, numa: dt bindings for NUMA.
In-Reply-To: <CAFpQJXWHXxa2DLKHpLHqnURUJqY-+P-vLintUoCmm3Fmh6xsZQ@mail.gmail.com>
References: <1457049339-23351-1-git-send-email-ddaney.cavm@gmail.com>
 <1457049339-23351-3-git-send-email-ddaney.cavm@gmail.com>
 <20160307192220.GA1535@rric.localdomain>
 <56DDDAC9.1010600@caviumnetworks.com>
 <CAFpQJXWHXxa2DLKHpLHqnURUJqY-+P-vLintUoCmm3Fmh6xsZQ@mail.gmail.com>
Message-ID: <20160308083436.GC24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.03.16 10:31:33, Ganapatrao Kulkarni wrote:
> On Tue, Mar 8, 2016 at 1:17 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> > On 03/07/2016 11:22 AM, Robert Richter wrote:
> >>
> >> On 03.03.16 15:55:35, David Daney wrote:
> >>>
> >>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> >>>
> >>> Add DT bindings for numa mapping of memory, CPUs and IOs.
> >>>
> >>> Reviewed-by: Robert Richter <rrichter@cavium.com>
> >>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> >>> Signed-off-by: David Daney <david.daney@cavium.com>
> >>> ---
> >>>   Documentation/devicetree/bindings/numa.txt | 272
> >>> +++++++++++++++++++++++++++++
> >>>   1 file changed, 272 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/numa.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/numa.txt
> >>> b/Documentation/devicetree/bindings/numa.txt
> >>> new file mode 100644
> >>> index 0000000..ec5ed7c
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/numa.txt
> >>
> >>
> >>>
> >>> +==============================================================================
> >>> +3 - distance-map
> >>>
> >>> +==============================================================================
> >>> +
> >>> +The device tree node distance-map describes the relative
> >>> +distance (memory latency) between all numa nodes.
> >>> +
> >>> +- compatible : Should at least contain "numa-distance-map-v1".
> >>> +
> >>> +- distance-matrix
> >>> +  This property defines a matrix to describe the relative distances
> >>> +  between all numa nodes.
> >>> +  It is represented as a list of node pairs and their relative distance.
> >>> +
> >>> +  Note:
> >>> +       1. Each entry represents distance from first node to second node.
> >>> +       The distances are equal in either direction.
> >>> +       2. The distance from a node to self (local distance) is
> >>> represented
> >>> +       with value 10 and all internode distance should be represented
> >>> with
> >>> +       a value greater than 10.
> >>> +       3. distance-matrix should have entries in lexicographical
> >>> ascending
> >>> +       order of nodes.
> >>> +       4. There must be only one device node distance-map which must
> >>> reside in the root node.
> >>
> >>
> >> There is no note that this one is optional, but is it right? The
> >> default is 10 for local and 20 for remote connections.
> >>
> >
> > Do we need to explicitly state that it is optional?  Many node types are
> > optional, and their binding specifications don't really talk about their
> > being optional.
> >
> > If the node is present then it has the meaning specified.
> >
> > If the node is *not* present, then the special meaning described in the
> > bindings document does not apply.
> >
> > In the case of NUMA, this means that all memory is equally distant (i.e. it
> > is *Uniform*), and we are not talking about a *Non* *Uniform* Memory
> > Architecture (NUMA) system.
> >
> >
> >> If so, then ...
> >>
> >> static int __init of_numa_parse_distance_map(void)
> >> {
> >>         int ret = -EINVAL;
> >>         struct device_node *np = of_find_node_by_path("/distance-map");
> >>
> >>         if (!np)
> >>                 return ret;
> >>
> >> must return 0 instead of -EINVAL here.
> >
> >
> > No, I don't think doing that would be correct.
> >
> > If there is no "distance-map", then of_numa_init() returns the error code.
> > This causes the code in arch/arm64/kernel/numa.c to fall back to the
> > non-NUMA "dummy_numa" case.

Which means distance-map is not optional for numa.

> IMO, return 0 will allow 2 node system to have distance-map optional.
> by default node distance is set to 10 for local node and for remote node is 20
> and this will suffice the need of 2 node system.
> by returning EINVAL, we are forcing 2 node system (and even for
> systems which has equal remote distances)
> to define distance-map.

This is exaclty the problem. numa_init() fails if there is no
distance-map node.

> > By adding your Reviewed-by: Robert Richter <rrichter@cavium.com> tag to
> > patch 5/6, where we select between "real" and "dummy_numa", I had assumed
> > that you agreed with this approach.

This is from v6:

       if (strcmp(uname, "distance-map") != 0)
               return 0;

-Robert
