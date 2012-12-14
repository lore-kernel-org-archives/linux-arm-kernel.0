From: hechtb@gmail.com (Bastian Hecht)
Date: Fri, 14 Dec 2012 16:07:13 +0100
Subject: [PATCH 1/2] ARM: SH-Mobile: sh73a0: Secondary CPUs handle own SCU
 flags
In-Reply-To: <50CB324F.4090405@gmail.com>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
 <50CB324F.4090405@gmail.com>
Message-ID: <CABYn4sz6feSqpK_xQUT+Ch4gYmxNdJWyX8XegmpYnLANqEyfdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

thanks for commenting on this.

>>
>> -static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
>> -{
>> -     void __iomem *scu_base = scu_base_addr();
>> -
>> -     spin_lock(&scu_lock);
>> -     tmp = __raw_readl(scu_base + 8);
>> -     tmp &= ~clr;
>> -     tmp |= set;
>> -     spin_unlock(&scu_lock);
>> -
>> -     /* disable cache coherency after releasing the lock */
>> -     __raw_writel(tmp, scu_base + 8);
>
> None of this locking was needed as the power status register is byte
> accessible.

Even if we switch to byte access here we would need protection, as the
SCU power register gets touched from different CPUs.

>> -}
>> -
>>  static unsigned int __init sh73a0_get_core_count(void)
>>  {
>>       void __iomem *scu_base = scu_base_addr();
>> @@ -82,9 +65,6 @@ static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct
>>  {
>>       cpu = cpu_logical_map(cpu);
>>
>> -     /* enable cache coherency */
>> -     modify_scu_cpu_psr(0, 3 << (cpu * 8));
>> -
>
> So simply changing this to scu_power_mode call would accomplish the same
> thing and avoid all the assembly.

Yes that was exactly my fail try before. See
http://www.spinics.net/lists/linux-sh/msg13685.html
It broke the bringing up of secondary CPUs completely as
sh73a0_boot_secondary() is running on CPU0 when booting CPU1. So
scu_power_mode() changed the registers of the wrong CPU.

cheers,

 Bastian
