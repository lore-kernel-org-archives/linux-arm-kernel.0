From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Nov 2016 17:05:38 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <4e2c7e1c-7c33-a552-5b91-dbdefac58e37@xilinx.com>
References: <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
 <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
 <20161031162327.GA28817@obsidianresearch.com>
 <7117d821-a1b1-7c07-806a-483be99131e6@xilinx.com>
 <20161101153326.GA6193@obsidianresearch.com>
 <4e2c7e1c-7c33-a552-5b91-dbdefac58e37@xilinx.com>
Message-ID: <20161108000538.GA13959@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 06:48:42PM +0100, Michal Simek wrote:
> On 1.11.2016 16:33, Jason Gunthorpe wrote:
> > On Tue, Nov 01, 2016 at 07:39:22AM +0100, Michal Simek wrote:
> > 
> >> Regarding BIT and BIN format. This support is in vivado for a long time
> >> and it is up2you what you want to support. We have removed that BIT
> >> support and not doing any swap by saying only BIN format is supported.
> > 
> > BIN is not supported, it needs a swap as well.
> > 
> > Moritz has it right, you have to use vivado to create a PROM image to be
> > compatible with the driver.
> 
> hm than that's bad.

IMHO, Xilinx made an error with Zynq DevC, the DMA does not accept a
memory image that is output by the usual Xilinx tools. It should have
accepted a byte swapped input.

I think Moritz is right, the fpgamgr *should not* alter the bitstream
in any way. This is important for future work to make the DMA do
gather and avoid the really bad high-order allocation.

So users will have to provide byte swapped .bin files - the vivado
write_cfgmem command will produce them - this all needs to be
documented.

Also, I think Punnaiah (?) was telling me that bitstream encryption
does not work - DevC must be told the bitstream is encrypted.
That seems like something that needs work at the fpgamgr level - and
maybe this driver should auto-detect encryption by looking at the
bitfile (as is typical for Xilinx programming)

Jason
