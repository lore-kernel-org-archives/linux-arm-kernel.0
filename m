From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 20:06:42 +0000
Subject: ARM kernel at memory offset 32MB
In-Reply-To: <eff7abbdc559c19e63c928c8645205b8.squirrel@lightmail.glesys.com>
References: <eff7abbdc559c19e63c928c8645205b8.squirrel@lightmail.glesys.com>
Message-ID: <20150312200642.GW8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 05:08:21PM +0100, magnus at minimum.se wrote:
> It seems like CONFIG_AUTO_ZRELADDR is what adjusts the load adress here;
> and I noticed the alignment is hardcoded to 128 MB. Is this a hardware
> limitation (can't we run a kernel at any offset between 0 and 128 MB?)

It's a balance between what various platforms require in terms of the
alignment of their physical memory, and what we can tolerate through
tricks such as what you're trying to do.

Let's take an example.  A platform has 128MB starting at 0xc8000000.
If we increase the alignment to 256MB, this means we decide that
physical memory starts at 0xc0000000, which would map that to
PAGE_OFFSET, which ultimately will crash the kernel on this platform.

If, on the other hand, we have someone who has decided that they want
to hand over the first 64MB of memory for another application (such
as what you're doing), they will be loading the kernel at 64MB + 32K.
If we reduced the alignment to 64M, it means that on that platform,
we then decide that physical memory magically starts 64MB higher
than it used to, again leading to problems.

So, we basically can't change it now - the risks are too great.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
