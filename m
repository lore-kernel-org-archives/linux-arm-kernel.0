From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Wed, 9 Nov 2016 15:21:52 +0100
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161108000538.GA13959@obsidianresearch.com>
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
 <20161108000538.GA13959@obsidianresearch.com>
Message-ID: <609bc971-bb6d-8cd2-8e64-23c0082a6216@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 08-11-16 01:05, Jason Gunthorpe wrote:
> On Tue, Nov 01, 2016 at 06:48:42PM +0100, Michal Simek wrote:
>> On 1.11.2016 16:33, Jason Gunthorpe wrote:
>>> On Tue, Nov 01, 2016 at 07:39:22AM +0100, Michal Simek wrote:
>>>
>>>> Regarding BIT and BIN format. This support is in vivado for a long time
>>>> and it is up2you what you want to support. We have removed that BIT
>>>> support and not doing any swap by saying only BIN format is supported.
>>>
>>> BIN is not supported, it needs a swap as well.
>>>
>>> Moritz has it right, you have to use vivado to create a PROM image to be
>>> compatible with the driver.
>>
>> hm than that's bad.
>
> IMHO, Xilinx made an error with Zynq DevC, the DMA does not accept a
> memory image that is output by the usual Xilinx tools. It should have
> accepted a byte swapped input.
>
> I think Moritz is right, the fpgamgr *should not* alter the bitstream
> in any way. This is important for future work to make the DMA do
> gather and avoid the really bad high-order allocation.
>
> So users will have to provide byte swapped .bin files - the vivado
> write_cfgmem command will produce them - this all needs to be
> documented.
>
> Also, I think Punnaiah (?) was telling me that bitstream encryption
> does not work - DevC must be told the bitstream is encrypted.
> That seems like something that needs work at the fpgamgr level - and
> maybe this driver should auto-detect encryption by looking at the
> bitfile (as is typical for Xilinx programming)
>

I think the basic idea behind the commit is flawed to begin with and the patch 
should be discarded completely. The same discussion was done for the Xilinx 
FPGA manager driver, which resulted in the decision that the tooling should 
create a proper file. This driver should either become obsolete or at least 
move into the same direction as the FPGA manager rather than away from that.

Besides political arguments, there's a more pressing technical argument 
against this theck as well: The whole check is pointless since the hardware
itself already verifies the validity of the stream. Sending bitstreams 
intended for other devices has no effect at all. Even sending random data 
doesn't have any effect, the hardware will discard it. There's no reason to 
waste CPU cycles duplicating this check in software.




Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
