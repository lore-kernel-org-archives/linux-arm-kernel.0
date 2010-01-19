From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 19 Jan 2010 18:33:29 +0000
Subject: flush_dcache_page does too much?
In-Reply-To: <20100119174450.GB1886@n2100.arm.linux.org.uk>
References: <20100118133304.GA29645@n2100.arm.linux.org.uk>
	<20100118135431.GA12496@desktop>
	<20100118140005.GD2695@n2100.arm.linux.org.uk>
	<20100118141530.GA13394@desktop>
	<20100118144418.GE2695@n2100.arm.linux.org.uk>
	<20100118145731.GA14523@desktop>
	<20100118150152.GF2695@n2100.arm.linux.org.uk>
	<20100119001636.GA4401@desktop> <20100119130547.GA6285@desktop>
	<20100119174450.GB1886@n2100.arm.linux.org.uk>
Message-ID: <20100119183328.GG1323@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2010 at 09:05:47PM +0800, anfei wrote:
> > Do you think this is a bug and I can send the patch, or it's the problem
> > of the test case?
> 
> Yes, it's a bug, but it needs to be reported elsewhere; neither this
> list nor I can sanction patches to generic code.

It's not necessarily a bug if the appropriate msync() call fixes the
test.  Linux doesn't guarantee coherence between mappings and
read/write without msync() on some architectures, but I haven't seen
an official statement of whether it *should* or not in this type of
case.

I have looked at this in some detail a few years ago.  When I looked
at MIPS and some other architecture code, I wasn't sure it was correct
even with msync() calls everywhere.  It looked distinctly undertested.

The Linux msync(2) man page says:

       msync()  flushes  changes  made  to the in-core copy of a file that was
       mapped into memory using mmap(2) back to disk.   Without  use  of  this
       call  there  is  no guarantee that changes are written back before mun?
       map(2) is called.  To be more precise, the part of the file that corre?
       sponds  to the memory area starting at addr and having length length is
       updated.

It's not a great description.  MS_INVALIDATE talks about invalidating
"other mappings", not this one, in the Linux man page.

But on other OSes (SunOS, HP-UX for example), MS_INVALIDATE
invalidates _this_ mapping so that it sees the latest data written by
write() to the file.

In other words, Linux is a complete mess in this area.  It happens to
work on some architectures, it's broken a little bit on others, broken
a lot on some, and despite reading a fair bit of code I'm still not
sure what the kernel is trying to promise.

Probably different people have different ideas about what's expected,
which is why MIPS and ARM kernels differ.

-- Jamie
