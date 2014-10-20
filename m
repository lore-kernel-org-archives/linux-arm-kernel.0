From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Oct 2014 14:33:04 +0100
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <20141014041241.GB19810@codeaurora.org>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
 <20140801063009.GA24602@codeaurora.org>
 <20141003163141.GC2384@e104818-lin.cambridge.arm.com>
 <20141009023933.GA21161@codeaurora.org>
 <20141009101613.GD17836@e104818-lin.cambridge.arm.com>
 <20141014040450.GA19810@codeaurora.org>
 <20141014041241.GB19810@codeaurora.org>
Message-ID: <20141020133304.GH23751@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 05:12:41AM +0100, Joonwoo Park wrote:
> From 1cb0bb81e0d399255e679337929a8438946a4b9a Mon Sep 17 00:00:00 2001
> From: Joonwoo Park <joonwoop@codeaurora.org>
> Date: Mon, 28 Jul 2014 17:32:06 -0700
> Subject: [PATCH v2] arm64: optimize memcpy_{from,to}io() and memset_io()
> 
> Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
> as much as possible with minimized barrier usage.  This simplest
> optimization brings faster throughput compare to current byte-by-byte read
> and write with barrier in the loop.  Code's skeleton is taken from the
> powerpc.
> 
> Reviewed-by: Trilok Soni <tsoni@codeaurora.org>
> Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>

[...]

> @@ -55,10 +83,28 @@ EXPORT_SYMBOL(__memcpy_toio);
>   */
>  void __memset_io(volatile void __iomem *dst, int c, size_t count)
>  {
> -	while (count) {
> +	u64 qc = c;

I think you should use a (u8) cast here (I'm not sure there is a
requirement for memset to only pass u8 values).

	u64 qc = (u8)c;

Otherwise the patch looks fine. Since Will is handling the next merging
window, you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
