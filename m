From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 30 Sep 2011 16:44:33 +0800
Subject: [PATCH v3] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20110930083338.GB19807@S2100-06.ap.freescale.net>
References: <1317353481-28723-1-git-send-email-Barry.Song@csr.com>
	<20110930083338.GB19807@S2100-06.ap.freescale.net>
Message-ID: <CAGsJ_4zUL-6VzifctuDTe=jF-2FzjbkD10VfR=hC8ZDaFMiOFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/30 Shawn Guo <shawn.guo@freescale.com>:
> On Thu, Sep 29, 2011 at 08:31:21PM -0700, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> we save the l2x0 registers at the first initialization, and platform codes
>> can get them to restore l2x0 status after wakeup.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>> ?-v3:
>> ?save PREFETCH_CTRL and POWER_CTRL according to revision;
>> ?save l2x0 physical address so that asm codes can use.
>
> On imx6q:
>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

Shawn, Thanks.

>
> One minor comment below.
>
>>
>> ?arch/arm/include/asm/hardware/cache-l2x0.h | ? 23 +++++
>> ?arch/arm/include/asm/outercache.h ? ? ? ? ?| ? ?7 ++
>> ?arch/arm/kernel/asm-offsets.c ? ? ? ? ? ? ?| ? 12 +++
>> ?arch/arm/mm/cache-l2x0.c ? ? ? ? ? ? ? ? ? | ?129 +++++++++++++++++++++++++--
>> ?4 files changed, 161 insertions(+), 10 deletions(-)
>
> [... ]
>
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index 0d85d22..3f9b998 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -33,6 +33,14 @@ static DEFINE_SPINLOCK(l2x0_lock);
>> ?static uint32_t l2x0_way_mask; ? ? ? /* Bitmask of active ways */
>> ?static uint32_t l2x0_size;
>>
>> +struct l2x0_regs l2x0_saved_regs;
>> +
> Can we add a declaration of l2x0_saved_regs in cache-l2x0.h, so that
> platform code does not need to declare it individually?

it could be ok. if the platform codes are in c after MMU on, it can be
useful. but people might be able to call outer_resume() in c directly.
then it doesn't need the declaration as well.
anyway, we can add it for future possible use. v4 soon.

-barry
