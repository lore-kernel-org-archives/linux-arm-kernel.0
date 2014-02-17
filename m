From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 20:14:31 +0900
Subject: [PATCH] ARM: shmobile: Check MD21 at SMP boot in case of APMU
In-Reply-To: <CAMuHMdUiRb0VmtTw-v04Ex-YyfV00+ixQoDgE3yD8kKXxVWCxQ@mail.gmail.com>
References: <20140217063152.21876.6981.sendpatchset@w520>
 <CAMuHMdUiRb0VmtTw-v04Ex-YyfV00+ixQoDgE3yD8kKXxVWCxQ@mail.gmail.com>
Message-ID: <CANqRtoR1o+9NAwheRVffnY0LpdUKcK_hW9aAdZ_6+orav5vsXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 5:53 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Feb 17, 2014 at 7:31 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> On R-Car Gen2 SoCs such as r8a7790 and r8a7791 the hardware boot
>> mode bit MD21 indicates if hardware debug mode is enabled or not.
>>
>> In case hardware debug mode is enabled print a warning and refrain
>> from booting secondary CPU cores. Without this patch Koelsch boards
>> with SW8-4 set to OFF will hang at SMP boot.
>
> Ah, mine was set to OFF.
>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

> with one minor nit:
>
>>  int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>  {
>> +       /* Refrain boot when hardware debug mode is enabled */
>> +       if (rcar_gen2_read_mode_pins() & BIT(21)) {
>> +               pr_warn("Unable to boot CPU%d when MD21 is set\n", cpu);
>
> %u

Good catch, will send a V2.

Cheers,

/ magnus
