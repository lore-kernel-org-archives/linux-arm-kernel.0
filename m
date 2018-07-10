From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 15:16:37 +0100
Subject: [PATCH v3] arm64: add ARM64-specific support for flatmem
In-Reply-To: <CAK8P3a2ss5tYve6xL7eE50ev3zVPOHzN5QtroWYmTih0F3sQYQ@mail.gmail.com>
References: <20180706174724.44594-1-nkela@cisco.com>
 <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
 <20180710130650.GD31318@arm.com>
 <CAK8P3a2ss5tYve6xL7eE50ev3zVPOHzN5QtroWYmTih0F3sQYQ@mail.gmail.com>
Message-ID: <20180710141637.GB9022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 03:25:14PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 10, 2018 at 3:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 10, 2018 at 02:55:41PM +0200, Arnd Bergmann wrote:
> >> On Fri, Jul 6, 2018 at 7:47 PM, Nikunj Kela <nkela@cisco.com> wrote:
> >> > Flatmem is useful in reducing kernel memory usage.
> >> > One usecase is in kdump kernel. We are able to save
> >> > ~14M by moving to flatmem scheme.
> >> >
> >> > Cc: xe-kernel at external.cisco.com
> >> > Cc: Nikunj Kela <nkela@cisco.com>
> >> > Signed-off-by: Nikunj Kela <nkela@cisco.com>
> >> > ---
> >> >  arch/arm64/Kconfig | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> > index 42c090c..f5b4c49 100644
> >> > --- a/arch/arm64/Kconfig
> >> > +++ b/arch/arm64/Kconfig
> >> > @@ -775,6 +775,9 @@ config ARCH_SPARSEMEM_DEFAULT
> >> >  config ARCH_SELECT_MEMORY_MODEL
> >> >         def_bool ARCH_SPARSEMEM_ENABLE
> >> >
> >> > +config ARCH_FLATMEM_ENABLE
> >> > +       def_bool y
> >> > +
> >> >  config HAVE_ARCH_PFN_VALID
> >> >         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> >> >
> >>
> >> I'm getting hundreds of errors in randconfig builds with this:
> >
> > Damn, I was worried something like this might happen. Sorry!
> >
> > Does randconfig also fuzz CONFIG_EXPERT? We only added ARCH_FLATMEM_ENABLE
> > so that people can hand-configure crashkernels to make them small; there will
> > be plenty of situations where it's just going to cause more problems than it
> > solves, so I'd be happy hiding it behind EXPERT if it helps.
> 
> Yes, randconfig also tests EXPERT and COMPILE_TEST configurations, though I
> don't test the !COMPILE_TEST ones myself, so you can also hide options from
> me by making them 'depends on !COMPILE_TEST'.
> 
> > Otherwise we can probably through a 'def_bool !NUMA' at it.
> 
> Yes, I was going to send a patch with that next after testing it some more.
> So far it's holding up. This is also what some other architectures have, so
> it's probably safe.

Ok, let's go with that then. If I don't see a patch from you in a day or
two, I'll write one myself :)

Will
