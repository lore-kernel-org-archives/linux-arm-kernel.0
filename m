From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Aug 2015 20:54:55 +0100
Subject: [PATCH] ARM: Set proper TEXT_OFFSET for IPQ806x
In-Reply-To: <20150820172010.GB10796@qualcomm.com>
References: <20150820121541.GA14664@codeaurora.org>
 <20150820130005.GS7557@n2100.arm.linux.org.uk>
 <20150820172010.GB10796@qualcomm.com>
Message-ID: <20150820195455.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:20:10PM -0500, Andy Gross wrote:
> On Thu, Aug 20, 2015 at 02:00:06PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Aug 20, 2015 at 05:45:41PM +0530, Varadarajan Narayanan wrote:
> > > RAM starts at 0x40000000 for IPQ. The lower 21MB of RAM is used
> > > for Shared Memory and the kernel can start from 0x41500000.
> > 
> > Why do people keep creating crap like this?  Each time something like
> > this is created, it means that you _need_ to have a special kernel for
> > your platform and you can't be part of the single zImage.
> > 
> > Please, rather than creating crap like this, find a better way.
> 
> In the case of the IPQ, we don't use the zImage because the decompress
> requires a larger jump than we can do on that platform.  Having this
> change at least gets us back 2MB of memory.

Your argument about "a larger jump" makes no sense what so ever.  The
branches between the decompressor and the main kernel are all done
using a mov, which can jump to any 32-bit address.

Even if you load the compressed kernel image at 0x41500000, the
decompressor will mask that with 0xf8000000, and decide that RAM
starts at 0x40000000.  It will then want to place the decompressed
kernel image at 0x40008000.  Nothing there has anything to do with
jump ranges.

The only restriction that the ARM has as far as jump ranges are
concerned is the 'b' or 'bl' instruction, which in ARM mode is
limited to +/- 32MB.  That doesn't apply here since we don't use
that to jump between the decompressor and the decompressed kernel
image.

So...

Why is it necessary to have this 21MB block of shared memory at
the start of RAM?  Why can't it be reserved by other means higher
up in system memory?

It's up to the submitter to justify why any change is required, and
in this case, part of that justification is why the shared memory is
placed at the start of RAM, and why you need to be different from
almost everyone else, and why you need to be a special case.  The
justification also must make sense.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
