From: sourav.poddar@ti.com (Sourav Poddar)
Date: Mon, 18 Nov 2013 23:29:21 +0530
Subject: [PATCH 02/10] mtd: st_spi_fsm: Supply all register address and
 bit logic defines
In-Reply-To: <20131118173201.GP13640@lee--X1>
References: <20131118093229.GB13640@lee--X1>
 <20131118133940.GC14306@sirena.org.uk> <20131118142447.GJ13640@lee--X1>
 <20131118144512.GB24408@sirena.org.uk> <20131118145614.GM13640@lee--X1>
 <20131118151651.GE24408@sirena.org.uk> <20131118153110.GN13640@lee--X1>
 <20131118154137.GA28334@sirena.org.uk> <20131118160226.GO13640@lee--X1>
 <20131118172243.GO2674@sirena.org.uk> <20131118173201.GP13640@lee--X1>
Message-ID: <528A5579.60705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013 11:02 PM, Lee Jones wrote:
> On Mon, 18 Nov 2013, Mark Brown wrote:
>
>> On Mon, Nov 18, 2013 at 04:02:26PM +0000, Lee Jones wrote:
>>> On Mon, 18 Nov 2013, Mark Brown wrote:
>>>> Like I say I'm suggesting that the bit of the code that understands the
>>>> flash chip is separate to the bit of code that knows the mechanics of
>>>> sending commands and data to the chip.
>>> The issue is that almost the entire driver is controller side. The
>>> only bits that are the same (and not in all cases) are the OPCODEs,
>>> but they are one liners (21 lines out of 1153). Most of the
>>> controllers which use this stuff could reuse quite a bit of the m25p80
>>> driver as they just write the message containing the OPCODE as the
>>> m25p80 driver sets it up, but that's simply not the case with our
>>> controller. We would have to pull the OPCODE out and based on which
>>> one it is, we'd have to build our own message.
>> OK, so then perhaps the abstraction here is simply to export the table
>> with the opcodes from the m25p80 driver so that when someone comes along
>> and adds a new chip they can just add it there and other drivers will
>> get the update too.
> We could do that, although I'd have to insist on extending the current
> framework to add a configuration call-back, as it's the neatest way to
> configure chip specific attributes.
>
This looks like the problem which some other controllers(from ti,
freescale) are facing.
I will just summarise the problem with the ti qspi flash controller 
which I am
working on. There is a set of registers which need to be filled with flash
specific commands. One way to deal it with to provide a device tree bindings
for all the requirements(which is really cumbersome.).

Similarly, for freescale there is a LUT registers which has such flash 
requirements.

So, surely we need a way out from m25p80 driver to handle such cases.

drivers/mtd/devices/m25p80.c


int pass_flash_info () {

    u8 info[6];

      info[0] = DUMMY WR;
      info[1] = RD_OPCODE;
      info[2] - DUMMY BITS;
      ......
     .......
    spi_write(flash, info, 6)
}
Then, somehow parse this information to set up the required info.
  This is just a rough idea, and can be implemented in a better way.
>   I can get a patch out tomorrow if the MTD guys agree. Where are they
> by the way? I haven't seen hide nor hair of them since sending out the
> patch set.
>
>>> Put it this way, if we tried to use the m25p80 our controller driver
>>> would most likely be twice as large and twice as complex as it is
>>> currently, which is exactly the inverse of what we're trying to
>>> achieve here.
>> If we're having to add new flashes to multiple drivers I'd not say we're
>> winning.
> I agree.
>
