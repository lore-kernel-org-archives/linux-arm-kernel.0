From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Wed, 14 Nov 2012 10:18:31 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <20121113170711.GI28327@n2100.arm.linux.org.uk>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113170711.GI28327@n2100.arm.linux.org.uk>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1E29@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> Sent: Tuesday, November 13, 2012 6:07 PM
> 
> Right, so, what this tells me is that the implementation of the spinlock 
> in the secure software is potentially the same as the kernel's spinlock.
> The kernel's spinlock implementation is GPL'd.  If the secure side spinlock 
> implementation is a copy of the kernel's spinlock implementation, then 
> that implementation is also GPL'd (...).
> 
> I think someone has some explaining to do.

It does.

The TZ implementation of the shared mutex is the ARM native mutex instructions set LDREX/STREX, protected by a native ARM IRQ disabling.
I believe this is native ARMv7 natural handling and not subject to GPLization.

This is why the mutex added for TZ shared of L2 cache maintenance is a "arch_spinlock". It assumes linux handles the spinlock as a native ARM native mutex DDR cell, handled from the ARMv7-A LDREX/STREX.
I think this is the weakest part of the driver since they is no insurance that linux pristine arch_spinlock will not evolve into something else (i.e features in raw_spinclock).

etienne

-----Original Message-----
To: Etienne CARRIERE
Cc: linux-arm-kernel at lists.infradead.org; Will Deacon; Marc Zyngier; Catalin Marinas; Linus Walleij (linus.walleij at linaro.org); Rabin VINCENT; Srinidhi KASAGAR
Subject: Re: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ

On Tue, Nov 13, 2012 at 05:08:14PM +0100, Etienne CARRIERE wrote:
> From: Etienne Carriere <etienne.carriere@stericsson.com>
> 
> Secure code in TrustZone space may need to perform L2 cache 
> maintenance operations. A shared mutex is required to synchronize 
> linux l2cc maintenance and TZ l2cc maintenance.
> 
> The TZ mutex is an "arch_spinlock": a 32bit DDR cell (ARMv7-A mutex).
> Linux L2 cache driver must lock TZ mutex if enabled.
>...
> +#define l2x0_spin_lock_irqsave(flags) \
> +             do {                                                                                                        \
> +                             raw_spin_lock_irqsave(&l2x0_lock, flags);           \
> +                             if (l2x0_tz_mutex)                                                           \
> +                                             arch_spin_lock(l2x0_tz_mutex);                               \
> +             } while (0)
