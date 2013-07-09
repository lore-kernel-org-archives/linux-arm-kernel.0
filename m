From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 9 Jul 2013 10:29:14 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v2
In-Reply-To: <201307090121.50685.arnd@arndb.de>
References: <20130626235837.11576.86389.sendpatchset@w520>
 <201306271401.13198.arnd@arndb.de>
 <CANqRtoRR-pyCpXYwKXRYSfVOewv+dXf=ntofJJsKQ0defF5-MQ@mail.gmail.com>
 <201307090121.50685.arnd@arndb.de>
Message-ID: <CANqRtoR5tgHBg_kgb7-jde6VLwXyCe5XhPs-v_PDtO12GqGM-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 9, 2013 at 8:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 July 2013, Magnus Damm wrote:
>> >> +static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
>> >> +{
>> >> +     void __iomem *p;
>> >> +     unsigned int k;
>> >> +
>> >> +     shmobile_boot_fn = virt_to_phys(shmobile_invalidate_start);
>> >> +
>> >> +     /* MERAM for jump stub, because BAR requires 256KB aligned address */
>> >> +     p = ioremap_nocache(MERAM, 16);
>> >> +     memcpy(p, shmobile_boot_vector, 16);
>> >> +     iounmap(p);
>> >
>> > On the other hand here you have to use __raw_writel() or
>> > memcpy_toio() because memcpy cannot operate on __iomem tokens.
>> >
>> > Also, if this is actually memory, you probably want to use ioremap_cached
>> > or ioremap_writecombine.
>>
>> Yeah, I realize this may be a bit of a mess. So say that I used
>> ioremap_cached() here, I think I still need to flush the cache to make
>> sure the secondary processors have valid code available then they
>> boot. I suppose you're fine with that?
>
> Is that required to get the data from dcache to icache? If so, that
> sounds right.

Good point. I sort of assumed that the secondary CPU cores booted with
cache disabled, but I may be wrong.

Thanks,

/ magnus
