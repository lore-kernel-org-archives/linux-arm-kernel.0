From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 11 Feb 2016 07:32:43 -0800
Subject: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
In-Reply-To: <56BC2DF7.20803@samsung.com>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel> <56BAA27A.9050605@roeck-us.net>
 <2606061.l722KO95iI@wuerfel> <56BC022B.7030004@roeck-us.net>
 <56BC2DF7.20803@samsung.com>
Message-ID: <20160211153243.GA3076@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 07:45:11AM +0100, Andrzej Hajda wrote:
> On 02/11/2016 04:38 AM, Guenter Roeck wrote:
> > On 02/10/2016 07:21 AM, Arnd Bergmann wrote:
> >> On Tuesday 09 February 2016 18:37:46 Guenter Roeck wrote:
> >>> On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
> >>>> On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> >>>>> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> >>>>> It can not be used to check if an unsigned int reflects an error.
> >>>>> Doing so can result in the following build warning.
> >>>>>
> >>>>> drivers/tty/serial/digicolor-usart.c: In function ?digicolor_uart_probe?:
> >>>>> include/linux/err.h:21:38: warning:
> >>>>>           comparison is always false due to limited range of data type
> >>>>> drivers/tty/serial/digicolor-usart.c:485:6: note:
> >>>>>           in expansion of macro ?IS_ERR_VALUE?
> >>>>>
> >>>>> If that warning is seen, an error return from platform_get_irq() is missed.
> >>>>>
> >>>>>
> >>>> The patch looks correct to me, but what compiler version and which kernel
> >>>> tree is it that triggered the warning?
> >>>>
> >>>> Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and the
> >>>> changes are still under discussion, but I don't see that warning with
> >>>> any of the versions.
> >>>>
> >>> I see it with gcc 5.1 and 5.2 (and W=1). I did not see / notice Andrzej's patch.
> >>>
> >>> I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
> >>>
> >>>
> >> Ah, W=1 explains it. We are still debating about the proper solution. Al Viro
> >> pointed out that most users of IS_ERR_VALUE() shouldn't be using it at all,
> >> so your patch is probably best here after all.
> >>
> > Yes, after looking into it some more I agree. Coccinelle should be able to handle
> > most of the conversions automatically. I actually tried to write a script, just
> > for the fun of it, but it misses some of the problem cases in patch mode.
> > Maybe I get it working tonight.
> >
> > Guenter
> >
> 
> Maybe it can be helpful. The script which classifies all IS_ERR_VALUE
> usages as
> correct, signed, incorrect and unknown (cocci was not able to detect type).
> Adding patch mode should be quite simple.
> 
> // Options: --all-includes --include
> include/uapi/linux/netfilter_ipv6/ip6_tables.h --include
> include/uapi/linux/netfilter_ipv4/ip_tables.h --include
> include/uapi/linux/netfilter_arp/arp_tables.h --include
> include/uapi/linux/netfilter/x_tables.h --include include/linux/mm_types.h
> 
> virtual context
> virtual report
> 
> @r@
> typedef bool, u8, u16, u32, u64, s8, s16, s32, s64, __u64, dma_addr_t,
> Elf32_Addr, Elf64_Addr;
> {unsigned long, size_t} ev;
> {short, int, long, s16, s32, ssize_t} ew;
> {char, unsigned char, unsigned short, unsigned int, long long, unsigned
> long long, bool, u8, u16, u32, u64, s64, __u64, dma_addr_t, Elf32_Addr,
> Elf64_Addr} ei;
> expression eu;
> position p;
> @@
> 
> IS_ERR_VALUE(\(ev \| ew \| ei \| eu \))@p
> 
> @script:python depends on report@
> p << r.p = [];
> ev << r.ev = "";
> ew << r.ew = "";
> ei << r.ei = "";
> eu << r.eu = "";

This doesn't work for me; it bails out@the assignments. If I remove
the assignments, it does not report anything.

Any idea what might be wrong ?

Thanks,
Guenter

> @@
> 
> t = ""
> if ev: t = "correct"
> if ew: t = "signed"
> if ei: t = "incorrect"
> if eu: t = "unknown"
> 
> 
> e = ev + ew + ei + eu;
> if t:
>     msg = "WARNING: %s argument type in IS_ERR_VALUE(%s)" % (t, e)
>     coccilib.report.print_report(p[0], msg)
> 
> 
