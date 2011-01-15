From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 12:38:17 +0000
Subject: [GIT PULL v3] pxa: patches for v2.6.38-rc
In-Reply-To: <AANLkTi=AtkMc90K8C9qrKaVqdLyuHE9SXyugkkX8HEeS@mail.gmail.com>
References: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
	<20110114173147.GK15996@n2100.arm.linux.org.uk>
	<20110114214900.GP15996@n2100.arm.linux.org.uk>
	<AANLkTi=AtkMc90K8C9qrKaVqdLyuHE9SXyugkkX8HEeS@mail.gmail.com>
Message-ID: <20110115123817.GZ15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 06:20:06AM -0600, Eric Miao wrote:
> > I also need to remove asm/pgtable.h from arch/arm/mach-pxa/generic.c:
> > ?CC ? ? ?arch/arm/mach-pxa/generic.o
> > In file included from arch/arm/include/asm/pgtable.h:461,
> > ? ? ? ? ? ? ? ? from arch/arm/mach-pxa/generic.c:26:
> > include/asm-generic/pgtable.h: In function ?ptep_test_and_clear_young?:
> > include/asm-generic/pgtable.h:29: error: dereferencing pointer to incomplete type
> >
> 
> This didn't happen on my side. Maybe it's due to some change
> not yet merged into devel-stable?

I sent a follow-up patch to it - see "[PATCH] Fix latest regression - pgtable.h"

> > and I also got:
> > arch/arm/mach-pxa/tosa-bt.c: In function ?tosa_bt_probe?:
> > arch/arm/mach-pxa/tosa-bt.c:84: error: implicit declaration of function ?rfkill_set_led_trigger_name?
> >
> 
> This is going to be tricky now. The rfkill_set_led_trigger_name() has been
> removed somehow as dead code along with several others in commit 2e48928,
> apparently the patch author didn't notice it's existing usage, not only in
> tosa-bt.c but arch/arm/mach-s3c2410/h1940-bluetooth.c.
> 
> There are two options:
> 
> 1) remove the invocation completely, and rfkill_register() will just use
> the dev_name(), which is of form 'rfkill%u', as the name for the led trigger.
> But this is going to change the name of user space as well, which is what
> we want to avoid.
> 
> 2) or revert that 'removing dead code' commit. The function is simple
> enough though, but since 'struct rfkill' is declared somehow within the
> net/rfkill/core.c file, there has to be some function to initialize that.
> 
> Now, my personal preference would be to postpone the proper fix for this
> issue into -rc?.

Okay, let's defer this until it can be discussed with Stephen Hemminger.
