From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jan 2012 13:14:11 +0000
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <CAGhQ9VxzFZ32P08RPx8us4fE8xO3prXpM-fdWcsWWjWub4eC=w@mail.gmail.com>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
 <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
 <20120129001136.GB15455@n2100.arm.linux.org.uk>
 <CAGhQ9VxzFZ32P08RPx8us4fE8xO3prXpM-fdWcsWWjWub4eC=w@mail.gmail.com>
Message-ID: <20120129131411.GC15455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 02:10:34PM +0100, Joachim Eastwood wrote:
> On Sun, Jan 29, 2012 at 1:11 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Jan 28, 2012 at 11:55:19PM +0100, Joachim Eastwood wrote:
> >> "ARM: 7304/1: ioremap: fix boundary check when reusing static mapping"
> >> Commit: 3c424f359898aff48c3d5bed608ac706f8a528c3 in Linus master
> >>
> >> Breaks booting on my custom AT91RM9200 board.
> >> There isn't any error messages or anything that indicates what goes
> >> wrong it just stops after; Uncompressing Linux... done, booting the
> >> kernel.
> >
> > Your best way of finding out what's going on is to enable:
> >
> > DEBUG_KERNEL
> > DEBUG_LL
> > EARLY_PRINTK
> >
> > and select the appropriate kernel low-level debugging port. ?That should
> > show you what's going on.
> 
> Sadly, it doesn't make a difference. Still no output.

Sorry, I missed that you also need 'earlyprintk' or something like that
on the command line.  Alternatively, use the following patch, which IMHO
is a lot less error prone:

diff --git a/kernel/printk.c b/kernel/printk.c
index b51b156..611e495 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -875,7 +875,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	/* Emit the output into the temporary buffer */
 	printed_len += vscnprintf(printk_buf + printed_len,
 				  sizeof(printk_buf) - printed_len, fmt, args);
-
+{ extern void printascii(const char *); printascii(printk_buf); }
 	p = printk_buf;
 
 	/* Read log level and handle special printk prefix */
