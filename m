From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 23:52:09 +0100
Subject: [PATCH] ARM: Enable I$/D$/BrPredict based on config
In-Reply-To: <CAG_NtY_sf6Et2F7kFdUT8=M7W51T5-qQxziG-iKCjY7R890enw@mail.gmail.com>
References: <1336078825-9810-1-git-send-email-bryan.buckley@ti.com>
 <yw1xfwbgc3ab.fsf@unicorn.mansr.com>
 <CAG_NtY_sf6Et2F7kFdUT8=M7W51T5-qQxziG-iKCjY7R890enw@mail.gmail.com>
Message-ID: <20120503225209.GI897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 05:48:33PM -0500, Buckley, Bryan wrote:
> On Thu, May 3, 2012 at 5:23 PM, M?ns Rullg?rd <mans@mansr.com> wrote:
> >
> > Bryan Buckley <bryan.buckley@ti.com> writes:
> >
> > > Currently we only disable these bits based on config. Now we will
> > > use this config option to explicitly enable these features at this
> > > point regardless of what bootloader, other SW, or HW did before.
> > >
> > > Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>
> > > ---
> > > ?arch/arm/kernel/head.S | ? ?6 ++++++
> > > ?1 files changed, 6 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > > index 3bf0c7f..cec0de5 100644
> > > --- a/arch/arm/kernel/head.S
> > > +++ b/arch/arm/kernel/head.S
> > > @@ -411,12 +411,18 @@ __enable_mmu:
> > > ?#endif
> > > ?#ifdef CONFIG_CPU_DCACHE_DISABLE
> > > ? ? ? bic ? ? r0, r0, #CR_C
> > > +#else
> > > + ? ? orr ? ? r0, r0, #CR_C
> > > ?#endif
> > > ?#ifdef CONFIG_CPU_BPREDICT_DISABLE
> > > ? ? ? bic ? ? r0, r0, #CR_Z
> > > +#else
> > > + ? ? orr ? ? r0, r0, #CR_Z
> > > ?#endif
> > > ?#ifdef CONFIG_CPU_ICACHE_DISABLE
> > > ? ? ? bic ? ? r0, r0, #CR_I
> > > +#else
> > > + ? ? orr ? ? r0, r0, #CR_I
> > > ?#endif
> > > ?#ifdef CONFIG_ARM_LPAE
> > > ? ? ? mov ? ? r5, #0
> > > --
> >
> > Caches and branch predictors may require implementation defined
> > invalidation before being enabled.
> 
> True.. I was relying on going through arch/arm/boot/compressed/head.S
> to do that for me. Was that unreasonable?

Yes, because that may not always be used.

Where that _is_ dealt with is in the CPU specific setup assembly code,
just as providing the CPU specific default value for the CPU control
register in r0 is done.
