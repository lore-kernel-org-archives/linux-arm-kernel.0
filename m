From: mdf@kernel.org (Moritz Fischer)
Date: Wed, 22 Mar 2017 20:32:56 -0700
Subject: [RFC v0 0/2] Introduce on-chip interconnect API
In-Reply-To: <7e7c29a7-af04-04a8-cb76-0c406f8f855c@linaro.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170303062145.zpa4oblwgx2ecgv7@rob-hp-laptop>
 <7e7c29a7-af04-04a8-cb76-0c406f8f855c@linaro.org>
Message-ID: <20170323033256.GA6007@tyrael.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 05:41:54PM +0200, Georgi Djakov wrote:
> On 03/03/2017 08:21 AM, Rob Herring wrote:
> > On Wed, Mar 01, 2017 at 08:22:33PM +0200, Georgi Djakov wrote:
> > > Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> > > graphics, modem). These cores are talking to each other and can generate a lot
> > > of data flowing through the on-chip interconnects. These interconnect buses
> > > could form different topologies such as crossbar, point to point buses,
> > > hierarchical buses or use the network-on-chip concept.
> > > 
> > > These buses have been sized usually to handle use cases with high data
> > > throughput but it is not necessary all the time and consume a lot of power.
> > > Furthermore, the priority between masters can vary depending on the running
> > > use case like video playback or cpu intensive tasks.
> > > 
> > > Having an API to control the requirement of the system in term of bandwidth
> > > and QoS, so we can adapt the interconnect configuration to match those by
> > > scaling the frequencies, setting link priority and tuning QoS parameters.
> > > This configuration can be a static, one-time operation done at boot for some
> > > platforms or a dynamic set of operations that happen at run-time.
> > > 
> > > This patchset introduce a new API to get the requirement and configure the
> > > interconnect buses across the entire chipset to fit with the current demand.
> > > The API is NOT for changing the performance of the endpoint devices, but only
> > > the interconnect path in between them.
> > > 
> > > The API is using a consumer/provider-based model, where the providers are
> > > the interconnect controllers and the consumers could be various drivers.
> > > The consumers request interconnect resources (path) to an endpoint and set
> > > the desired constraints on this data flow path. The provider(s) receive
> > > requests from consumers and aggregate these requests for all master-slave
> > > pairs on that path. Then the providers configure each participating in the
> > > topology node according to the requested data flow path, physical links and
> > > constraints. The topology could be complicated and multi-tiered and is SoC
> > > specific.
> > > 
> > > Below is a simplified diagram of a real-world SoC topology. The interconnect
> > > providers are the memory front-end and the NoCs.
> > > 
> > > +----------------+    +----------------+
> > > | HW Accelerator |--->|      M NoC     |<---------------+
> > > +----------------+    +----------------+                |
> > >                         |      |                    +------------+
> > >           +-------------+      V       +------+     |            |
> > >           |                +--------+  | PCIe |     |            |
> > >           |                | Slaves |  +------+     |            |
> > >           |                +--------+     |         |   C NoC    |
> > >           V                               V         |            |
> > > +------------------+   +------------------------+   |            |   +-----+
> > > |                  |-->|                        |-->|            |-->| CPU |
> > > |                  |-->|                        |<--|            |   +-----+
> > > |      Memory      |   |         S NoC          |   +------------+
> > > |                  |<--|                        |---------+    |
> > > |                  |<--|                        |<------+ |    |   +--------+
> > > +------------------+   +------------------------+       | |    +-->| Slaves |
> > >    ^     ^    ^           ^                             | |        +--------+
> > >    |     |    |           |                             | V
> > > +-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
> > > | CPU |  |  | GPU |    | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> > > +-----+  |  +-----+    +-----+  +---------+   +----------------+   +--------+
> > >          |
> > >      +-------+
> > >      | Modem |
> > >      +-------+
> > > 
> > > This RFC does not implement all features but only main skeleton to check the
> > > validity of the proposal. Currently it only works with device-tree and platform
> > > devices.
> > > 
> > > TODO:
> > >  * Constraints are currently stored in internal data structure. Should PM QoS
> > >  be used instead?
> > >  * Rework the framework to not depend on DT as frameworks cannot be tied
> > >  directly to firmware interfaces. Add support for ACPI?
> > 
> > I would start without DT even. You can always have the data you need in
> > the kernel. This will be more flexible as you're not defining an ABI as
> > this evolves. I think it will take some time to have consensus on how to
> > represent the bus master view of buses/interconnects (It's been
> > attempted before).
> > 
> > Rob
> > 
> 
> Thanks for the comment and for discussing this off-line! As the main
> concern here is to see a list of multiple platforms before we come
> up with a common binding, i will convert this to initially use platform
> data. Then later we will figure out what exactly to pull into DT.

This is great stuff, I had whipped up something similar for a technology
that some of our devices use called RFNoC but got stuck when looking at
the bindings. I'll see if I can squeeze my stuff into the framework and
give you some feedback.

Cheers,

Moritz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/11f5b7aa/attachment.sig>
