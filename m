From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 16:52:13 +0000
Subject: [RFC PATCH 03/10] ARM: mc146818rtc: remove unnecessary include
 of mach/irqs.h
In-Reply-To: <1326472451-9002-4-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120113165213.GB1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:34:04AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The include of mach/irqs.h isn't needed, so remove it. Compiled CMOS rtc
> driver.

I'm not sure how safe this is - there are some drivers using mc146818rtc.h
which get their IRQ via this header file (it's known as RTC_IRQ.)  So we
need to verify that nothing breaks as a result of that definition going
away when this file is included.

It looks like it's just drivers/char/rtc.c, which we don't use anymore
on ARM.  So this should be safe.

It might be worth adding:

#define RTC_IRQ BUILD_BUG_ON(true)

or something like that, to catch any users of it (even though that'll then
cause drivers/char/rtc.c to fail if built on ARM, which it shouldn't be.)
