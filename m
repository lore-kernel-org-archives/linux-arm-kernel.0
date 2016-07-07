From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jul 2016 13:19:26 -0400
Subject: [PATCH 4/9] arm64/uaccess: Enable hardened usercopy
In-Reply-To: <20160707100717.GB8306@leverpostej>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-5-git-send-email-keescook@chromium.org>
 <20160707100717.GB8306@leverpostej>
Message-ID: <CAGXu5jLeH2KL+FVi7mxBF5oH2-zMfwSY=2ReJOL4JYsQuJKy6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2016 at 6:07 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Jul 06, 2016 at 03:25:23PM -0700, Kees Cook wrote:
>> Enables CONFIG_HARDENED_USERCOPY checks on arm64. As done by KASAN in -next,
>> renames the low-level functions to __arch_copy_*_user() so a static inline
>> can do additional work before the copy.
>
> The checks themselves look fine, but as with the KASAN checks, it seems
> a shame that this logic is duplicated per arch, integrated in subtly
> different ways.
>
> Can we not __arch prefix all the arch uaccess helpers, and place
> kasan_check_*() and check_object_size() calls in generic wrappers?
>
> If we're going to update all the arch uaccess helpers anyway, doing that
> would make it easier to fix things up, or to add new checks in future.

Yeah, I totally agree, and my work on the next step of this hardening
will require something like this to separate the "check" logic from
the "copy" logic, as I want to introduce a set of constant-sized
copy_*_user helpers.

Though currently x86 poses a weird problem in this regard (they have
separate code paths for copy_* and __copy*, but I think it's actually
a harmless(?) mistake.

For now, I'd like to leave this as-is, and then do the copy_* cleanup,
then do step 2 (slab whitelisting).

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
