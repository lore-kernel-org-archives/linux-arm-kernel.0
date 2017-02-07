From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Feb 2017 18:52:55 +0000
Subject: [PATCH] arm64: uaccess: consistently check object sizes
In-Reply-To: <CAGXu5jJ2UR4FVikrFgmkNEL81LYr+Htw0OokZFmfJEKq5BuQOQ@mail.gmail.com>
References: <1486470835-25956-1-git-send-email-mark.rutland@arm.com>
 <CAGXu5jJ2UR4FVikrFgmkNEL81LYr+Htw0OokZFmfJEKq5BuQOQ@mail.gmail.com>
Message-ID: <20170207185255.GF26173@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 10:27:52AM -0800, Kees Cook wrote:
> On Tue, Feb 7, 2017 at 4:33 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Currently in arm64's copy_{to,from}_user, we only check the
> > source/destination object size if access_ok() tells us the user access
> > is permissible.
> >
> > However, in copy_from_user() we'll subsequently zero any remainder on
> > the destination object. If we failed the access_ok() check, that applies
> > to the whole object size, which we didn't check.
> >
> > To ensure that we catch that case, this patch hoists check_object_size()
> > to the start of copy_from_user(), matching __copy_from_user() and
> > __copy_to_user(). To make all of our uaccess copy primitives consistent,
> > the same is done to copy_to_user().
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Kees, Was there any rationale for not handling the !access_ok() case?
> 
> So, when I pulled the similar code for other architectures out of PaX,
> I retained this pattern. When I reworked x86 and added arm64, it
> seemed sensible to optimize the check to follow access_ok(), since if
> that failed, why do the checking work... but yes, in copy_from_user(),
> we'll wipe the destination without having done the check. Ewww.
> Excellent catch.

Can I take that as an Acked-by?

FWIW, longer term I'd love to fold that and the KASAN checks into the
core uaccess headers, so that we consistently apply them everywhere. If
Al is done reworking the uaccess code, I can have another look.

> > I note that other architectures follow the same pattern, and may need a similar
> > fixup.
> 
> I would agree. It will need some fiddling, though. If you look at ARM,
> it's implicitly after the access_ok() check because
> check_object_size() is only run in __copy_*_user().
> 
> (I still think the whole memset(to, 0, n) thing is a bit dangerous...
> it's kind of a "write 0 anywhere" primitive if an attacker can control
> the kernel address at all...)

If the user can control the kernel address, it's an arbitrary write if
access_ok() succeeds, so we've lost regardless.

The zeroing of the buffer is itself is attempting to minimise the impact
of buffers not being fully initialised by a copy_from_user, so removing
it would open another class of issue.

Thanks,
Mark.
