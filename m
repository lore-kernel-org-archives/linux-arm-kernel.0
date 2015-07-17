From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 17 Jul 2015 16:13:07 +0300
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <20150716160313.GC26865@e104818-lin.cambridge.arm.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <20150708154803.GE6944@e104818-lin.cambridge.arm.com>
 <559FFCA7.4060008@samsung.com>
 <20150714150445.GH13555@e104818-lin.cambridge.arm.com>
 <55A61FF8.9000603@samsung.com>
 <20150715163732.GF20186@e104818-lin.cambridge.arm.com>
 <55A7CE03.301@samsung.com>
 <20150716160313.GC26865@e104818-lin.cambridge.arm.com>
Message-ID: <55A8FF63.70505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 07:03 PM, Catalin Marinas wrote:
> On Thu, Jul 16, 2015 at 06:30:11PM +0300, Andrey Ryabinin wrote:
>>
>> I think this may work, if pud_none(*pud) will be replaced with !pud_val(*pud).
>> We can't use pud_none() because with 2-level page tables it's always false, so
>> we will never go down to pmd level where swapper_pg_dir populated.
> 
> The reason I used "do ... while" vs "while" or "for" is so that it gets
> down to the pmd level. The iteration over pgd is always done in the top
> loop via pgd_addr_end while the loops for missing levels (nopud, nopmd)
> are always a single iteration whether we check for pud_none or not. But
> when the level is present, we avoid looping when !pud_none().
> 

Right, dunno what I was thinking.
It seems to work. Lightly tested with every possible CONFIG_PGTABLE_LEVELS.
