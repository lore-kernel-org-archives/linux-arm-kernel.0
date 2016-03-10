From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 10 Mar 2016 14:49:08 +0000
Subject: [PATCH 6/8] efi/arm*: libstub: wire up GOP handling into the ARM
 UEFI stub
In-Reply-To: <CAKv+Gu9ephpDq_KE_xxV+dXSit+VgBxqgXyAeKt4eXpb5KRJnw@mail.gmail.com>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
 <1457588408-19309-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160310082522.GB8618@gmail.com>
 <CAKv+Gu8hTSbZVgGj6epquwf6kkSJV+imAFvNobowFVtB5AUe2Q@mail.gmail.com>
 <20160310090345.GA19834@gmail.com>
 <CAKv+Gu_rtQjWJ-=Nf-dEYEHVB5dwKMA_Mv2rVujBz9t=3qnUrA@mail.gmail.com>
 <20160310092552.GA19588@gmail.com>
 <CAKv+Gu9ephpDq_KE_xxV+dXSit+VgBxqgXyAeKt4eXpb5KRJnw@mail.gmail.com>
Message-ID: <20160310144908.GG15775@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Mar, at 05:25:08PM, Ard Biesheuvel wrote:
> 
> Indeed. I think the efi_early struct is a separate structure that is
> set up by the early boot code, and has a number of function pointers
> of EFI boot services copied into it. Matt should know the details.
 
If you look at where the efi_early stuff came from originally, you'll
see it was merged as part of the mixed mode code for running 64-bit
kernels on 32-bit EFI,

commit 54b52d872680
Author: Matt Fleming <matt.fleming@intel.com>
Date:   Fri Jan 10 15:27:14 2014 +0000

    x86/efi: Build our own EFI services pointer table
    
    It's not possible to dereference the EFI System table directly when
    booting a 64-bit kernel on a 32-bit EFI firmware because the size of
    pointers don't match.
    
    In preparation for supporting the above use case, build a list of
    function pointers on boot so that callers don't have to worry about
    converting pointer sizes through multiple levels of indirection.
    
    Signed-off-by: Matt Fleming <matt.fleming@intel.com>


You basically cannot ever dereference a pointer in that mode, it's
crazy.
 
The subsequent efi_early() wrapper came when some of the EFI boot stub
code was migrated out of arch/x86 into drivers/firmware/efi/libstub.

I'm not suggesting it's the most beautiful code in the world, far from
it. It is a massive eyesore that has resulted in type bugs in the past
because of all the casting.

I've just never come up with a cleanup patch series that I was happy
with.

> > Furthermore, my suggestion would work with arbitrarily structured thunking: my
> > suggestion was to put a typed C layer in there - and the layer itself could then
> > call the vararg construct internally. It's a C type demuxing, only a syntactic
> > effort, it does not change any real call signature.
> >
> 
> I would welcome any improvement in this regard. Happy to contribute as well.
 
The only way I think a typed C layer would be maintainable is if it
was automatically generated. We're already suffering from the
multitude of different bitness functions, i.e. __setup_efi_pci32() vs
__setup_efi_pci64().
