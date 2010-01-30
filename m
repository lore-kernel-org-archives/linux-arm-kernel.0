From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Jan 2010 14:55:49 +0000
Subject: Static mappings at boottime
In-Reply-To: <2703439e1001300647q1149a357v3b3e9da6bd8c91cf@mail.gmail.com>
References: <2703439e1001300647q1149a357v3b3e9da6bd8c91cf@mail.gmail.com>
Message-ID: <20100130145549.GA17097@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2010 at 11:47:36PM +0900, Khushhua Mogambo wrote:
> Dears
> 
>  my soc have very simple and limited device controllers. I have thought
> maybe I can map all devices's register spaces using iotable_init in map_io.

Yes, you can do this.

> And pass already mapped Virtual addr(and not phys addr) to device drivers
>  via IORESOURCE_MEM.

But you can't do this.  Resources take physical addresses, not virtual
addresses.

> i thinks that way i can do most use of virtual address space for ioremap
> and I can set VMALLOC size to maximum possible. also drivers doesnt have
> to worry about mapping(and no addr space is mapped twice in two code pieces)
> 
> is it considered good kernel porting practice? can we face any problem
> after some times?

Definitely not.

The "simple" approach to your proposal is to map the device space
statically and then intercept ioremap().  When you detect a request
for a range which is already statically mapped, then return the
already mapped virtual address.

This doesn't change the way you write the drivers; you write drivers
using the standard interfaces and continue to assume that those
interfaces will fail.
