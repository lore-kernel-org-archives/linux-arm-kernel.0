From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 05 Apr 2018 18:43:05 +0000
Subject: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
In-Reply-To: <20180322235811.GC78232@google.com>
References: <20180322212705.141175-1-mka@chromium.org>
 <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
 <20180322224456.GB78232@google.com>
 <fc921bfb-1f49-08f9-515c-07bd442a1e11@google.com>
 <20180322235811.GC78232@google.com>
Message-ID: <CAKwvOdkcpxcP5Eb5f1-bJgU0gi4zkbof5WJWz2QbVCNsGBUO3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 4:58 PM Matthias Kaehlcke <mka@chromium.org> wrote:

> El Thu, Mar 22, 2018 at 04:19:42PM -0700 Greg Hackmann ha dit:
> > NAK.  There's a reason I didn't send my change upstream.
> >
> > As Marc pointed out (https://lkml.org/lkml/2018/3/16/987), the "r"
> > prefix tells gcc to pick the appropriate register width.  "x" makes it
> > unconditionally use the entire 64-bit register width.  Just swapping out
> > one for the other changes the macro's semantics.
> >
> > Unfortunately since this was breaking builds in android-4.14 and we
> > didn't have an immediate-term fix, I bit the bullet and added the above
> > commit -- but *only* as a short-term workaround.  For the one caller we
> > currently have in 4.14.y, gcc was using the entire 64-bit width for all
> > its inputs anyway, so "r" vs. "x" didn't make a difference.  But that
> > might not be true if/when someone introduces other SMCCC 1.1 callers.
> >
> > Unfortunately I don't see a better way to deal with this than waiting
> > for clang to support "r"-style constraints on ARM64.

> Thanks for the clarification! From the other thread
> (https://lkml.org/lkml/2018/3/1/268) I had the impression that ARM
> folks saw the option of a mergeable fix.

> Given the fact that clang support for kernel builds is still
> recent/WIP I guess it's not the end of the world if we have to raise
> the minimum clang version to 7.x for newer kernels.


Manoj fixed this in:
https://reviews.llvm.org/rL328829
https://bugs.llvm.org/show_bug.cgi?id=36862

Looks set to ride the Clang 6.0 train.  mka@ if you're planning another
state of the union email, it would be good to note the clang 6.0
requirement for arm64.

Is there anything left to do here?
-- 
Thanks,
~Nick Desaulniers
