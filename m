From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 16 Oct 2015 14:57:30 -0500
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <1442944788-17254-1-git-send-email-rric@kernel.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
Message-ID: <CAOZdJXUiRMAguDV+HEJqPg57MyBNqEcTyaH+ya=U93NHb-pdJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 12:59 PM, Robert Richter <rric@kernel.org> wrote:
> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>
> Increase the standard cacheline size to avoid having locks in the same
> cacheline.
>
> Cavium's ThunderX core implements cache lines of 128 byte size. With
> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> share the same cache line leading a performance degradation.
> Increasing the size fixes that.
>
> Increasing the size has no negative impact to cache invalidation on
> systems with a smaller cache line. There is an impact on memory usage,
> but that's not too important for arm64 use cases.
>
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Acked-by: Timur Tabi <timur@codeaurora.org>

We need this patch, because on our silicon, CTR_EL0[CWG] set to 5, which
means that setup_processor() complains with this warning:

cls = cache_line_size();

if (L1_CACHE_BYTES < cls)
    pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule
(%d < %d)\n",
            L1_CACHE_BYTES, cls);

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
