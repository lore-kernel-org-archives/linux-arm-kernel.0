From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Nov 2012 17:07:11 +0000
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
Message-ID: <20121113170711.GI28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Right, so, what this tells me is that the implementation of the spinlock
in the secure software is potentially the same as the kernel's spinlock.
The kernel's spinlock implementation is GPL'd.  If the secure side spinlock
implementation is a copy of the kernel's spinlock implementation, then that
implementation is also GPL'd, which, as it is linked with the rest of the
secure software, either the whole of the secure software suite is GPL'd
_or_ it is in violation of the GPL.

I think someone has some explaining to do.
