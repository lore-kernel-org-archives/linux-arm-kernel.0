From: andy@warmcat.com (Andy Green)
Date: Wed, 30 Dec 2009 13:37:34 +0000
Subject: Ethernet / SD Boot
In-Reply-To: <20091230131559.GA369@opensource.wolfsonmicro.com>
References: <20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
	<20091228224435.GA23617@sirena.org.uk>
	<4B39D439.9070909@warmcat.com>
	<20091229123348.GB5784@opensource.wolfsonmicro.com>
	<4B39FB2C.4010608@warmcat.com>
	<20091230131559.GA369@opensource.wolfsonmicro.com>
Message-ID: <4B3B579E.8030105@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/09 13:16, Somebody in the thread at some point said:

Hi -

>> Right, but if you can eliminate JTAG in the flow, especially at the
>> factory, that is a major simplification.
>
> An awful lot of production setups are capable of handling JTAG already
> so don't have much of an issue here.  Certainly as a developer my
> preference here would be for fast JTAG over SD card - it's at least as
> fast, there's only one system involved and it works just the same no
> matter what the state of the system is.

If you have JTAG gear that works reliably (I never had much luck with 
OpenOCD, I only ever got it to work with the OM debug board with one 
specific build of a library, not the latest one either).  I have a Wind 
River JTAG dongle here that only works on Fedora 6 or something, it's 
not really workable here or at a factory to set up VMs to please this 
piece of test gear.  I guess you have better luck depending on JTAG than 
I have, it certainly creates a burden to use it in my experience.

Actually with SD basis you simply remove all other mass NV devices from 
your board.  SD cards can be duplicated out of the factory so there's no 
real comparison needed between raw NAND bringup over JTAG and SD Card basis.

The only piece of "board bringup" needed is to allocate and write board 
identity data somewhere like MACs if you want that to live on the board 
and not the SD, and that can be done from the test SD image acquiring 
the data over the network.

Customers don't have JTAG gear either so those arrangements and that 
work are specific to the production action.  However customers do have 
SD readers and that can be part of a debricking scheme that does not 
involve product return.

>> Again all I can say is it's specialized case.  For normal dev work
>> SD is either painless or hugely advantageous.
>
> Assuming the hardware can cope with it, and there's component cost,
> board area and mechanical concerns to address before it gets designed
> in.  There are a lot of systems where it would be useful but there's
> drawbacks you have to bear in mind when pushing it.

I don't really regard those as drawbacks.

Component cost is just the connector and four pullups, I guess it's $0.70.

Yeah you need to make the uSD connector accessible if you remove a 
cover, that's generally not hard.

CPUs in the class where it is useful (ARM11+) all tend to have one or 
more SD peripheral unit on the CPU already, so that's for free.

With true SD boot, cost of the SD card itself is balanced by being able 
to remove all

  - NAND

  - NOR

  - JTAG connector + passives

from the board, and all production and test actions around those now 
they are gone.

Space for the uSD socket on one side of the board or another is less 
than typical footprint of NAND and JTAG connector that used to be on the 
board.

I think you find SD basis is normally for free or cheaper.

There are a bunch of horrors around working with raw NAND that also 
disappear now your access to NAND is "cooked" by the controller on the 
SD Card.  You no longer need to deal with ECC, BBT, jffs2 and the like 
but can use normal filesystems directly.

So I think the issue is more the tendency to not bear the drawbacks of 
existing schemes and bootloaders in mind when considering different 
workflows, since dealing with the issues from those are what people are 
used to.

-Andy
