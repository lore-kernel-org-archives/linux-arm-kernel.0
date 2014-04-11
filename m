From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 11 Apr 2014 08:42:53 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411145625.GA27493@redhat.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com>
Message-ID: <CA+55aFzqxmJOaMmGCbhYyYFXC_ok18dsD8c7EwUFeJ_g2d04Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 7:56 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> First of all: I do not pretend I really understand the problems with
> icache/etc coherency and how flush_icache_range() actually works on
> alpha. Help.

According to the alpha architecture rules, the instruction cache can
be completely virtual, and is not only not coherent with the data
cache, it's not even necessarily coherent with TLB mapping changes (ie
it's purely virtual, and you need to flush it if you change
instruction mappings). The virtual caches do have an address space
number, so you can have multiple separate virtual address spaces.

The way to flush it is with the "imb" instruction (which is not
actually an instruction at all, it's a jump to PAL-code, alpha's
"explicit microcode")

That means that when you modify data that could be code, you do need
to do an "imb" _and_ you do need to do it cross-cpu even for
thread-local cases in case your thread migrates to another CPU with
stale I$ data (the ASN will be the same). You can use the usual VM
cpu-mask to tell which other CPU's you'd need to do it on, though.

But alpha does not need page or addr/len, because "imb" is "make the
whole instruction cache coherent".

Your patch looks correct for alpha, afaik.

               Linus
