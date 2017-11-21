From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Nov 2017 11:47:59 +0000
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <20171120210143.GD89108@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-17-samitolvanen@google.com>
 <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
 <CAKv+Gu-hnoeLqNsHbrLXv3xu7qsYB6REiwMtQYW_0CPwZ7jF4g@mail.gmail.com>
 <20171120210143.GD89108@samitolvanen.mtv.corp.google.com>
Message-ID: <20171121114759.tmmlagxi65s3nvit@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 01:01:43PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 20, 2017 at 03:25:31PM +0000, Ard Biesheuvel wrote:
> > However, under LTO this all changes, and it is no longer guaranteed
> > that the NEON registers are only touched between the kernel mode
> > neon begin/end calls.

Just to check, I take it that the feat is that LTO can merge the
begin/asm/end, reordering bits to the begin/end relative to the asm?

AFAICT, assuming that LTO respects our compiler barriers:

* the preempt_disable() in kernel_neon_begin() should prevent the asm
  block from being moved earlier, but it looks like it could be moved
  somewhere in the middle of local_bh_enable().

* the __this_cpu_xchg() in kernel_neon_end() *isn't* ordered w.r.t the
  asm, as it doesn't have a full memory clobber, and could be
  re-ordered before the asm block.

We *could* solve this case with a barrier() at the end of
kernel_neon_begin() and the start of kernel_neon_end(), but it is a
whack-a-mole solution. :/

... this also raises the question as to how the {__,}this_cpu*() ops are
expected to be ordered w.r.t. other local operations, as that's not
clear to me even in the absence of LTO.

> LTO operates on LLVM IR, so disabling LTO for this file should make
> sure there won't be any unsafe optimizations. Are there other places
> in the kernel that might have this issue?

I suspect that as above, there are a number of places that implicitly
rely on compilation-unit boundaries enforcing (local) ordering w.r.t.
asynchronous events, as the compiler won't otherwise be able to reorder
code such as cpu-local flag manipulation.

I think we have a much bigger problem here.

Thanks,
Mark.
