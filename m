From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 Aug 2013 15:03:04 +0100
Subject: [RFC PATCH] types.h: use GCC supplied typedefs if appropriate
In-Reply-To: <CAKv+Gu99fC1n8sZCx7XykGEFsOjvSFcewvxZDMzspiu4dJmNbQ@mail.gmail.com>
References: <1375960010-4214-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130808174304.GA2356@localhost.localdomain>
 <CAKv+Gu99fC1n8sZCx7XykGEFsOjvSFcewvxZDMzspiu4dJmNbQ@mail.gmail.com>
Message-ID: <20130809140304.GB3977@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 08:39:45AM +0200, Ard Biesheuvel wrote:
> Hi Dave,
> 
> On 8 August 2013 19:43, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Aug 08, 2013 at 01:06:50PM +0200, Ard Biesheuvel wrote:
> >> GCC supplies a set of builtin defines that are meant to be used in the typedefs
> >> for types such as uint8_t, uint16_t etc. In fact, this is exactly what the
> >> stdint.h header does (of which GCC supplies its own version for freestanding
> >> builds). So in stdint.h, the types are defined as
> >>
> >> typedef __UINT16_TYPE__ uint16_t
> >> typedef __UINT32_TYPE__ uint32_t
> >>
> >> However, types.h in the kernel contains its own type definitions for these
> >> stdint.h types, and these do not depend on the GCC builtins.
> >>
> >> In the ARM world, both bare metal and glibc targeted versions of GCC are
> >> supported for building the kernel, and unfortunately, these do not agree on the
> >> definition of __UINT32_TYPE__ (likewise for __INT32_TYPE__ and __UINTPTR_TYPE__)
> >> - bare metal uses 'long unsigned int'
> >> - glibc GCC uses 'unsigned int'
> >>
> >> The result of this is that, while it is perfectly feasible in principle to
> >> support code that includes 'stdint.h' by compiling with -ffreestanding, (such as
> >> code using NEON intrinsics, whose header 'arm_neon.h' includes 'stdint.h'), in
> >> practice this breaks because we may end up with conflicting type definitions for
> >> uint32_t (and uintptr_t) depending on whether you are using bare metal GCC or
> >> glibc GCC.
> >>
> >> Arguably, this is a GCC issue because a) it does not pick up on the fact that
> >> 'typedef unsigned int uint32_t' and 'typedef long unsigned int uint32_t' are not
> >> in fact conflicting or b) it maintains this trivial difference between bare
> >> metal and glibc targeted build configs.
> >>
> >> However, even if I am aware that stdint.h support or matters related to it may
> >> be controversial subjects, fixing it in the kernel is not /that/ obtrusive, and
> >> solves matters for older GCCs as well, hence this RFC patch.
> >
> > This should go to LKML and linux-arch: if this change is no problem for
> > ARM, that doesn't mean that no other arch would be affected.
> >
> 
> I agree, but I thought I'd test the waters here first ...
> 
> > There are probably a few non-portable assumptions about the underlying
> > type of uint32_t floating about, particularly under drivers/ (use
> > of this type with printk would be the classic case).
> >
> 
> I did a quick test, and it actually triggers some errors on an
> allmodconfig 'make modules build'
> - Some caused by warnings promoted to errors by -Werror
> - Some by forward declarations and definitions using u32 in one place
> and uint32_t in the other

yeugh.  Ideally, u32 and uint32_t would have the same underlying type,
so changing just one of them is likely to cause headaches, but changing
the other causes headaches too...

> - And then a host of warnings originating all over the tree where
> uint32_t and u32 or unsigned int have been used interchangeably.

Hmmm, that's the kind of thing I was concerned about.

> I don't think it is feasible to fix all of this, so I am going to
> abandon this effort.
> In the particular case I am addressing (NEON intrinsics), there is a
> workaround possible which is to override the builtin definitions of
> __[U]INT32_TYPE__ and __UINTPTR_TYPE__ to those the kernel uses before
> including anything that includes stdint.h

If that works.  Do we not get problems with a conflict between the
type of the GCC builtin functions used by arm_neon.h, and our definition
of __UINT32_TYPE__ etc.?

Cheers
---Dave
