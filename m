From: timur@freescale.com (Timur Tabi)
Date: Thu, 23 Feb 2012 09:44:37 -0600
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F465A33.3020208@ru.mvista.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
 <4F465A33.3020208@ru.mvista.com>
Message-ID: <4F465EE5.4010908@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
>     These functions are not equivalent concerning endianness. You should 
> probably have used readl_be() instead, else it won't work on PPC anymore.

readl_be() is not good enough, either.  The in/out_be functions have
specific syncronization instructions in them, so that the operations
conform to the PowerPC instruction ordering architecture.

You probably need to do something like this:

#ifdef PPC
#define read_ssi(x) in_be32(x)
#else #if defined ARM
#define read_ssi(x) readl(x)
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale
