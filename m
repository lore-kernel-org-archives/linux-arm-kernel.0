From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 May 2012 13:56:39 +0300
Subject: Linux Kernel boot up stops after message "Uncompressing
 Linux....done, booting the kernel"
In-Reply-To: <20120524103221.GA1889@glitch>
References: <CACZ0kf88Ac8hne9RtLObi624okPw8Nkiv7++Uw8npPLW108mhw@mail.gmail.com>
 <CACZ0kf9yHJOAVEBx4e5dc_eCRT5dScrZHzbkx3_7P2QkzaHChQ@mail.gmail.com>
 <20120524103221.GA1889@glitch>
Message-ID: <20120524105639.GA12739@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Domenico,

On Thu, May 24, 2012 at 12:32:21PM +0200, Domenico Andreoli wrote:
> On Thu, May 24, 2012 at 10:52:46AM +0530, K K wrote:
> > We have a lpc-3180 based board and it is up and running fine with 2.6.10
> > kernel version. We planned to port our board changes into 2.6.32 kernel
> > version.
> 
> 2.6.32, really?
> 
> > kernel build successfully. When we booting the board with the new 2.6.32
> > kernel we are getting following messages and its stops.
> 
> Two cases:
> 
>   1. earlyprintk is configured and enabled but points to the
>      wrong console and your platform hangs on it because it's not
>      initialized/ready. the correct console seems ok, the uncompressor
>      is able to use it. check debug-macro.S to be sure it uses the
>      correct address.
> 
>   2. earlyprintk is not enabled (or configured) and your kernel is
>      not finding the console (any console= on the cmdline? driver
>      issue?) or dies before finding it. try enabling earlyprintk (and
>      check debug-macro.S as well).

earlyprintk on ARM is only available since commit 93fd03a8 (ARM: Add an 
earlyprintk debug console), which is included in kernel version 2.6.33. For 
older kernels you can used the following printk hack instead (with 
CONFIG_DEBUG_LL enabled):


diff --git a/kernel/printk.c b/kernel/printk.c
index 5052b54..d685f8a 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -685,6 +685,10 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	/* Emit the output into the temporary buffer */
 	printed_len += vscnprintf(printk_buf + printed_len,
 				  sizeof(printk_buf) - printed_len, fmt, args);
+	{
+		extern void printascii(const char *);
+		printascii(printk_buf);
+	}
 
 
 	/*

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
