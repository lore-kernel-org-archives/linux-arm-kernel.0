From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Sep 2010 15:03:47 +0100
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to,from}_user?
In-Reply-To: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
Message-ID: <20100906140347.GA24522@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 12:02:44PM +0200, Wolfgang Wegner wrote:
> Mapping the PCI memory space via mmap() resulted in some
> disappointing ~6.5 MBytes/second. I tried to modify page
> protection to pgprot_writecombine or pgprot_cached, but while
> this did reproducably change performance, it was only in
> some sub-percentage range. I am not sure if I understand
> correctly how other framebuffers handle this, but it seems
> the "raw" mmapped write performance is not cared about too
> much or maybe not that bad with most x86 chip sets?
> However, the idea left over after some trying and looking
> around is to use the DMA engine to speed up write() (and
> also read(), but this is not so important) system calls
> instead of using mmap.

Framebuffer applications such as Xorg/Qt do not use read/write calls
to access their buffers because that will be painfully slow.
