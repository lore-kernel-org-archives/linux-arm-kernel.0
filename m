From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Apr 2011 01:17:59 -0700
Subject: [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
In-Reply-To: <alpine.LFD.2.00.1104271043160.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
	<20110427085336.GL17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104271043160.24613@xanadu.home>
Message-ID: <20110428081759.GM3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110427 07:44]:
> On Wed, 27 Apr 2011, Russell King - ARM Linux wrote:
> 
> > On Wed, Apr 20, 2011 at 12:15:03AM -0400, Nicolas Pitre wrote:
> > > The return value for decompress_kernel() is no longer used.  Furthermore,
> > > this was obtained and stored in a variable called output_ptr which is
> > > a complete misnomer for what is actually the size of the decompressed
> > > kernel image.  Let's get rid of it.
> > > 
> > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > ---
> > > 
> > > BTW, I've yet to understand why, but this patch makes CONFIG_KERNEL_LZMA
> > > work for me.
> > 
> > Hmm.  I've switched almost entirely to LZMA since it was introduced and it
> > works for me on all my platforms.  I haven't tested kernels rigorously since
> > your patches to the decompressor, so maybe there's a regression in there
> > somewhere.
> > 
> > Can you try LZMA with your various patches over the last four months
> > reverted?
> 
> Yes I did, and the issue turned up to be about the stack alignment wich 
> was not enforced to a 64 bit boundary.  Depending on the size of the 
> code and compressed kernel data, the stack would end up properly aligned 
> with a 50% probability.  And this was a problem only if your gcc version 
> emited LDRD/STRD type accesses to the stack.
> 
> I'm about to send you a pull request with all those fixes.

Just to summarize, looks like there are three regressions:

1. The stack alignment mentioned above
2. Stack overwriting relocated kernel with cache flush in some cases on ARMv7
3. Reloction overwriting running code when the relocate offset is small

These fixes would be nice to get merged in the -rc cycle. Then the
other patches like the static usage in uncompress.h can probably wait
until the merge window.

Regards,

Tony
