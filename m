From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 13:19:49 +0200
Subject: [PATCH 08/32] dmaengine: ste_dma40: Optimise local MAX() macro
In-Reply-To: <20130418110024.GP14496@n2100.arm.linux.org.uk>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <201304181246.03357.arnd@arndb.de>
 <20130418110024.GP14496@n2100.arm.linux.org.uk>
Message-ID: <201304181319.49737.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Russell King - ARM Linux wrote:
> Never got the original patch...
> 
> A much better idea is to get rid of that buggy MAX() macro altogether
> and use the macros already provided by the kernel, which are safe from
> side effects - but more importantly are type _safe_.  The above goes
> wrong when you consider 'a' and 'b' may have different signed-ness.

Yes, that's what was suggested before.

> Consider:
> 
>         int val_in = -5;
>         unsigned val = MAX(val_in, 5U);
> 
> The resulting value is (unsigned)-5, not (unsigned)5.
> 
> Best use the kernel's max() or max_t() _everywhere_.

Unfortunately, the (only) use of this macro is in a structure declaration
where you cannot use the syntax of max():

struct d40_base {
	...
        u32    reg_val_backup_v4[MAX(BACKUP_REGS_SZ_V4A, BACKUP_REGS_SZ_V4B)];
	...
};

My preferred solution would be to remove the MAX macro here and
define a new constant

#define BACKUP_REGS_SZ ((BACKUP_REGS_SZ_V4A > BACKUP_REGS_SZ_V4B) ? \
			 BACKUP_REGS_SZ_V4A : BACKUP_REGS_SZ_V4B)

But I don't see it as much of an improvement over what is currently
there.

	Arnd
