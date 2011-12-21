From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 21 Dec 2011 20:04:33 +0100
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <201112211727.17104.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <CAF6AEGtOjO6Z6yfHz-ZGz3+NuEMH2M-8=20U6+-xt-gv9XtzaQ@mail.gmail.com>
 <20111220171437.GC3883@phenom.ffwll.local>
 <201112211727.17104.arnd@arndb.de>
Message-ID: <20111221190433.GE3827@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 05:27:16PM +0000, Arnd Bergmann wrote:
> On Tuesday 20 December 2011, Daniel Vetter wrote:
> > It also sounds like that at least for proper userspace mmap support we'd
> > need some dma api extensions on at least arm, and that might take a while
> > ...
> 
> I think it's actually the opposite -- you'd need dma api extensions on
> everything else other than arm, which already has dma_mmap_coherent()
> and dma_mmap_writecombine() for this purpose.

Yeah, that's actually what I wanted to say, but failed at ... Another
thing is that at least for i915, _writecombine isn't what we want actually
because:
- It won't work anyway cause i915 maps stuff cached and does the flushing
  itself and x86 PAT doesn't support mixed mappings (kinda like arm).
- It isn't actually enough, there's another hidden buffer between the
  memory controller interface and the gpu that i915 manually flushes
  (because even a readback on a wc mapping doesn't flush things in there).

So I assume we'll have plenty of funny beating out a good api for cpu
access ;-)

Cheers, Daniel
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48
