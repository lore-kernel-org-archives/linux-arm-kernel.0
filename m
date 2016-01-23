From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Jan 2016 11:34:38 +0000
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A3609E.3000400@free.fr>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk>
 <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk>
 <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk>
 <56A3609E.3000400@free.fr>
Message-ID: <20160123113438.GG19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 12:14:38PM +0100, Mason wrote:
> One more thing: for the important use-case I described
> (copying a file to remote RAM) the existing code was using
> write_data8! Obvious optimization was to use write_data32
> but this still means two unnecessary copies:
> 
> 1) copying file contents to user-space temp buffer
> 2) copying user-space to temp kernel buffer
> 3) finally move data to remote RAM
> 
> I had a different approach which avoids the 2 copies:
> In user-space, mmap the physical address using /dev/mem
> and just use the read syscall to copy from filesystem
> into remote RAM.
> 
> I don't need to worry about access size in that specific
> instance (since I'm copying to RAM).
> 
> What do you think about that?

Well, there's an issue here I didn't cover previously, and that is that
the kernel has a firmware interface - a method by which drivers can
request firmware for their devices from userspace.  This is the accepted
way to upload firmware from userspace for any device.  It's more
complex, but you ought to look at it as a proper solution to your
problem.  Look at linux/firmware.h for information on this, and an
example usage can be seen in drivers/dma/imx-sdma.c - others can be
found by grepping for that header.

However, if you're going to stick with your approach, there's a way to
avoid the need to copy into userspace and then copy back out.  It's
called sendfile().  This can be used to send part (or all) of one file
to another file descriptor.  It's intended use was to accelerate
server applications such as apache, but it seems to be a good fit
for what you want.

If you arrange for your module to provide an anonymous file descriptor,
you can use that as the destination file descriptor for uploading the
contents of your file to using sendfile().  The anonymous file
descriptor's f_ops->write method should be called as if userspace
were writing the firmware into this file descriptor - but without the
data being copied into and back out of userspace.

As the file descriptor will be writable, you can also use lseek() and
write() to invoke the f_ops->write method for any file offset, so you
can also use it to upload at any offset and length via standard APIs.

It seems to me that such a solution has a very nice elegance to it.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
