From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 May 2018 11:55:11 +0100
Subject: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <CAKTKpr7Q7T9ZCTBi=LQR=XaAoihbBA3OKCO7yFobzNmR8EfyjQ@mail.gmail.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
 <20180426105938.y6unpt36lisb7kbr@lakrids.cambridge.arm.com>
 <CAKTKpr7Q7T9ZCTBi=LQR=XaAoihbBA3OKCO7yFobzNmR8EfyjQ@mail.gmail.com>
Message-ID: <20180521105511.6ztjk5conf7lfaiz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2018 at 12:16:13AM +0530, Ganapatrao Kulkarni wrote:
> On Thu, Apr 26, 2018 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Apr 25, 2018 at 02:30:47PM +0530, Ganapatrao Kulkarni wrote:

> >> + *
> >> + *  L3 Tile and DMC channel selection is through SMC call
> >> + *  SMC call arguments,
> >> + *   x0 = THUNDERX2_SMC_CALL_ID      (Vendor SMC call Id)
> >> + *   x1 = THUNDERX2_SMC_SET_CHANNEL  (Id to set DMC/L3C channel)
> >> + *   x2 = Node id
> >
> > How do we map Linux node IDs to the firmware's view of node IDs?
> >
> > I don't believe the two are necessarily the same -- Linux's node IDs are
> > a Linux-specific construct.
> 
> both are same, it is numa node id from ACPI/firmware.

I am very wary about assuming that the Linux nid will always be the same
as the ACPI node id.

For that to *potentially* be true, this driver should depend on
CONFIG_NUMA, NUMA must not be disabled on the command line, etc, or the
node id will always be NUMA_NO_NODE.

I would be *much* happier if we had an explicit mapping somewhere to the
ID the FW expects.

> > It would be much nicer if we could pass something based on the MPIDR,
> > which is a known HW construct, or if this implicitly affected the
> > current node.
> 
> IMO,  node id is sufficient.

I agree that *a* node ID is sufficient, I just don't think that we're
guaranteed to have the specific node ID the FW wants.

> > It would be vastly more sane for this to not be muxed at all. :/
> 
> i am helpless due to crappy hw design!

I'm certainly not blaming you for this! :)

I hope the HW designers don't make the same mistake in future, though...

Thanks,
Mark.
