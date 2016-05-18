From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 22:25:03 +0200
Subject: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
In-Reply-To: <20160518175102.GX5783@n2100.arm.linux.org.uk>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <573C7844.5030107@ti.com> <20160518175102.GX5783@n2100.arm.linux.org.uk>
Message-ID: <3861017.ZJOlWYvEFT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 May 2016 18:51:02 Russell King - ARM Linux wrote:
> On Wed, May 18, 2016 at 09:12:20AM -0500, Dave Gerlach wrote:
> > Ok thank you for the pointer. I agree, the memremap API looks like a better
> > fit for this. I think it likely makes the most sense to still add these
> > ioremap_exec and ioremap_exec_nocache and then call them through the
> > memremap API based on new flags. This will fit into the current use model
> > for memremap as it currently uses all of the other ioremap calls internally,
> > and doing it how I just described will let this code evolve along with
> > memremap.
> 
> I would _really_ prefer not to do that.  Why?  Because IO memory does
> not have the required properties to be executable.  IO memory is normally
> memory which has side effects - and by side effects, I mean reading it
> can provoke hardware to perform some action.  You don't want to be
> executing from such memory.
> 
> So, in my mind, ioremap_exec makes absolutely no sense, and having it
> gives people a new interface to abuse - and abuse they will.

Agreed, calling it ioremap when it is really memremap makes no sense.

I also see another problem in the asm-generic portion:

+#ifndef ARCH_HAS_IOREMAP_EXEC
+#define ioremap_exec ioremap
+#define ioremap_exec_nocache ioremap_nocache
+#endif

The ARM version of ioremap_exec() that gets added in this patch is cached
(like memremap()), but then the asm-generic version is not? This is
even more confusing, it should at least do roughly the same thing across
architectures.

There should also be some documentation about what the expected behavior is, e.g.:

- is memremap_exec() by default cached or not? (I assume it would
  be like memremap())
- If we have an interface that does explicit uncached executable mapping,
  what about architectures on which this is not possible? Should they
  fall back to cached or non-executable, or cause a link error?  

	Arnd
