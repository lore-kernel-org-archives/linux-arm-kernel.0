From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Tue, 24 Nov 2015 17:52:14 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <20151123130424.GQ8644@n2100.arm.linux.org.uk>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
 <5653099A.7020604@dev.rtsoft.ru> <56530AE6.2060407@dev.rtsoft.ru>
 <20151123130424.GQ8644@n2100.arm.linux.org.uk>
Message-ID: <5654799E.5080903@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Just booted mainline...  unline linux-imx, it does not try to init cpu1.
>>
>> However, imx6dl.dtsi from mainline also has both cpu at 0 and cpu at 1
>>
>> So missing piece in linux-imx is elsewhere :(
> 
> It works as you mentioned - and it relies upon the code you tried to
> modify.
> 
> The early boot code detects that the boot CPU is not SMP capable, so
> through SMP_ON_UP, it "turns off" SMP support by fixing up the code
> and making is_smp() return false.
> 
> This prevents smp_init_cpus() being called, which in turn prevents
> imx_smp_init_cpus() executing, which prevents the CPU possible mask
> including any CPU but the boot CPU.
> 
> As only the boot CPU is possible, this prevents the SMP code trying
> to bring any secondary CPUs online.

I'm still trying to understand what is going on, and my printk()s show
that this is not entirely true.

When smp_init() is entered on mainline om imx6s, cpu_possible_mask and
cpu_present_mask both contain two cpus. These get initialized in
arm_dt_init_cpu_maps() and stay unmodified since then.

But cpu_online() returns 1 for cpu0 and 0 from cpu1 - thus it is
cpu_online() check, not possible_mask or present_mask, that prevents
cpu1 initialization attempt.

Not sure I understand logic behind this. With the current code,
resulting cpu_possible_mask depends on CONFIG_SMP_ON_UP:
- if it is set, cpu_possible_mask contains (0 1), as initialized in
arm_dt_init_cpu_maps()
- if it is not set, cpu_possible_mask contains (0), since
imx_smp_init_cpus() removes 1 from there.

This does not seem to be intended difference.
