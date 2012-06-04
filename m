From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 04 Jun 2012 16:15:54 +0200
Subject: v3.5-rc1 ARM PXA possible regression
In-Reply-To: <20120604140531.GA7486@lunn.ch> (Andrew Lunn's message of "Mon, 4
 Jun 2012 16:05:31 +0200")
References: <20120604140531.GA7486@lunn.ch>
Message-ID: <87fwab88o5.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:

> Hi Paul

Hi,

>
> I've got the same problem on my kirkwood based QNAP NAS box.
>
> I bisected it, and the problem patch for me is:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7ff9554bb578ba02166071d2d487b7fc7d860d62
>
> printk: convert byte-buffer to variable-length record buffer
>
> I've not looked further, so i've no idea why this is causing problems.

There has been discussions here about that iirc. I don't know when a
proper fix will be merged but one *very* *ugly* workaround is:

--- linux.orig/kernel/printk.c  2012-06-03 15:26:20.000000000 +0200
+++ linux/kernel/printk.c       2012-06-03 16:41:24.000000000 +0200
@@ -228,7 +228,7 @@ static u32 clear_idx;
 
 /* record buffer */
 #if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
-#define LOG_ALIGN 4
+#define LOG_ALIGN 8
 #else
 #define LOG_ALIGN 8
 #endif


At least it seems to work here.

Arnaud
