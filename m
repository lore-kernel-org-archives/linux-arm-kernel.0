From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Apr 2014 16:20:47 +0100
Subject: [RFC PATCH V4 6/7] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1396018892-6773-7-git-send-email-steve.capper@linaro.org>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-7-git-send-email-steve.capper@linaro.org>
Message-ID: <20140430152047.GF31220@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:01:31PM +0000, Steve Capper wrote:
> In order to implement fast_get_user_pages we need to ensure that the
> page table walker is protected from page table pages being freed from
> under it.
> 
> This patch enables HAVE_RCU_TABLE_FREE, any page table pages belonging
> to address spaces with multiple users will be call_rcu_sched freed.
> Meaning that disabling interrupts will block the free and protect the
> fast gup page walker.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

While this patch is simple, I'd like to better understand the reason for
it. Currently HAVE_RCU_TABLE_FREE is enabled for powerpc and sparc while
__get_user_pages_fast() is supported by a few other architectures that
don't select HAVE_RCU_TABLE_FREE. So why do we need it for fast gup on
arm/arm64 while not all the other archs need it?

Thanks.

-- 
Catalin
