From: leon.woestenberg@gmail.com (Leon Woestenberg)
Date: Thu, 16 Sep 2010 01:39:54 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <20100914070341.GA3438@debian-wegner1.datadisplay.de>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
	<AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
	<20100907161156.GA3625@debian-wegner1.datadisplay.de>
	<alpine.LFD.2.00.1009071443360.19366@xanadu.home>
	<20100908083558.GA3393@debian-wegner1.datadisplay.de>
	<20100909162135.GA3524@debian-wegner1.datadisplay.de>
	<AANLkTimAStrSQQZqX4Dsczas+z02-OnDB4RzO0MxbQhN@mail.gmail.com>
	<20100914070341.GA3438@debian-wegner1.datadisplay.de>
Message-ID: <AANLkTikiym2+jCVXCiQVgd+Yp+Pu=SwbsYYuDvKHoygk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfgang,

On Tue, Sep 14, 2010 at 9:03 AM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
> On Mon, Sep 13, 2010 at 07:10:59PM +0200, Leon Woestenberg wrote:
>> Hello Wolfgang,
>>
>> On Thu, Sep 9, 2010 at 6:21 PM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
>> > On Wed, Sep 08, 2010 at 10:35:58AM +0200, Wolfgang Wegner wrote:
>> >>
>> > With the FPGA evaluation board I get:
>> > - around 38 MBytes/second with Nicolas' inline assembly code
>> > - around 6 MBytes/second with any other C code (mmapped) as
>> > ?well as write() via dd
>> >
>> > So the main problem seems to be either our board implementation
>> > of the PCIe->PCI bridge or the FPGA. However, I am still wondering
>> > how a framebuffer-based application can attain reasonable performance,
>> >
>> Having implemented a framebuffer demo on an FPGA recently using PCI
>> Express, I think the main performance gain is made by having the DMA
>> done by the endpoint (FPGA) rather than by the CPU.
>
> this is what I read all around, however, I do not see how this
> can improve anything when using an mmap()ed frame buffer for
> pixel-oriented operations...
>
I haven't seen a SoC yet that can reach the bandwidth of PCIe using
its DMA controller to push data out the PCIe bus. Most of these do not
support the same type of large read requests that an endpoint may
perform, typically 512 bytes or even 4096 per read request over PCI
Express. Couple that with an efficient endpoint  SGDMA controller and
you reach PCIe full bandwidth, no cycles wasted.

mmap() backed by a good SoC DMA controller may come close, but the max
payload is usually less (128 bytes).

Also, most SoC DMA controllers are too limited to set up the kind of
DMA you want.

> This is why I thought about reverting to write() and simply transfer
> complete frames, which would be sufficient for about 90% of my
> application scenarios - and for the other 10% I could live with
> the lower performance.
>
Anything that works. How much burden do you want to put on the CPU though?

Regards,
-- 
Leon
