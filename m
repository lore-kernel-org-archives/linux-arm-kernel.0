From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Thu, 4 Sep 2014 16:32:28 +0000
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <3563146.jh46O3eIbG@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <6499926.sQm3J8L764@wuerfel> <20140904091319.GA32228@leverpostej>
 <3563146.jh46O3eIbG@wuerfel>
Message-ID: <363ee62e362d46a2b02415a124b78cef@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, September 04, 2014 4:39 AM
> To: Mark Rutland
> Cc: linux-arm-kernel at lists.infradead.org; rob.herring at linaro.org; Sharma Bhupesh-B45370; Catalin Marinas;
> Will Deacon; Yoder Stuart-B08248; grant.likely at secretlab.ca; Marc Zyngier; Basu Arnab-B45036; Geoff Levand
> Subject: Re: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
> 
> On Thursday 04 September 2014 10:13:19 Mark Rutland wrote:
> > On Wed, Sep 03, 2014 at 07:31:44PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 03 September 2014 17:31:30 Mark Rutland wrote:
> > > >
> > > > However, I'm not sure I follow the reasoning for making this
> > > > significantly harder, and even ignoring that I don't think this does
> > > > make things significantly harder. Especially so if we have a PSCI node
> > > > but not an enable method -- in that case its trivial to patch in an
> > > > unrelated enable-method anyhow.
> > >
> > > Right, it's not actually much harder. A better way to look at it is
> > > probably that we document what which parts we expect to stay constant
> > > and which parts are to be filled out by the boot loader. Independent
> > > of what PSCI implementation the boot loader provides, we would like
> > > to see enable-method="psci".
> >
> > So in the /cpus node, have a comment like:
> >
> > /*
> >  * We expect the enable-method to be "psci", but this is dependent on
> >  * the FW, which will fill this in.
> >  */
> 
> I was thinking of leaving the enable-method in the cpus node, but having
> an empty psci node with a similar comment.
> 
> > Or, should we put together a soc-guidance.txt with that, ensuring things
> > are initialised correctly (CNTVOFF, CNTFREQ), etc?
> 
> I would very much welcome documentation like that!

If any documentation updates are to be made I think they belong in
Documentation/arm64/booting.txt.

There is currently the following:

[cut]
- CPUs with a "spin-table" enable-method must have a 'cpu-release-addr'
  property in their cpu node.  This property identifies a
  naturally-aligned 64-bit zero-initalised memory location.

  These CPUs should spin outside of the kernel in a reserved area of
  memory (communicated to the kernel by a /memreserve/ region in the
  device tree) polling their cpu-release-addr location, which must be
  contained in the reserved region.  A wfe instruction may be inserted
  to reduce the overhead of the busy-loop and a sev will be issued by
  the primary CPU.  When a read of the location pointed to by the
  cpu-release-addr returns a non-zero value, the CPU must jump to this
  value.  The value will be written as a single 64-bit little-endian
  value, so CPUs must convert the read value to their native endianness
  before jumping to it.

- CPUs with a "psci" enable method should remain outside of
  the kernel (i.e. outside of the regions of memory described to the
  kernel in the memory node, or in a reserved area of memory described
  to the kernel by a /memreserve/ region in the device tree).  The
  kernel will issue CPU_ON calls as described in ARM document number ARM
  DEN 0022A ("Power State Coordination Interface System Software on ARM
  processors") to bring CPUs into the kernel.

  The device tree should contain a 'psci' node, as described in
  Documentation/devicetree/bindings/arm/psci.txt.
[cut]

Whatever the requirements are-- enable-method present, psci node
(empty or otherwise), plus anything about other initialization
like CNTVOFF/CNTFREQ.  Having all boot time requirements in one
place would be good.

Also, if psci 2.0 is a requirement that should be specified in 
there as well.

Thanks,
Stuart
