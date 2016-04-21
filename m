From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Apr 2016 09:49:46 +0100
Subject: [BUG] set_pte_at: racy dirty state clearing warning
In-Reply-To: <57180A53.3000207@linaro.org>
References: <57180A53.3000207@linaro.org>
Message-ID: <20160421084946.GA23774@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 04:01:39PM -0700, Shi, Yang wrote:
> When I enable memory comact via
> 
> # echo 1 > /proc/sys/vm/compact_memory
> 
> I got the below WARNING:
> 
> set_pte_at: racy dirty state clearing: 0x0068000099371bd3 ->
> 0x0068000099371fd3
> ------------[ cut here ]------------
> WARNING: CPU: 5 PID: 294 at ./arch/arm64/include/asm/pgtable.h:227
> ptep_set_access_flags+0x138/0x1b8
> Modules linked in:

Do you have this patch applied:

http://article.gmane.org/gmane.linux.ports.arm.kernel/492239

It's also queued into -next as commit 66dbd6e61a52.

> My kernel has ARM64_HW_AFDBM enabled, but LS2085 is not ARMv8.1.
> 
> The code shows it just check if ARM64_HW_AFDBM is enabled or not, but
> doesn't check if the CPU really has such capability.
> 
> So, it might be better to have the capability checked runtime?

The warnings are there to spot any incorrect uses of the pte accessors
even before you run on AF/DBM-capable hardware.

-- 
Catalin
