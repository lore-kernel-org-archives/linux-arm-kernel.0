From: joonwoop@codeaurora.org (Joonwoo Park)
Date: Fri, 1 Aug 2014 18:38:34 -0700
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <20140801083245.GE15733@arm.com>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
 <20140801063009.GA24602@codeaurora.org>
 <20140801083245.GE15733@arm.com>
Message-ID: <20140802013834.GA23206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 09:32:46AM +0100, Will Deacon wrote:
> On Fri, Aug 01, 2014 at 07:30:09AM +0100, Joonwoo Park wrote:
> > + Catalin, Will
> > 
> > Thanks,
> > Joonwoo
> > On Tue, Jul 29, 2014 at 11:28:26PM -0700, Joonwoo Park wrote:
> > > Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
> > > as much as possible with minimized barrier usage.  This simplest optimization
> > > brings faster throughput compare to current byte-by-byte read and write with
> > > barrier in the loop.  Code's skeleton is taken from the powerpc.
> 
> Hmm, I've never really understood the use-case for memcpy_{to,from}io on
> ARM, so getting to the bottom of that would help in reviewing this patch.
> 
> Can you point me at the drivers which are using this for ARM please? Doing a
Sure.  This peripheral-loader.c driver now moved under drivers/soc/ so it can be used for ARM and ARM64.
https://android.googlesource.com/kernel/msm.git/+/db34f44bcba24345d26b8a4b8137cf94d70afa73/arch/arm/mach-msm/peripheral-loader.c
static int load_segment(const struct elf32_phdr *phdr, unsigned num, struct pil_device *pil)
{
<snip>
	while (count > 0) {
		int size;
		u8 __iomem *buf;
		size = min_t(size_t, IOMAP_SIZE, count);
		buf = ioremap(paddr, size);
	}
	<snip>
	memset(buf, 0, size);
<snip>
}
As you can see the function load_segment() does ioremap() followed by memset() and memcpy() which can cause unaligned multi-byte (maybe ARM64 traps 8byte unaligned access?) write to device memory.
Because of this I was fixing the driver to use memset_io() and memcpy_io() but the existing implementations were too slow compare to the one I'm proposing.

> blind byte-by-byte copy could easily cause problems with some peripherals,
> so there must be an underlying assumption somewhere about how this is
> supposed to work.
Would you mind to explain more about the problem with byte-by-byte copying you're worried about?
I thought byte-by-byte copy always safe with regard to aligned access and that's the reason existing implementation does byte-by-byte copy.
I can imagine there are some peripherals don't allow per-byte access.  But if that is the case, should they not use memset_io() and memcpy_{from,to}io() anyway?

Also I found this.  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/234729.html
Looks like Catalin also had a similar idea with mine.

Thanks,
Joonwoo

> 
> Will

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
