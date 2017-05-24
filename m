From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 24 May 2017 13:33:20 +0000
Subject: [PATCH 0/2] ioremap_wc on arm64
In-Reply-To: <20170523140824.GC5948@e104818-lin.cambridge.arm.com>
References: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
 <20170522085615.GC30129@e104818-lin.cambridge.arm.com>
 <20170522115349.GA82957@localhost> <20170522122236.GG1107@arm.com>
 <20170522142059.GA83004@localhost>
 <20170522154947.GF30129@e104818-lin.cambridge.arm.com>
 <20170523100903.GA4562@localhost>
 <20170523140824.GC5948@e104818-lin.cambridge.arm.com>
Message-ID: <20170524131054.GA5647@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 03:08:24PM +0100, Catalin Marinas wrote:
> On Tue, May 23, 2017 at 10:09:03AM +0000, Jayachandran C wrote:
> > On Mon, May 22, 2017 at 04:49:47PM +0100, Catalin Marinas wrote:
> > > On Mon, May 22, 2017 at 02:21:00PM +0000, Jayachandran C wrote:
> > > > On Mon, May 22, 2017 at 01:22:37PM +0100, Will Deacon wrote:
> > > > > I think it was used for framebuffers. Note that using normal-NC also aligns
> > > > > with arch/arm/ and, since normal-NC is strictly a more relaxed memory type
> > > > > than Device-GRE, I'm really not keen making on this change.
> > > > 
> > > > Even if that is the case, having Normal attribute for ioremap just for
> > > > ioremap_wc is inconsistent. The Device Gathering attribute by its definition
> > > > is exactly what write combining requires. The memremap() API looks like a
> > > > better way to expose Normal-NC mapping (with additional features like
> > > > speculation etc.) if implemented correctly.
> > > 
> > > I agree, memremap() is a better way but this was merged in 4.3 while
> > > ioremap_wc() had been around for a long time. If you want to change its
> > > semantics, you'd need to go through all its uses in the kernel and make
> > > sure they *only* use I/O accessors with such memory. At a quick grep,
> > > there are several places where the __iomem pointer attribute is dropped
> > > shortly after ioremap() and the pointer is accessed directly. That's
> > > where things will break with Device GRE memory since the compiler
> > > doesn't guarantee aligned accesses.
> > 
> > There is a difference in behavior with regard to unaligned access between
> > ioremap_wc and ioremap already. I don't follow why unaligned access has to
> > supported for ioremap_wc but not for ioremap - it would be much better to
> > be consistent here.
> 
> Please re-read my paragraph above.

I had the same feeling after seeing your reply :)

> It's nice if both ioremap_wc() and
> ioremap() returned Device memory as long as you fix the ioremap_wc()
> misuses throughout the kernel.

ioremap and ioremap_wc is been used and abused in multiple places after
dropping the __iomem annotation, and it is not an easy task to figure
out where unaligned access is done on the pointer returned. I am told
specifically that in ioremap_wc needs to support unaligned access as
opposed to ioremap.

I am trying to figure out if there are specific cases you expect it to
fail. Since arm64 is a fairly new architecture and it will be easy
to get this correct now, rather than to let the status quo continue.

There is no "Gather" attribute on arm, so using "Normal uncached" for
ioremap_wc is understandable. On arm64, given that there is an attribute
specifically for write combining - you have decided to go with Normal
uncached. I had hoped for a proper reason for that and not a vague
"maybe framebuffer, go grep the kernel and figure out" response.

> > > > Also, patch 1/2 should be useful anyway - can that be picked up?
> > > 
> > > The patch is harmless but are we going to have a user of Device_GRE?
> > 
> > This patch would make the attribute in MAIR and the index MT_DEVICE_GRE
> > useful for __ioremap. Otherwise I don't see the use in having the
> > attribute at  all. I can at least give this to people who want Device GRE
> > mapping, which is the fastest way to access device memory on ThunderX2.
> 
> Is this a driver that's going to be used on arm64 kernels only? I'm not
> that keen on __ioremap() since it's not a standard driver API, so you
> end up with #ifdef CONFIG_ARM64 in the driver code.

FWIW, __ioremap() is EXPORT_SYMBOL. Having the attribute will be useful.

JC.
