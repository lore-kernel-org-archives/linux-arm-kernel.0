From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 12:57:27 +0000
Subject: [PATCH v2] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <5040EAF7.9010003@codeaurora.org>
References: <1346413645-4593-1-git-send-email-castet.matthieu@free.fr>
 <5040EAF7.9010003@codeaurora.org>
Message-ID: <201209031257.28213.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 August 2012, Stephen Boyd wrote:
> > +static int hvc_dcc_put_chars_v6(uint32_t vt, const char *buf, int count)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < count; i++) {
> > +             while (__dcc_getstatus_v6() & DCC_STATUS_TX_V6)
> > +                     cpu_relax();
> > +
> > +             __dcc_putchar_v6(buf[i]);
> > +     }
> > +
> > +     return count;
> > +}
> 
> It's unfortunate that the main logic is duplicated. I wonder if we could
> push the runtime decision slightly lower into the accessor functions
> instead and make some new functions dcc_tx_busy() and dcc_rx_busy() or
> something. Then these loops stay the same.

Agreed. Ideally, you should be able to get the code to be compiled into
the same binary as before for ARMv6+. If only the inline assembly differs,
you can do something like

static inline char __dcc_getchar(void)
{
        char __c;

        if (__LINUX_ARM_ARCH >= 6)
		asm volatile("mrc p14, 0, %0, c0, c5, 0 @ read comms data reg"
	                : "=r" (__c));
	else
		asm volatile ("mrc p14, 0, %0, c1, c0  @ read comms data reg"
			: "=r" (ret));
        isb();

        return __c;
}

	Arnd
