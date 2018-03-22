From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 22 Mar 2018 16:58:11 -0700
Subject: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
In-Reply-To: <fc921bfb-1f49-08f9-515c-07bd442a1e11@google.com>
References: <20180322212705.141175-1-mka@chromium.org>
 <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
 <20180322224456.GB78232@google.com>
 <fc921bfb-1f49-08f9-515c-07bd442a1e11@google.com>
Message-ID: <20180322235811.GC78232@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Mar 22, 2018 at 04:19:42PM -0700 Greg Hackmann ha dit:

> On 03/22/2018 03:44 PM, Matthias Kaehlcke wrote:
> > El Thu, Mar 22, 2018 at 10:26:18PM +0000 Nick Desaulniers ha dit:
> > 
> >> Note that a patch in this form has previously been implemented by:
> >>
> >> Andrey Konovalov <andreyknvl@google.com>:
> >> https://gist.github.com/xairy/ee11682ea86044a45c0291c528cd936f
> >>
> >> and another by:
> >>
> >> Greg Hackmann <ghackmann@google.com>:
> >> https://android-review.googlesource.com/c/kernel/common/+/645181
> >>
> >> If you used either as a reference, you may want to credit them with a
> >> `Suggested-by:` in the commit message.
> > 
> > Not really, but I think I prefer Greg's version over mine and might
> > use it in a respin if nobody raises objections.
> 
> NAK.  There's a reason I didn't send my change upstream.
> 
> As Marc pointed out (https://lkml.org/lkml/2018/3/16/987), the "r"
> prefix tells gcc to pick the appropriate register width.  "x" makes it
> unconditionally use the entire 64-bit register width.  Just swapping out
> one for the other changes the macro's semantics.
> 
> Unfortunately since this was breaking builds in android-4.14 and we
> didn't have an immediate-term fix, I bit the bullet and added the above
> commit -- but *only* as a short-term workaround.  For the one caller we
> currently have in 4.14.y, gcc was using the entire 64-bit width for all
> its inputs anyway, so "r" vs. "x" didn't make a difference.  But that
> might not be true if/when someone introduces other SMCCC 1.1 callers.
> 
> Unfortunately I don't see a better way to deal with this than waiting
> for clang to support "r"-style constraints on ARM64.

Thanks for the clarification! From the other thread
(https://lkml.org/lkml/2018/3/1/268) I had the impression that ARM
folks saw the option of a mergeable fix.

Given the fact that clang support for kernel builds is still
recent/WIP I guess it's not the end of the world if we have to raise
the minimum clang version to 7.x for newer kernels.
