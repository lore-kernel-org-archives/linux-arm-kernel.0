From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jan 2014 14:35:29 +0000
Subject: [PATCH] arm: Add Arm Erratum 773769 for Large data RAM latency.
In-Reply-To: <1389187991-26446-1-git-send-email-gautam.vivek@samsung.com>
References: <1389187991-26446-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20140108143529.GB14122@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 01:33:11PM +0000, Vivek Gautam wrote:
> The erratum-773769 occurs on Arm Coretex-A15 (rev r2p0),
> when L2 Data Ram latency is set to 4 cycles or more; or
> when ACP is in use, or with L2 Data RAM slice configured.
> Therefore, the effective latency as calculated in Table 7-2 of
> Cotex-A15 (rev r2p0) trm should be 3 cycles or less.
> 
> On Exynos5250 based systems the effective data ram latency
> is 4 cycles, since we have DATA_RAM_SETUP bit enabled (L2CTRL[5]=1b'1)
> and DATA_RAM_LATENCY bits set to 0x2 (L2CTLR[2:0]=3b'010) therefore,
> the effective L2 data RAM latency becomes 4 cycles.
> So erratum '773769' occurs causing a corrupted L2 Cache.
> 
> This patch gives a workaround to the mentioned erratum, using below
> mentioned algo:
> ----------------------------------------------------------------
> if data RAM setup = 1
>   then check if effective latency i.e (latency + setup + 1) > 3
>   if 'true'
>     then clear data RAM setup
>       goto branch 'a'
> if data RAM setup = 0
>   a: then check if data RAM latency > 0x10
>     if true then force data RAM latency = 0x10
> ----------------------------------------------------------------
> so that the effective data RAM latency reduces to 3 cycles or less
> and hence prevent hitting the erratum.
> 
> NOTE: The Exynos5250 based products have already been shipped, which
>       makes it impossible to add the change in bootloader, so we are
>       adding the required change in kernel.

NAK. Whilst I appreciate that you may not be able to fix your bootloader,
this isn't the right change to make in the kernel. Blindly changing memory
latencies is likely to do more harm than good for a multi-platform kernel,
even if it works for exynos 5250. The only alternative I can think of (if you
have to make a mainline kernel change) is to restrict the clock frequencies at
which the CPU is allowed to run, although that obviously requires some
investigation in order to determine how viable it is for your SoC.

Will
