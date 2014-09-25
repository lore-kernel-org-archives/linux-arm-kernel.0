From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 25 Sep 2014 15:11:37 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <5423FD14.9060604@hurleysoftware.com>
References: <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
 <20140921204100.GA10111@linutronix.de>
 <5421A7F7.3070109@hurleysoftware.com>
 <20140924075346.GB19565@linutronix.de>
 <20140925104208.GE19396@linutronix.de>
 <5423FD14.9060604@hurleysoftware.com>
Message-ID: <20140925131137.GG19396@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Hurley | 2014-09-25 07:31:32 [-0400]:

>I just verified that GNU readline6 uses ioctl(TCSETSW, ...) to do the set_termios
>(which is the ioctl that libc should use for tcsetattr(TCSADRAIN)).
>
>Maybe this userspace is using a readline()-alike that has a bug by not using the
>correct tcsetattr() action?

set_termios() has an opt argument. While doing ":n" in vi I see two invocations
with "opt == 8" which stands for TCSETS.
browsing through vi's code I stumbled upon 

|static void rawmode(void)
|{
?
|    tcsetattr_stdin_TCSANOW(&term_vi);
|}
|int FAST_FUNC tcsetattr_stdin_TCSANOW(const struct termios *tp)
|{
|    return tcsetattr(STDIN_FILENO, TCSANOW, tp);
|}

and this is probably what you meant. There is also
| static void cookmode(void)
| {
|     fflush_all();
|     tcsetattr_stdin_TCSANOW(&term_orig);
| }

However I don't see __tty_perform_flush() in kernel invoked.

>Or maybe the glibc-equivalent has the bug, and tcsetattr(TCSADRAIN) is not using
>ioctl(TCSETSW)?

libc is "GNU C Library 2.20". 

>Regards,
>Peter Hurley

Sebastian
