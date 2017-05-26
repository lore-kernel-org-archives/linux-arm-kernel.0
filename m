From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 26 May 2017 18:59:48 +0100
Subject: may_use_simd on aarch64, chacha20
In-Reply-To: <CAKv+Gu_RqVKjK5nh=qFb8OrkazSGEcjJiHnLS5c7j18=GehywQ@mail.gmail.com>
References: <CAHmME9qH=Wu-=9YUmxi7NPrczHu1UrB7phG0y68ipB+ProQ2TA@mail.gmail.com>
 <4150EFDC-CD3A-4C5C-9EF7-689F63C142C2@linaro.org>
 <20170526132808.GP3559@e103592.cambridge.arm.com>
 <CAKv+Gu_RqVKjK5nh=qFb8OrkazSGEcjJiHnLS5c7j18=GehywQ@mail.gmail.com>
Message-ID: <20170526175948.GQ3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 07:44:46PM +0200, Ard Biesheuvel wrote:
> On 26 May 2017 at 15:28, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Sun, May 21, 2017 at 10:55:20PM +0200, Ard Biesheuvel wrote:
> >> (+ Dave)

[...]

> >> > Lastly, APIs like pcrypts and padata execute with bottom halves
> >> > disabled, even though their actual execution environment is process
> >> > context, via a workqueue. Thus, here, in_interrupt() will always be
> >> > true, even though this is likely a place where we want to use simd.
> >> > Question 3: is there something better that could be done?
> >>
> >> I guess we should switch to in_serving_softirq() instead.
> >
> > For context, the arm64 kernel-mode NEON refactoring I've been working
> > on [1] defines may_use_simd() to indicate whether calling
> > kernel_neon_begin() is safe or not, rather then being a hint about
> > whether it is desirable to do so.
> >
> 
> I should mention again, perhaps redundantly, that may_use_simd() was
> not intended as a hint. It only became this way after we removed the
> limitation on arm64 that SIMD may only be used in process context.

My current may_use_simd() is intended to have those non-hint semantics
-- however, it feels a bit odd to have to include an extra header just
for that, when clients of kernel-mode NEON are necessarily not portable.

I don't have a very strong feeling either way, though.

> > This changes the definition of may_use_simd() to something that is
> > probably appropriate for your scenario.  From process context without
> > any outer kernel_neon_begin()...kernel_neon_end(), it should return
> > true.
> >
> > In general, callers in any context should do something like:
> >
> >         if (may_use_simd()) {
> >                 kernel_neon_begin();
> >                 /* SIMD implementation */
> >                 kernel_neon_end();
> >         } else {
> >                 /* fallback implementation, or defer to another context */
> >         }
> >
> > Even from task context where may_use_simd() should always return true
> > and thus where the fallback path can be omitted, it may be a good idea
> > to do something like
> >
> >         if (!may_use_simd()) {
> >                 WARN_ON(1);
> >                 return -EBUSY;
> >         }
> >
> > ... or similar.
> >
> 
> I don't think it is generally a good idea to make inferences about
> whether may_use_simd() is going to return true or false in code that
> is not tightly coupled to the FP/SIMD arch code itself, although I do
> understand that there may be cases where it is cumbersome to provide a
> fallback, especially if you know it is never going to be used.

Agreed.  I don't think we should encourage this, but I thought it worth
illustrating.  Hopefully there are few if any real situations where this
would be justified.

Cheers
---Dave
