From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Dec 2010 16:53:37 +0000
Subject: [PATCH v3 4/5] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <AANLkTimkUpgPD5BdjL-3aV=miJwbT0OOWAJJ+V7LUhbP@mail.gmail.com>
References: <-1357135968697415881@unknownmsgid>
	<AANLkTimkUpgPD5BdjL-3aV=miJwbT0OOWAJJ+V7LUhbP@mail.gmail.com>
Message-ID: <AANLkTi=VaayMuiU-RXnL40gf3_y0YWYvOWayDofdDmpL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2010 15:12, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 13 December 2010 01:20, ?<ykaoua@qualcomm.com> wrote:
>> --- /dev/null
>> +++ b/arch/arm/mach-msm/hotplug.c
> [...]
>> +static inline void platform_do_lowpower(unsigned int cpu)
>> +{
>> + ? ? ? /* Just enter wfe for now. */
>> + ? ? ? for (;;) {
>> + ? ? ? ? ? ? ? asm("wfe");
>> + ? ? ? ? ? ? ? if (pen_release == cpu) {
>> + ? ? ? ? ? ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ? ? ? ? ? ?* OK, proper wakeup, we're done
>> + ? ? ? ? ? ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? ? }
>> + ? ? ? ? ? ? ? smp_rmb();
>
> Do you need some barrier after wfe?

I checked with the hw people and it looks like we don't need a DSB
after an WFE (as you have in headsmp.S) since the hardware doesn't
speculate the loads beyond the WFE (lower power state). But in the
above case you may need some compiler barrier to avoid code
reordering.

-- 
Catalin
