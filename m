From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 27 Jul 2015 11:13:08 +0300
Subject: [PATCH v4 0/7] KASAN for arm64
In-Reply-To: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
References: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <55B5E814.2020507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2015 07:41 PM, Andrey Ryabinin wrote:
>  - fix memleak in kasan_populate_zero_shadow:
>        Following code could leak memory when pgd_populate() is nop:
> 		void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> 		pgd_populate(&init_mm, pgd, p);

It's not a leak actually, because this code is under if (pgd_none(*pgd)).
But gcc complains warns about unused variable p, so this has to be changed anyways.

> 	This was replaced by:
> 	     	 pgd_populate(&init_mm, pgd, early_alloc(PAGE_SIZE, NUMA_NO_NODE));
