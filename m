From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Sep 2013 17:12:58 +0100
Subject: [PATCH v2 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <1379330464-27917-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1379330464-27917-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1379330464-27917-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130925161258.GG7601@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

This looks good, but I have a couple comments.

On Mon, Sep 16, 2013 at 12:21:03PM +0100, Lorenzo Pieralisi wrote:
> In order to extend the current cpu nodes bindings to newer CPUs
> inclusive of AArch64 and to update support for older ARM CPUs this
> patch updates device tree documentation for the cpu nodes bindings.
> 
> Main changes:
>     - adds 64-bit bindings
>     - define usage of #address-cells
>     - defines behaviour on pre and post v7 uniprocessor systems
>     - adds ARM 11MPcore specific reg property definition
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[...]

> +=====================================
> +cpus and cpu node bindings definition
> +=====================================
> +
> +The ARM architecture, in accordance with the ePAPR, requires the cpus and cpu
> +nodes to be present and contain the properties described below.
> +
> +- cpus node
> +
> +	Description: Container of cpu nodes
> +
> +	The node name must be "cpus".
> +
> +	A cpus node must define the following properties:
> +
> +	- #address-cells
> +		Usage: required
> +		Value type: <u32>
> +
> +		Definition depends on ARM architecture version and
> +		configuration:
> +
> +			# On uniprocessor ARM architectures previous to v7
> +			  value must be 1, to enable a simple enumeration
> +			  scheme for processors that do not have a HW CPU
> +			  identification register.
> +			# On 32-bit ARM 11 MPcore, ARM v7 or later systems
> +			  value must be 1, that corresponds to CPUID/MPIDR
> +			  registers sizes.
> +			# On ARM v8 64-bit systems value must be set to 2,
> +			  that corresponds to the MPIDR_EL1 register size.

Under some situations (where mpidr_el1[63:32] == 0), #address-cells =
<1> needs to be supported for 64-bit hardware, to maintain compatibility
with kvmtool. Will had a commit specifically to allow this (72aea393a2:
"arm64: smp: honour #address-size when parsing CPU reg property"), which
mentions the kvmtool compatibility issue.

I think we need to state that it _should_ be 2. If all the identifiying
bits in the upper half of the register (currently Aff3) are zero, then 1
cell is permitted, and the cell refers to mpidr_el1[31:0].

It's possible that bits which are currently RES0 may become identifying
bits in future, so for the moment we could state that we only allow one
cell when all of mpidr_el1[63:32] is zero, and if mpidr_el1[40:42,23:0]
becomes insufficient to uniquely identify a CPU we need to update the
binding document.

> +
> +	- #size-cells
> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be set to 0
> +
> +- cpu node
> +
> +	Description: Describes a CPU in an ARM based system
> +
> +	PROPERTIES
> +
> +	- device_type
> +		Usage: required
> +		Value type: <string>
> +		Definition: must be "cpu"
> +	- reg
> +		Usage and definition depend on ARM architecture version and
> +		configuration:
> +
> +			# On uniprocessor ARM architectures previous to v7
> +			  this property is required and must be set to 0.
> +
> +			# On ARM 11 MPcore based systems this property is
> +			  required and matches the CPUID[11:0] register bits.
> +
> +			  Bits [11:0] in the reg cell must be set to
> +			  bits [11:0] in CPU ID register.
> +
> +			  All other bits in the reg cell must be set to 0.
> +
> +			# On 32-bit ARM v7 or later systems this property is
> +			  required and matches the CPU MPIDR[23:0] register
> +			  bits.
> +
> +			  Bits [23:0] in the reg cell must be set to
> +			  bits [23:0] in MPIDR.
> +
> +			  All other bits in the reg cell must be set to 0.

These all look fine to me.

> +
> +			# On ARM v8 64-bit systems this property is required
> +			  and matches the MPIDR_EL1 register affinity bits:
> +
> +			  The first reg cell bits [7:0] must be set to
> +			  bits [39:32] of MPIDR_EL1.
> +
> +			  The second reg cell bits [23:0] must be set to
> +			  bits [23:0] of MPIDR_EL1.
> +
> +			  All other bits in the reg cells must be set to 0.

This probably needs to be reworded to cover the #address-cells = <1>
case mentioned above.

[...]

> +	- enable-method
> +		Value type: <stringlist>
> +		Usage and definition depend on ARM architecture version.
> +			# On ARM v8 64-bit this property is required and must
> +			  be one of:
> +			     "spin-table"
> +			     "psci"
> +			# On ARM 32-bit systems this property is optional.
> +
> +	- cpu-release-addr
> +		Usage: required for systems that have an "enable-method"
> +		       property value of "spin-table".
> +		Value type: <prop-encoded-array>
> +		Definition:
> +			# On ARM v8 64-bit systems must be a two cell
> +			  property identifying a 64-bit zero-initialised
> +			  memory location.
> +

Later, we should probably split these into individual bindings docs to
better describe platform requirements. We don't need to do that now.

Otherwise this looks good. Thanks for all the hard work putting this
together, sorry for the last-minute change request.

With the #address-cells = <1> fixups:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
