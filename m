From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 11 Mar 2014 16:28:05 +0800
Subject: SMP Documentation?
In-Reply-To: <531E1100.6060408@borg.org>
References: <531A52F3.1010303@borg.org> <531E1100.6060408@borg.org>
Message-ID: <CAGsJ_4yT6nRCBSPUZJHKhukFubK8XhpuGoR7i8wvw2=o210Lkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kent,

2014-03-11 3:22 GMT+08:00 Kent Borg <kentborg@borg.org>:
> On 03/07/2014 06:14 PM, I wrote:
>>
>> Is there any documentation on the semantics of the SMP ops
>
>
> <crickets>
>
> It seems there is not any documentation, and no one has lept forward to
> write some for little ol' me.
>
> But fear not!  I noticed mention the SMP work for rockchip going by on the
> list...and it looks analogous to what I need to do.  So I am going to start
> cribbing from that.

you can read CSR codes for marco. we have one
struct smp_operations sirfsoc_smp_ops __initdata = {
        .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
        .smp_secondary_init     = sirfsoc_secondary_init,
        .smp_boot_secondary     = sirfsoc_boot_secondary,
#ifdef CONFIG_HOTPLUG_CPU
        .cpu_die                = sirfsoc_cpu_die,
#endif
};

in sirfsoc_smp_prepare_cpus, we enable SCU for cache coherence of SMP,
 sirfsoc_secondary_init() is executed by 2nd core which will clear
pen_release.
sirfsoc_boot_secondary is the code for the cpu0 to wake up the 2nd
core, after waking, the cpu0 will wait for 2nd core to set pen_release
to -1.

>
>
> Thanks,
>
> -kb, the Kent who, alas, will still probably darken your inbox in the
> future.
>
-barry
