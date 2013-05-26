From: david.woodhouse@intel.com (Woodhouse, David)
Date: Sun, 26 May 2013 09:30:00 +0000
Subject: [PATCH v7] arm: use built-in byte swap function
In-Reply-To: <51A19FDD.9040403@gmail.com>
References: <20130129181046.GC25415@pd.tnic>
 <alpine.LFD.2.02.1302082102380.6300@xanadu.home>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
 <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
 <1361356696.13482.269.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200835380.6419@syhkavp.arg>
 <1361367842.13482.279.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
 <1361372008.13482.280.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302201040460.6419@syhkavp.arg>
 <20130220214943.9b28a5b208da9f081387c55e@freescale.com>
 <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
 <20130221005221.15279b1372501af12c1e4f32@freescale.com>
 <alpine.LFD.2.03.1302211134160.6419@syhkavp.arg>
 <20130221203327.6558f89277468f7ffffa6506@freescale.com>
 <alpine.LFD.2.03.1302212219100.6419@syhkavp.arg>
 <20130222194032.f7b44aefa5e2723d16767a1b@freescale.com>
 <1361661654.18110.102.camel@shinybook.infradead.org>
 <20130523114654.1f273241725205c6703b2226@freescale.com>
 <51A19FDD.9040403@gmail.com>
Message-ID: <1369560593.27719.67.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-05-26 at 07:38 +0200, Dirk Behme wrote:
> Am 23.05.2013 18:46, schrieb Kim Phillips:
> > Enable the compiler intrinsic for byte swapping on arch ARM.  This
> > allows the compiler to detect and be able to optimize out byte
> > swappings, and has a very modest benefit on vmlinux size (Linaro gcc
> > 4.8):
> 
> I'm no GCC tool chain expert, so I just have an understanding 
> question: Could anyone kindly give a brief explanation (*) of what the 
> advantage of this is on ARM?
> 
> http://comments.gmane.org/gmane.linux.kernel.cross-arch/16016
> 
> mentions "lwbrx/stwbrx on PowerPC, movbe on Atom". But for ARM?
> 
> I haven't understood yet why the __arch_swabXX() in 
> arch/arm/include/asm/swab.h [1] aren't sufficient? How can this be 
> done better? E.g. does anybody have a disassembly without/with this 
> change to illustrate that?

The point is just that the compiler gets to *see* what's happening.

See http://gcc.gnu.org/bugzilla/show_bug.cgi?id=55177 for a bunch of
examples of things that GCC ought to be able to optimise, even without
the CPU having load-and-swap instructions. Not that it always does;
hence the PR. But there are some that it does currently manage,
evidently.

You'll see this if you follow the link above, but as an example: imagine
a code sequence that goes load, swap, mask, swap, store.

With the swaps done by opaque inline asm, there's nothing the compiler
can do to optimise this. But if it *knows* what's going on, it can
optimise it into a single load, mask of a pre-byte-swapped constant, and
store.

Having said that, I can't actually answer your question ? I don't know
which optimisations the compiler *is* doing to provide the "modest
benefit" that Kim mentions; every class of optimisation I explicitly
checked for was missing. Again, hence the PR. But evidently it does
manage to get *something* right.

-- 
                Sent with Evolution's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130526/9c798d60/attachment-0001.bin>
