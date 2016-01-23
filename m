From: slash.tmp@free.fr (Mason)
Date: Sat, 23 Jan 2016 21:53:30 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <20160123113438.GG19062@n2100.arm.linux.org.uk>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk> <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk> <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk> <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk>
Message-ID: <56A3E84A.1000604@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/2016 12:34, Russell King - ARM Linux wrote:

> [snip firmware interface blurb -- I'll take a look]
> 
> However, if you're going to stick with your approach, there's a way to
> avoid the need to copy into userspace and then copy back out.  It's
> called sendfile().  This can be used to send part (or all) of one file
> to another file descriptor.  It's intended use was to accelerate
> server applications such as apache, but it seems to be a good fit
> for what you want.
> 
> If you arrange for your module to provide an anonymous file descriptor,
> you can use that as the destination file descriptor for uploading the
> contents of your file to using sendfile().  The anonymous file
> descriptor's f_ops->write method should be called as if userspace
> were writing the firmware into this file descriptor - but without the
> data being copied into and back out of userspace.
> 
> As the file descriptor will be writable, you can also use lseek() and
> write() to invoke the f_ops->write method for any file offset, so you
> can also use it to upload at any offset and length via standard APIs.
> 
> It seems to me that such a solution has a very nice elegance to it.

True.

But I would consider mmaping /dev/mem even simpler: it doesn't
require writing a single line of kernel code, and it works as
expected. The gist of the code is:

  fd = open("/path/to/file", O_RDONLY);
  mem_fd = open("/dev/mem", O_WRONLY | O_SYNC);
  va = mmap(NULL, len, PROT_WRITE, MAP_SHARED, mem_fd, phys_addr);
  read(fd, va, len);

And that's it. If I understand correctly, the mem driver
will copy the file contents directly to "remote" RAM.

Is there something wrong with this solution, in your opinion?

Regards.
