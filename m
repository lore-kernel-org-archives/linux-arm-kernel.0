From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 16:33:11 +0000
Subject: [PATCH v2] xen/events: Always allocate legacy interrupts on PV
 guests
In-Reply-To: <564F3F4D.9080005@oracle.com>
References: <1447870445-17199-1-git-send-email-boris.ostrovsky@oracle.com>
 <alpine.DEB.2.02.1511201117120.1107@kaball.uk.xensource.com>
 <564F397A.8010203@oracle.com>
 <alpine.DEB.2.02.1511201535550.1107@kaball.uk.xensource.com>
 <564F3F4D.9080005@oracle.com>
Message-ID: <alpine.DEB.2.02.1511201632390.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015, Boris Ostrovsky wrote:
> On 11/20/2015 10:36 AM, Stefano Stabellini wrote:
> > On Fri, 20 Nov 2015, Boris Ostrovsky wrote:
> > > On 11/20/2015 06:24 AM, Stefano Stabellini wrote:
> > > > On Wed, 18 Nov 2015, Boris Ostrovsky wrote:
> > > > > After commit 8c058b0b9c34 ("x86/irq: Probe for PIC presence before
> > > > > allocating descs for legacy IRQs") early_irq_init() will no longer
> > > > > preallocate descriptors for legacy interrupts if PIC does not
> > > > > exist, which is the case for Xen PV guests.
> > > > > 
> > > > > Therefore we may need to allocate those descriptors ourselves.
> > > > > 
> > > > > Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > > You need to do this for arm64 too.
> > > > 
> > > > FYI you can download arm64 cross-compilers from
> > > > https://releases.linaro.org/14.04/components/toolchain/binaries/
> > > > then you can use them by exporting ARCH=arm64 and
> > > > CROSS_COMPILE=/path/to/gcc-linaro-aarch64-linux-gnu-version/bin/aarch64-linux-gnu-
> > > I did test on arm but didn't realize that arm64 uses different include
> > > files.
> > > 
> > > Does arm64 not have any legacy interrupts?
> > > 
> > > BTW, I got this build error:
> > > 
> > >    STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
> > > 0000000000000000 R_AARCH64_ABS64   __efistub_sort
> > > 0000000000000008 R_AARCH64_ABS64   .init__ksymtab_strings
> > > drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references
> > > not
> > > allowed in the EFI stub
> > > drivers/firmware/efi/libstub/Makefile:63: recipe for target
> > > 'drivers/firmware/efi/libstub/lib-sort.stub.o' failed
> > > make[4]: *** [drivers/firmware/efi/libstub/lib-sort.stub.o] Error 1
> > > scripts/Makefile.build:403: recipe for target
> > > 'drivers/firmware/efi/libstub'
> > > failed
> > > make[3]: *** [drivers/firmware/efi/libstub] Error 2
> > > scripts/Makefile.build:403: recipe for target 'drivers/firmware/efi'
> > > failed
> > > make[2]: *** [drivers/firmware/efi] Error 2
> > > scripts/Makefile.build:403: recipe for target 'drivers/firmware' failed
> > > make[1]: *** [drivers/firmware] Error 2
> > > Makefile:943: recipe for target 'drivers' failed
> > > make: *** [drivers] Error 2
> > > 
> > > I worked around this by removing some of EFI config options but presumably
> > > this needs to be properly fixed.
> > Interesting. This build error could be something new. Could you please
> > post your kernel config?
> 
> Attached.
> 
> This, BTW, is on a relatively old toolstack:
> gcc version 4.8.2 20131014 (prerelease) (crosstool-NG
> linaro-1.13.1-4.8-2013.10 - Linaro GCC 2013.10)

Interesting. I cannot repro the error with Linaro GCC 4.9-2014.
