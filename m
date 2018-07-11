From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jul 2018 17:03:15 +0100
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
In-Reply-To: <20180711154758.4k2phfrzl2r5m34o@lakrids.cambridge.arm.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
 <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
 <20180711154758.4k2phfrzl2r5m34o@lakrids.cambridge.arm.com>
Message-ID: <20180711160315.GD18477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 04:47:58PM +0100, Mark Rutland wrote:
> On Wed, Jul 11, 2018 at 09:20:03AM +0200, Ard Biesheuvel wrote:
> > On 11 July 2018 at 03:09, Yandong.Zhao <yandong77520@gmail.com> wrote:
> > > diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> > > index fa8b3fe..784a8c2 100644
> > > --- a/arch/arm64/include/asm/simd.h
> > > +++ b/arch/arm64/include/asm/simd.h
> > > @@ -29,7 +29,8 @@
> > >  static __must_check inline bool may_use_simd(void)
> > >  {
> > >         /*
> > > -        * The raw_cpu_read() is racy if called with preemption enabled.
> > > +        * The this_cpu_read() is racy if called with preemption enabled,
> > > +        * since the task may subsequently migrate to another CPU.
> > >          * This is not a bug: kernel_neon_busy is only set when
> > >          * preemption is disabled, so we cannot migrate to another CPU
> > >          * while it is set, nor can we migrate to a CPU where it is set.
> 
> It would be nice if we could clarify the "is racy" part here.
> 
> How about:
> 
> 	/*
> 	 * kernel_neon_busy is only set while preemption is disabled,
> 	 * and is clear whenever preemption is enabled. Since
> 	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
> 	 * cannot change under our feet -- if it's set we cannot be
> 	 * migrated, and if it's clear we cannot be migrated to a CPU
> 	 * where it is set.
> 	 */
> 
> With that:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm..com>

Thanks. Applied with the updated comment and your tag..

Will
