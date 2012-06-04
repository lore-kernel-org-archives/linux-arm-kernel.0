From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 04 Jun 2012 21:32:34 +0200
Subject: v3.5-rc1 ARM PXA possible regression
In-Reply-To: <87fwab88o5.fsf@lebrac.rtp-net.org>
References: <20120604140531.GA7486@lunn.ch> <87fwab88o5.fsf@lebrac.rtp-net.org>
Message-ID: <4FCD0D52.7020602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Am 04.06.2012 16:15, schrieb Arnaud Patard (Rtp):
> There has been discussions here about that iirc. I don't know when a
> proper fix will be merged but one *very* *ugly* workaround is:
>
> --- linux.orig/kernel/printk.c  2012-06-03 15:26:20.000000000 +0200
> +++ linux/kernel/printk.c       2012-06-03 16:41:24.000000000 +0200
> @@ -228,7 +228,7 @@ static u32 clear_idx;
>  
>  /* record buffer */
>  #if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> -#define LOG_ALIGN 4
> +#define LOG_ALIGN 8
>  #else
>  #define LOG_ALIGN 8
>  #endif
>
>
> At least it seems to work here.

Yes, a thread discussing this is at
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101783.html
, which did not really come to a conclusion, but proposed the following
fix (the original proposal used "struct log_buf", but it should be
"struct log" I suppose):

/#define LOG_ALIGN (__alignof__(struct log))

/which works for me on kirkwood (but apparently may waste a couple of bytes on other architectures)


- Simon
