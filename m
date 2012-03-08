From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Mar 2012 10:27:17 -0800
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
In-Reply-To: <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
 (Luciano Coelho's message of "Thu, 8 Mar 2012 14:21:43 +0200")
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
 <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
 <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
Message-ID: <87sjhjaqyi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Luca,

"Coelho, Luciano" <coelho@ti.com> writes:

[...]

> I can't get ttyO2 wakeup to work on my Blaze with 3.3-rc5.  It works
> fine with 3.2.  

I assume you mean wakeup from system-wide suspend (echo mem > /sys/power/state)?

Are you enabling UART wakeups?

They are disabled by default, so you need to:

echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup

It may work in v3.2 due to the fact that the UART runtime PM had the
unintended side-effect of essentially disabling MPU and CORE PM.  With
that bug fixed and MPU & CORE actually hitting low power states, you'll
need to ensure UART wakeups are enabled.

If you're already enabling wakeups and this still isn't working, try
adding 'no_console_suspend' to the kernel cmdline, try a suspend/resume
and post the console output.

Thanks,

Kevin
