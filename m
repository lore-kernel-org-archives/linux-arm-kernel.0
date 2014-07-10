From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 10 Jul 2014 19:14:49 +0100
Subject: [PATCH v2] efi: implement mandatory locking for UEFI Runtime
 Services
In-Reply-To: <CAKv+Gu86W0hBEZhz_Aw07TmRHv8kgQN7JeRMC0Qs6FL0m6BrOQ@mail.gmail.com>
References: <1404818508-17537-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu86W0hBEZhz_Aw07TmRHv8kgQN7JeRMC0Qs6FL0m6BrOQ@mail.gmail.com>
Message-ID: <20140710181449.GI15932@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Jul, at 01:23:55PM, Ard Biesheuvel wrote:
> On 8 July 2014 13:21, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > According to section 7.1 of the UEFI spec, Runtime Services are not fully
> > reentrant, and there are particular combinations of calls that need to be
> > serialized.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >
> > So this is v2 of the UEFI Runtime Services serialization patch: this time, I use
> > a single spinlock rather than a set of mutexes, resulting in all services to be
> > serialized with respect to all others. Also added handling of NMI state, as this
> > results in some of the restrictions being lifted (x86, ia64 only)
> >
> > One question remains: with the NMI deadlock handling in place, is it really
> > necessary to disable interrupts in all cases?
> >
> 
> I omitted this hunk from the patch by accident:

I'm seeing the following build warning with this patch,

In file included from include/linux/seqlock.h:35:0,
                 from include/linux/time.h:5,
                 from include/linux/efi.h:16,
                 from drivers/firmware/efi/runtime-wrappers.c:18:
drivers/firmware/efi/runtime-wrappers.c: In function ?virt_efi_query_capsule_caps?:
include/linux/spinlock.h:358:2: warning: ?flags? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/firmware/efi/runtime-wrappers.c:275:16: note: ?flags? was declared here

You'll need to cache the value of efi_in_nmi() in a local variable.

That should be safe, since if we're not executing in NMI context when we
enter the function we won't be executing in NMI context at any point in
during function. It's just that gcc can't infer that information.

-- 
Matt Fleming, Intel Open Source Technology Center
