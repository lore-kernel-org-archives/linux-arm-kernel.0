From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2009 11:34:21 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903095142.GB3302@digital-scurf.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<19987914.1168001251884594226.JavaMail.coremail@bj126app54.126.com>
	<20090902120159.GT32606@prithivi.gnumonks.org>
	<20090902191026.GO25153@trinity.fluff.org>
	<20090902222641.GY32606@prithivi.gnumonks.org>
	<20090903095142.GB3302@digital-scurf.org>
Message-ID: <20090903103421.GA9507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2009 at 10:51:42AM +0100, Daniel Silverstone wrote:
> Basically the expectation appears to be that userland wishing to use
> acceleration features of a framebuffer device (such as the multiple planes,
> hardware cursor support, hardware bitblt etc which an SoC or graphics chip
> might implement) is expected to do it for itself by knowing which bit of
> physical memory to mmap() and fiddle, underneath and behind-the-back-of the
> kernel.

Not quite.  The FB API provides a method to map the hardware registers
in a well defined way:

- read the fb_fix_screeninfo structure via the FBIOGET_FSCREENINFO ioctl.
  This gives you the size of the video memory (smem_len) and the size of
  the MMIO registers (mmio_len).  It also tells you what kind of device
  is there (accel).
- mmap using an offset of smem_len and a length of mmio_len.
  This gives you a mapping for the hardware registers independent of the
  actual physical address location.

There is protection built in here to prevent userspace having access to
the hardware registers while the kernel wants to access them - you can
only mmap the MMIO registers provided var.accel_flags is zero (in other
words, you've asked the kernel _not_ to use any hardware acceleration.)
To put it another way, your driver must not use hardware acceleration
for the FB console if var.accel_flags is zero.

So, really, there's no "fiddling behind the back of the kernel" if things
are done correctly, and there's no need to know where the registers
actually appear in the physical space - which was required in the old
days of mapping them via /dev/mem.

Yes, it's unfortunate that the acceleration functions themselves are not
available to userspace, but I don't think the situation is as bad as
you're making it out to be.
