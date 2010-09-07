From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 7 Sep 2010 12:52:39 +0300
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
Message-ID: <AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 7, 2010 at 10:58 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> On Mon, Sep 6, 2010 at 5:14 PM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
>> On Mon, Sep 06, 2010 at 03:03:47PM +0100, Russell King - ARM Linux wrote:
>>> On Mon, Sep 06, 2010 at 12:02:44PM +0200, Wolfgang Wegner wrote:
>>> > Mapping the PCI memory space via mmap() resulted in some
>>> > disappointing ~6.5 MBytes/second. I tried to modify page
>>> > protection to pgprot_writecombine or pgprot_cached, but while
>>> > this did reproducably change performance, it was only in
>>> > some sub-percentage range. I am not sure if I understand
>>> > correctly how other framebuffers handle this, but it seems
>>> > the "raw" mmapped write performance is not cared about too
>>> > much or maybe not that bad with most x86 chip sets?
>>> > However, the idea left over after some trying and looking
>>> > around is to use the DMA engine to speed up write() (and
>>> > also read(), but this is not so important) system calls
>>> > instead of using mmap.
>>>
>>> Framebuffer applications such as Xorg/Qt do not use read/write calls
>>> to access their buffers because that will be painfully slow.
>>
>> BTW, the throughput I get with a "dd if=bitmap of=/dev/fb0 bs=512"
>> is the same I get from my test application writing longwords
>> sequentially to the mmapped frame buffer.
> I'm not sure the writecombine is enabled properly, can you test that on DRAM?
> you can do that be reserving some memory (mem=<dram size - 8M>), then
> try to test throughput with and without writecombine.
>
also, in order to sent bursts, make sure that the stm instruction is
used, preferred with 8 registers with address aligned to 8*4 bytes.
 saeed
>
