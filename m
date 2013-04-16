From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Apr 2013 11:45:45 +0100
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <516C544A.4090107@wwwdotorg.org>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
Message-ID: <20130416104545.GA19837@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Stephen for the review.

On Mon, Apr 15, 2013 at 08:26:02PM +0100, Stephen Warren wrote:
> On 04/15/2013 10:13 AM, Lorenzo Pieralisi wrote:
> > In order to extend the current cpu nodes bindings to newer CPUs
> > inclusive of AArch64 and to update support for older ARM CPUs this
> > patch updates device tree documentation for the cpu nodes bindings.
> > 
> 
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> 
> >  http://devicetree.org
> >  
> > -For the ARM architecture every CPU node must contain the following properties:
> > -
> ...
> > +with updates for 32-bit and 64-bit ARM systems provided in this document.
> > +
> > +In the bindings below:
> 
> That's a slightly odd change, since it removes the statement that a cpus
> node must exist, and "in the bindings below" is not idiomatic for DT
> binding definitions.

I beg to differ.

"Bindings for CPU nodes follow the ePAPR standard...."

ePAPR v1.1

3.6 CPUS node properties

"A cpus node is required for all device trees".

> Perhaps replace that last list with:
> 
> The ARM architecture requires the following properties in the cpus and
> cpu nodes contain the properties described below.
> 
> > +- square brackets define bitfields, eg reg[7:0] value of the bitfield in
> > +  the reg property contained in bits 7 down to 0
> 
> Isn't that standard enough it's not even worth mentioning? If it is,
> it's certainly not something that should be mentioned in the part of the
> document that describes which properties are requried.

It is mentioned before cpus node and cpu node descriptions start.

I think you have a point though and it can be omitted, I certainly would
like to understand better what's "standard enough" in DT world to write
these bindings, I took ePAPR as a reference and tried to assume nothing.

> 
> > +	- #address-cells
> > +		Usage: required
> 
> "Usage" sounds more like what it's used for. "Presence" seems better to me.

I have not reinvented the wheel, just had a look at powerPC bindings and
tried to comply. If "Usage" is not proper we also have to patch a number
of in-kernel DT bindings and update the ePAPR.

> > +			# On ARM architecture versions >= 7 based 32-bit
> > +			  systems this property is required and matches the
> 
> Perhaps "On 32-bit ARMv7 or later systems, this property ..."
> 
> > +			# On ARM v8 64-bit systems, where the reg property
> 
> Should there be an explicit note here re: 32-bit SW running on a 64-bit
> system?

Yes, I think I should add an explicit note.

> Perhaps "on ARMv8 systems running 32-bit or 64- bit software, the reg
> property ..."
> 
> > +			  is made up of two cells to accomodate the 64-bit
> > +			  MPDIR_EL1 register this property is required and
> > +			  matches:
> 
> s/matches/must contain/

Ok, I will reword it.

> > +	- enable-method
> > +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> > +		       systems
> > +		Value type: <string>
> > +		Definition: On ARM 64-bit systems must be "spin-table" [1].
> 
> Can that be an integer instead? with dtc+cpp support, that shouldn't
> hurt the eyes too much any more.

Mmm, I need to read more on dtc+cpp, I do not think that leaving it
as a string would hurt though, am I wrong ? Can we assume that all dts
are preprocessed before being compiled and passed to the kernel ?

I need to catch up on dtc+cpp before commenting further though, thanks
for the hint.

> > +	- cpu-release-addr
> > +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> > +		       systems
> > +		Value type: <prop-encoded-array>
> > +		Definition: On ARM 64-bit systems must be a two cell
> > +			    property identifying a 64-bit zero-initialised
> > +			    memory location [1].
> 
> Presumably that property is required, or not, based on the value of
> enable-method, not based on the ARM architecture or bit-size?

Yes, you have a point even though the bit-size implicitly plays a role
since we have to decouple 32-bit vs 64-bit boot methods.

> > +[1] ARM Linux kernel documentation
> > +    Documentation/devicetree/bindings/arm64/booting.txt
> 
> Is referencing Linux-specific documentation from a supposedly
> OS-agnostic DT binding definition a good idea?

Well, an OS-agnostic DT binding definition in the Linux kernel Documentation
directory. I would like to hear more on this to understand where these
bindings should be published, for now I have no choice but to point
people at Linux kernel documentation (and the ePAPR does too BTW, even
though it is not for explicit bindings).

Thank you !
Lorenzo
