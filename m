From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 4 Apr 2014 16:38:25 +0000
Subject: mach header files
In-Reply-To: <20140404162217.GE7528@n2100.arm.linux.org.uk>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <5297747.kWEjnPz8MW@wuerfel>
 <9970caa86d5c454d840c489901d3ca91@SIXPR06MB173.apcprd06.prod.outlook.com>
 <6837506.Q7cFQWf1xJ@wuerfel>
 <730e7ebfabf7489bbfee808cd0247411@SIXPR06MB173.apcprd06.prod.outlook.com>
 <20140404162217.GE7528@n2100.arm.linux.org.uk>
Message-ID: <cc8d077175e342ceb45e3dedf54a5595@SIXPR06MB173.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 04 April 2014 17:22, Russell wrote:
> On Fri, Apr 04, 2014 at 04:02:58PM +0000, Phil Edworthy wrote:
> > Unfortunately, it's not a performance toggle. Functionally, the pl011
> > will only work with a DMAC if we use the DMA burst request. That's not
> > completely true though as whether it will work depends on the pl011
> > driver. With the upstream pl011 linux driver, it's true.
> >
> > BTW, the register to control this has nothing to do with the pl011
> > hardware. The standard pl011 hardware, afaik, outputs both the DMA
> > single request and DMA burst request signals, and which one is wired
> > up to the DMAC depends on who designed the SoC. For this hardware,
> > the hardware people played safe and provided a register that can be
> > used to switch between the single and burst request signals.
> 
> That's not how it's supposed to be used.
> 
> The idea behind the two requests is that the peripheral signals to the
> DMA controller whether it has enough entries in the FIFO for the DMA
> controller to do a burst transfer, or whether it should do a series of
> single transfers.
> 
> It sounds to me like someone hasn't taken the time to read the PL011
> documentation and thought about this.  As such, it's probably not worth
> bothering trying to get DMA working.

DMA with the pl011 works just fine, thanks - we've integrated our DMAC & pl011 hardware onto a Xilinx Zynq device.
The only software change required is to modify the burst threshold in the pl011 driver to 3/4 full. The DMA burst size is left to 1/2 the FIFO size to ensure there is data left in the FIFO after the DMAC has performed it's burst. This allows the pl011 to fire of the rx timeout irq when no further data has been received.

Thanks
Phil
