From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Sep 2017 09:18:45 +0200
Subject: [PATCH v3 0/5] arm64: Initial Realtek RTD1295 enablement
In-Reply-To: <068148b5-7add-96e5-dc6d-4597527a6c35@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
 <068148b5-7add-96e5-dc6d-4597527a6c35@suse.de>
Message-ID: <CAK8P3a2gBk_rbO7fgpqiTW7A5oxhAPbz6rOjH-kOnOntBjdHSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 5, 2017 at 12:09 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 14.05.2017 um 04:24 schrieb Andreas F?rber:
>> This mini-series adds initial support for the Realtek RTD1295 SoC and
>> the Zidoo X9S TV box.
>>
>> v3 changes #address-cells, #size-cells and ranges.
>>
>> With these patches CPU0 can be booted with earlycon.
>>
>> PSCI doesn't work despite present in the vendor device tree; as enable-method
>> it instead used a custom "rtk-spin-table" that I sadly have no source code of.
>
> Synology has now published source code for RTD1293/1296. This has
> allowed me to narrow the RTD1295 CPU1..3 issue down to two changes in
> arch/arm64/kernel/smp_spin_table.c:smp_spin_table_cpu_prepare():
>
> 1) writel_relaxed() instead of writeq_relaxed()
> 2) ioremap() instead of ioremap_cache()
>
> Without those changes it hangs in earlycon after this line:
> [    0.043674] Mountpoint-cache hash table entries: 4096 (order: 3,
> 32768 bytes)
>
> The size difference sounds easy enough - we could introduce an optional
> cpu-release-size property to handle this or derive a "spin-table-32bit"
> enable-method to that effect.
>
> The second one appears to be caused by PROT_NORMAL vs.
> PROT_DEVICE_nGnRE. Is there any simple check we could do on
> cpu-release-addr to choose which MT to use?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=113954c6463d1d80a206e91627ae49711f8b47cd
>
> Any other ideas?

I think we had a similar problem before and concluded that something
requiring a write into an MMIO register is simply not a spin-table
implementation but something else.

Is this simply using a copy of the spin-table code to trigger the actual
booting of the secondary CPU? Can you identify the MMIO address?

      Arnd
