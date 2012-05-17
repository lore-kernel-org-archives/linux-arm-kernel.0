From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 17 May 2012 12:32:00 +0530
Subject: [PATCHv2 06/19] ARM: OMAP4: PM: Add SAR backup support towards
 device OFF
In-Reply-To: <87aa177my3.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-7-git-send-email-t-kristo@ti.com> <87aa177my3.fsf@ti.com>
Message-ID: <CAMQu2gznJ0q-Eqevh9dWn+vw69to91kfFG6hYDvTbGj3zwT0FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 4:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> The SAR RAM is maintained during Device OFF mode.
>
> so why is this patch bothering to save and restore it?
>
SAR RAM is maintained(not powered down) but somebody needs to
feel the contents which will be preserved :-)

> -ECONFUSED
>
>> The register layout
>> is fixed in SAR ROM. SAR is split into 4 banks with different
>> privilege accesses based on device type
>>
>> ?---------------------------------------------------------------
>> ?Access mode ? ? ? ? ?Bank ? ?Address Range
>> ?---------------------------------------------------------------
>> ?HS/GP : Public ? ? ? ? ? ? ? 1 ? ? ? 0x4A32_6000 - 0x4A32_6FFF (4kB)
>> ?HS/GP : Public ? ? ? ? ? ? ? 2 ? ? ? 0x4A32_7000 - 0x4A32_73FF (1kB)
>>
>> ?HS/EMU : Secured
>> ?GP : Public ? ? ? ? ?3 ? ? ? 0x4A32_8000 - 0x4A32_87FF (2kB)
>>
>> ?HS/GP :Secure
>> ?write once. ? ? ? ? ?4 ? ? ? 0x4A32_9000 - 0x4A32_93FF (1kB)
>> ?---------------------------------------------------------------
>>
>> The save process is done entirely by software and restore is done by
>> hardware using the auto-restore feature. The restore feature is enabled
>> by default and cannot be disabled. The software must save the data
>> to be restored in a dedicated location in SAR RAM.
>
> Some general comments:
>
> - can the cluster PM notifier be used for the save path?
>
Nope. This is for device OFF only case. CPU Cluster state as such
has no dependency.

> - This patch adds lots of data that is immediately removed by the next
> ?patch. ?Probably the two just need to be combined.
>
iormap() hunk from this patch can be completely dropped since
it is getting fixed in next patch. Other infrastructure is maintained.

> - BUG_ON() should not be used unless there is absolutely no recovery
> ?path, since it casues a full kernel panic. ? Instead, some error
> ?recovery should be added.
>
WARN_ON should suffice.
