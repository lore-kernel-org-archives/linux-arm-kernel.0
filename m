From: neko@bakuhatsu.net (Matt Sealey)
Date: Fri, 27 Sep 2013 11:33:19 -0500
Subject: device tree binding documentation outdated
In-Reply-To: <20130927133120.GC31178@titan.lakedaemon.net>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
 <20130927025116.GG25146@S2101-09.ap.freescale.net>
 <20130927084504.GW12758@n2100.arm.linux.org.uk>
 <20130927122814.GK25146@S2101-09.ap.freescale.net>
 <20130927131225.GA31178@titan.lakedaemon.net>
 <20130927132107.GZ12758@n2100.arm.linux.org.uk>
 <20130927133120.GC31178@titan.lakedaemon.net>
Message-ID: <CAHCPf3tfc9Z14YYm9K0AXNinMDsTwE51_6tbYfyFU7cA8M7MgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 8:31 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Sep 27, 2013 at 02:21:07PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Sep 27, 2013 at 09:12:25AM -0400, Jason Cooper wrote:
>> > I'm currently slogging through the exact same issues for adding imx50
>> > (SanDisk Connect Wireless media Drive).  I thought I was just thick.
>> > It's a relief to know I'm not the only one having trouble with this.
>>
>> I'm coming to the conclusion that it's almost to the point of "vendor
>> lockin" - you have to find someone who understands this stuff to take
>> your hardware description and turn it into a working DT description.
>
> I don't think it's vendor lock-in, I think Freescale's pinctrl/gpio IP
> block is just an over-complicated pain in the ass that doesn't lend
> itself to DT well.


Me either - device trees aren't vendor lock-in but they ARE a huge
reminder of how silicon vendors prioritize software development - the
chip works. The i.MX IOMUX block lends itself VERY well to device
trees.

The problem with vendors is when they ship their chips and docs from
America or Israel or so on, do verification in the UK or Mexico or
India, hand it to a software team in some far away place like China or
India and expect everything to just come out all nice and shiny. The
problem compounds itself when the docs are bad, but in this instance,
Freescale usually give out REALLY good documentation.

The issue with this particular block is there have been 5 different
ways to "do it", originally it was just a list of addresses and values
in an array, then it got turned into a packed 64-bit magic value which
was decoded (possibly to reduce stack usage as a function call,
although it was always inlined...) and then device trees as an
enumerated index into a hardcoded array in Linux, and a pad settings
value on top, and now back to addresses and values again. The number
of possibilities for porting the thing is immense.

The only way to do it from the manual - or Freescale's IOMUX Tool,
which is pretty awesome if a little crashy and for Windows - is the 6
value tuple way.

As an example, this is what I get for the SabreLite Rev A, exported as CSV

~~
Chip,Package,Board,Board Rev.,Design Version
i.MX6DQ,BGA,Sabre_Lite,Rev. A,2

Ball,Name,PowerGroup,Instance.Signal,Instance-Alias.Signal-Alias,Comment,Register,Value,
Register,Value,Register,Value
A22,SD2_DATA0,NVCC_SD2,audmux.AUD4_RXD,audmux.AUD4_RXD,,0x020E0054,0x00000003,0x020E0368,0x0001B0B0,0x020E07B4,0x00000000
B22,SD2_DATA3,NVCC_SD2,audmux.AUD4_TXC,audmux.AUD4_TXC,,0x020E035C,0x00000003,0x020E0744,0x0001B0B0,0x020E07C4,0x00000001
A23,SD2_DATA2,NVCC_SD2,audmux.AUD4_TXD,audmux.AUD4_TXD,,0x020E0050,0x00000003,0x020E0364,0x0001B0B0,0x020E07B8,0x00000000
E20,SD2_DATA1,NVCC_SD2,audmux.AUD4_TXFS,audmux.AUD4_TXFS,,0x020E004C,0x00000003,0x020E0360,0x0001B0B0,0x020E07C8,0x00000000
~~

I used the last pin in my example previously in the list. Note the
0x04c, 0x360 addresses and 0x1b0b0 pad setting (setting the register
to 0x0 is an instruction to the fsl,pins parsing code to ignore it..
hence the need for better macros)

It would be incredibly easy to parse the CSV (or XML or..) or
cross-check the output source code (since it will give you source
code, if a little obtuse and over excited code) and generate the
preprocessor headers or even fsl,pins output for any particular board.
The Name field, Instance prefix, Signal suffix, and register values
and even the comment from the board designer (if they used the IOMUX
tool and if they didn't, bop on the nose with a newspaper..) right
into a device tree.

So, the design tools exist, they're just not being used, or they're
being misused, or supplemental parsers to extract and generate the
files don't exist (Shawn, we talked about the docs being generated
from the RTL and some ability to export them..)

A schema would help, too..
