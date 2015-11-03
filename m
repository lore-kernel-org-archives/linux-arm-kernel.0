From: axboe@fb.com (Jens Axboe)
Date: Tue, 3 Nov 2015 08:25:36 -0700
Subject: [PATCH] lightnvm: work around 32-bit built error
In-Reply-To: <4925999.tpkPGVQaeU@wuerfel>
References: <4925999.tpkPGVQaeU@wuerfel>
Message-ID: <5638D1F0.7060406@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2015 06:53 AM, Arnd Bergmann wrote:
> The newly added lightnvm incorrectly uses a sector_t variable to
> represent a data structure with fixed length bit fields, which breaks
> when sector_t is configured to be 32-bit:
>
> In file included from ../drivers/lightnvm/core.c:29:0:
> /include/linux/lightnvm.h:143:4: error: width of 'resved' exceeds its type
>      sector_t resved  : 36;
> include/linux/lightnvm.h: In function 'ppa_set_empty':
> /include/linux/lightnvm.h:120:20: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>   #define ADDR_EMPTY (~0ULL)

Thanks Arnd, Matias sent another variant yesterday that changes this to 
u64 as well.

> This patch resolves the build error, but does not address the fact that
> bit fields are not reliable in data structures that are interpreted
> by firmware on another architecture. If the layout is meant to be
> stable, the bit fields should be replaced with explicit calculations.

Matias? Are these every stored and read back, potentially on a different 
machine?

-- 
Jens Axboe
