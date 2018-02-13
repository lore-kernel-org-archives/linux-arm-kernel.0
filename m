From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Feb 2018 11:57:17 +0000
Subject: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
In-Reply-To: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20180213115717.4ubsnjraacorwbgk@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 03:45:23PM -0800, Florian Fainelli wrote:
> On many platforms, including, but not limited to Brahma-B53 platforms,
> the L1 cache line size is 64bytes. Increasing the value to 128bytes
> appears to be creating performance problems for workloads involving
> network drivers and lots of data movement. In order to keep what was
> introduced with 97303480753e ("arm64: Increase the max granular size"),
> a kernel built for ARCH_THUNDER or ARCH_THUNDER2 will get a 128bytes
> cache line size definition.

This approach has been raised before ([1] as an example but you can
probably find other threads) and NAK'ed. I really don't want this macro
to be configurable as we aim for a single kernel Image.

My proposal was to move L1_CACHE_SHIFT back to 6 and ARCH_DMA_MIN_ALIGN
to 128 as this is the largest known CWG. The networking code is wrong in
assuming SKB_DATA_ALIGN only needs SMP_CACHE_BYTES for DMA alignment but
we can add some safety checks (i.e. WARN_ON) in the arch dma ops code if
the device is non-coherent.

I'll send a patch to the list (hopefully later today).

Catalin

[1] https://patchwork.kernel.org/patch/8634481/
