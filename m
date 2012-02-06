From: wmb@firmworks.com (Mitch Bradley)
Date: Mon, 06 Feb 2012 09:05:24 -1000
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
Message-ID: <4F302474.1020701@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I like the general approach of simplifying the pinctrl thing, as the 
previous approach did not appear to be converging.

One possible name would be "gpconfig" - for general purpose configuration.

The register access model in the strawman proposal is probably too 
simple.  32-bit memory mapped registers are certainly the most common 
subcase on ARM, but there are many other cases that occur in practice:

* Registers that must be accessed with 8, 16, or 64-bit cycles.
* Registers that have side effects on read, so read-mask-write must be 
avoided
* Registers accessed via an index/data cycle pair, thus having locking 
requirements
* Registers that must be read after being written, or otherwise 
requiring some sort of memory-ordering enforcement.
* Time delays between pairs of writes
* PCI configuration registers, which often have some combination of the 
above
* Registers behind serial buses like I2C

Both Open Firmware and ACPI have addressed this general problem.  In 
addition to a numeric identifier for the register, you need to specify 
the access semantics.  It's difficult to finitely enumerate all possible 
cases, but you can get to 99.9% with a modest number of access models, 
and then add new models as needed.
