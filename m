From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 07 Sep 2011 14:54:30 +0100
Subject: [PATCH] ARM: alignment: setup alignment handler earlier
References: <87ehzstr07.fsf@vostro.fn.ogness.net>
Message-ID: <yw1xy5y0cvah.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Ogness <john.ogness@linutronix.de> writes:

> From 6f3f381800367127dc6430d9b9fa9bd6fc6d8ed0 Mon Sep 17 00:00:00 2001
> From: John Ogness <john.ogness@linutronix.de>
>
> The alignment exception handler is setup fairly late in
> the boot process (fs_initcall). However, with newer gcc
> versions and the compiler option -fconserve-stack, code
> accessing unaligned data is generated in functions that
> are called earlier, for example pcpu_dump_alloc_info().

This is a gcc bug and should not be worked around like this.  There was
another patch[1] to disable -fconserve-stack on ARM due to this broken
behaviour.  This patch was the outcome of a rather lengthy discussion[2].

[1] http://article.gmane.org/gmane.linux.kernel/1148272
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/117863

> This results in unhandled alignment exceptions during
> boot. By setting up the exception handler sooner, we
> reduce the window where a compiler may generate code
> accessing unaligned data.

I will also restate my opinion that enabling strict alignment checking
on ARMv6 and later is *wrong* in the first place.

-- 
M?ns Rullg?rd
mans at mansr.com
