From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Aug 2013 12:01:08 +0100
Subject: v3.11-rc4: OMAP1/Amstrad Delta (E3) crash
In-Reply-To: <20130806232609.GB15014@blackmetal.musicnaut.iki.fi>
References: <20130806232609.GB15014@blackmetal.musicnaut.iki.fi>
Message-ID: <20130808110108.GK23053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 02:26:09AM +0300, Aaro Koskinen wrote:
> [    0.258589] [ffff1224] *pgd=00000000, *pte=11fff0cb000001f1, *ppte=11fff00a00000000

BTW, your oops dump is interesting for another reason - the above.
You seem to have 64-bit page table entries above.  This is produced
by this:

                pte_t *pte;
...
                printk(", *pte=%08llx", (long long)pte_val(*pte));
#ifndef CONFIG_ARM_LPAE
                printk(", *ppte=%08llx",
                       (long long)pte_val(pte[PTE_HWTABLE_PTRS]));
#endif

with:

#define pte_val(x)      (x)
typedef pteval_t pte_t;
typedef u32 pteval_t;

Now, this is totally legal C:

	unsigned int val = 0x12345678;

	printk("%08llx\n", (long long)val);

and it should produce "12345678" but I'm willing to bet with your compiler
it produces "12345678xxxxxxxx" where xxxxxxxx is just what happens to be
sitting in some register.  IOW, I think you have a compiler bug here.  Can
you investigate what's going on with this yourself please?
