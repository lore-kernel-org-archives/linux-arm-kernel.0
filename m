From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 29 Oct 2009 09:52:36 +0100
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with
	PICe->PCI bridge
In-Reply-To: <200910290936.40397.dk-arm-linux@gmx.de>
References: <200910290936.40397.dk-arm-linux@gmx.de>
Message-ID: <20091029085236.GN14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2009 at 10:36:40AM +0200, Dieter Kiermaier wrote:
> ## Booting kernel from Legacy Image at 00800000 ...
>    Image Name:   Linux-2.6.32-rc5-00081-g964fe08-
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2390056 Bytes =  2.3 MB
>    Load Address: 00008000
>    Entry Point:  00008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux............................................................................................................................................................ done.

The problem most probably is that your kernel dies before the console is
enabled, and hence you're not pointed to the actual problem.

Try the patch below - printk() messages are not buffered but sent out
directly to the lowlevel UART functions with this hack. CONFIG_DEBUG_LL
must be enabled for this.

Daniel


diff --git a/kernel/printk.c b/kernel/printk.c
index b4d97b5..7919751 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -686,6 +686,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	printed_len += vscnprintf(printk_buf + printed_len,
 				  sizeof(printk_buf) - printed_len, fmt, args);
 
+{ extern void printascii(const char *); printascii(printk_buf); }
 
 	p = printk_buf;
 
