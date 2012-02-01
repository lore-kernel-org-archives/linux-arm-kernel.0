From: xiyou.wangcong@gmail.com (Cong Wang)
Date: Wed, 01 Feb 2012 18:51:33 +0800
Subject: In many cases softlockup can not be reported after disabling
 IRQ for long time
In-Reply-To: <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
References: <CAOwKts8zS1rYA+Y4k-vb8YAaR=aFd1BwryhhWWnWLQyrYrNqyA@mail.gmail.com>
 <20120131154748.GA5650@redhat.com>
 <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
Message-ID: <4F291935.2030205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Please don't top-reply.)

On 02/01/2012 10:18 AM, TAO HU wrote:
> Hi, Don
>
> Thanks for your feedback!
>
> Unfortunately, the hardlockup depends on NMI which is not available on
> ARM (Cortex-A9) per my understanding.
> Our system uses OMAP4430. Any more suggestions?

When there is no NMI, touch_nmi_watchdog() actually touches softlockup 
watchdog:

#if defined(ARCH_HAS_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
#include <asm/nmi.h>
extern void touch_nmi_watchdog(void);
#else
static inline void touch_nmi_watchdog(void)
{
         touch_softlockup_watchdog();
}
#endif

so you need to check if other places calling touch_nmi_watchdog() 
especially on ARM.
