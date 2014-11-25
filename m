From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 20:00:42 +0100
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAFpQJXUjYsTiHSyHdgtN9JPWGN8CByR4VwtSMJhwkAUWA4iV9w@mail.gmail.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <2966212.dpWQ0OTb0A@wuerfel>
 <CAFpQJXUjYsTiHSyHdgtN9JPWGN8CByR4VwtSMJhwkAUWA4iV9w@mail.gmail.com>
Message-ID: <2065254.jRdQcinOdg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 08:15:47 Ganapatrao Kulkarni wrote:
> > No, don't hardcode ARM specifics into a common binding either. I've looked
> > at the ibm,associativity properties again, and I think we should just use
> > those, they can cover all cases and are completely independent of the
> > architecture. We should probably discuss about the property name though,
> > as using the "ibm," prefix might not be the best idea.
>
> We have started with new proposal, since not got enough details how
> ibm/ppc is managing the numa using dt.
> there is no documentation and there is no power/PAPR spec for numa in
> public domain and there are no single dt file in arch/powerpc which
> describes the numa. if we get any one of these details, we can align
> to powerpc implementation.

Basically the idea is to have an "ibm,associativity" property in each
bus or device that is node specific, and this includes all CPUs and
memory nodes. The property contains an array of 32-bit integers that
count the resources. Take an example of a NUMA cluster of two machines
with four sockets and four cores each (32 cores total), a memory
channel on each socket and one PCI host per board that is connected
at equal speed to each socket on the board.

The ibm,associativity property in each PCI host, CPU or memory device
node consequently has an array of three (board, socket, core) integers:

	memory at 0,0 {
		device_type = "memory";
		reg = <0x0 0x0  0x4 0x0;
		/* board 0, socket 0, no specific core */
		ibm,asssociativity = <0 0 0xffff>;
	};

	memory at 4,0 {
		device_type = "memory";
		reg = <0x4 0x0  0x4 0x0>;
		/* board 0, socket 1, no specific core */
		ibm,asssociativity = <0 1 0xffff>; 
	};

	...

	memory at 1c,0 {
		device_type = "memory";
		reg = <0x1c 0x0  0x4 0x0>;
		/* board 0, socket 7, no specific core */
		ibm,asssociativity = <1 7 0xffff>; 
	};

	cpus {
		#address-cells = <2>;
		#size-cells = <0>;
		cpu at 0 {
			device_type = "cpu";
			reg = <0 0>;
			/* board 0, socket 0, core 0*/
			ibm,asssociativity = <0 0 0>; 
		};

		cpu at 1 {
			device_type = "cpu";
			reg = <0 0>;
			/* board 0, socket 0, core 0*/
			ibm,asssociativity = <0 0 0>; 
		};

		...

		cpu at 31 {
			device_type = "cpu";
			reg = <0 32>;
			/* board 1, socket 7, core 31*/
			ibm,asssociativity = <1 7 31>; 
		};
	};

	pci at 100,0 {
		device_type = "pci";
		/* board 0 */
		ibm,associativity = <0 0xffff 0xffff>;
		...
	};

	pci at 200,0 {
		device_type = "pci";
		/* board 1 */
		ibm,associativity = <1 0xffff 0xffff>;
		...
	};

	ibm,associativity-reference-points = <0 1>;

The "ibm,associativity-reference-points" property here indicates that index 2
of each array is the most important NUMA boundary for the particular system,
because the performance impact of allocating memory on the remote board 
is more significant than the impact of using memory on a remote socket of the
same board. Linux will consequently use the first field in the array as
the NUMA node ID. If the link between the boards however is relatively fast,
so you care mostly about allocating memory on the same socket, but going to
another board isn't much worse than going to another socket on the same
board, this would be

	ibm,associativity-reference-points = <1 0>;

so Linux would ignore the board ID and use the socket ID as the NUMA node
number. The same would apply if you have only one (otherwise identical
board, then you would get

	ibm,associativity-reference-points = <1>;

which means that index 0 is completely irrelevant for NUMA considerations
and you just care about the socket ID. In this case, devices on the PCI
bus would also not care about NUMA policy and just allocate buffers from
anywhere, while in original example Linux would allocate DMA buffers only
from the local board.

	Arnd
