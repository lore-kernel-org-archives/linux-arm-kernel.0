From: msalter@redhat.com (Mark Salter)
Date: Tue, 18 Mar 2014 10:16:49 -0400
Subject: [PATCH v2 13/15] arm64: add EFI runtime services
In-Reply-To: <20140318123418.GH13200@arm.com>
References: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
 <1394750828-16351-14-git-send-email-leif.lindholm@linaro.org>
 <20140318123418.GH13200@arm.com>
Message-ID: <1395152209.2967.3.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-18 at 12:34 +0000, Catalin Marinas wrote:
> On Thu, Mar 13, 2014 at 10:47:06PM +0000, Leif Lindholm wrote:
> > --- /dev/null
> > +++ b/arch/arm64/kernel/efi.c
> [...]
> > +/*
> > + * Called from setup_arch with interrupts disabled.
> > + */
> > +void __init efi_enter_virtual_mode(void)
> [...]
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -902,6 +902,10 @@ static noinline void __init kernel_init_freeable(void)
> >         smp_prepare_cpus(setup_max_cpus);
> > 
> >         do_pre_smp_initcalls();
> > +
> > +       if (IS_ENABLED(CONFIG_ARM64) && efi_enabled(EFI_BOOT))
> > +               efi_enter_virtual_mode();
> 
> The comment for the efi_enter_virtual_mode() function says "called from
> setup_arch with interrupts disabled". None of these are true for the
> call above (and I would really prefer an arch call than this arm64
> conditional call in init/main.c.
> 

Right, the call changed to later in boot but the comment didn't. Calling
from setup_arch is too early. But an early_initcall would work and would
get rid of the ugly CONFIG_ARM64 test.
