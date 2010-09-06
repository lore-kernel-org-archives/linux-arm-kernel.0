From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 6 Sep 2010 18:17:12 +0800
Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init
	testing
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
Message-ID: <AANLkTik2FNBv-72C4L7PxBoMsTENSds-PvbAzxGd-h4y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

I tried your latest branch: devel-smp-on-unicore, kernel boots up but
got lots of WARN_ON fired:

---
------------[ cut here ]------------
[    1.149719] WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
[    1.149780] Modules linked in:
[    1.149841] [<c01b34c8>] (unwind_backtrace+0x0/0xe4) from
[<c01e939c>] (warn_slowpath_common+0x4c/0x64)
[    1.149902] [<c01e939c>] (warn_slowpath_common+0x4c/0x64) from
[<c01e93cc>] (warn_slowpath_null+0x18/0x1c)
[    1.149993] [<c01e93cc>] (warn_slowpath_null+0x18/0x1c) from
[<c0274730>] (pcpu_alloc+0x2fc/0x888)
[    1.150085] [<c0274730>] (pcpu_alloc+0x2fc/0x888) from [<c0279578>]
(sget+0x198/0x43c)
[    1.150146] [<c0279578>] (sget+0x198/0x43c) from [<c0279adc>]
(get_sb_ns+0x20/0x90)
[    1.150238] [<c0279adc>] (get_sb_ns+0x20/0x90) from [<c02791a4>]
(vfs_kern_mount+0x9c/0x18c)
[    1.150299] [<c02791a4>] (vfs_kern_mount+0x9c/0x18c) from
[<c0022280>] (init_mqueue_fs+0x68/0xc8)
[    1.150390] [<c0022280>] (init_mqueue_fs+0x68/0xc8) from
[<c01ac5d0>] (do_one_initcall+0xcc/0x1a4)
[    1.150451] [<c01ac5d0>] (do_one_initcall+0xcc/0x1a4) from
[<c0008760>] (kernel_init+0x148/0x210)
[    1.150543] [<c0008760>] (kernel_init+0x148/0x210) from
[<c01adcf8>] (kernel_thread_exit+0x0/0x8)
[    1.150604] ---[ end trace 1b75b31a2719ed74 ]---
---

It looks like we still missed to set some flag for chuck.

-Bryan

On Fri, Sep 3, 2010 at 8:09 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of Tony Lindgren
>> Sent: Thursday, September 02, 2010 11:13 PM
>> To: Russell King - ARM Linux
>> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> Bryan Wu; Will Deacon
>> Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early
>> init testing
>>
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
>> > On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
>> >
>> > > --- a/arch/arm/include/asm/smp_plat.h
>> > > +++ b/arch/arm/include/asm/smp_plat.h
>> > > @@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
>> > > ?#define UP(instr...) ? ? _str(instr)
>> > > ?#endif
>> > >
>> > > +static inline int smp_on_up(void)
>> > > +{
>> > > +#ifdef CONFIG_SMP_ON_UP
>> > > + int smp_on_up;
>> > > +
>> > > + asm( ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> > > + ? ? ? ? SMP(mov %0, #0) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> > > + ? ? ? ? UP(mov ?%0, #1) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> > > + ? ? ? ? : "=r" (smp_on_up));
>> > > +
>> > > + return smp_on_up;
>> > > +#else
>> > > + return 0;
>> > > +#endif
>> >
>> > I think this is the wrong approach - rather than a function which tells
>> us
>> > just if we are a SMP kernel running on UP, why not something which
>> returns
>> > whether we're running on SMP and use that to eliminate some of these
>> ifdefs?
>>
>> Sure. Will has something like this in his patches:
>>
>> static inline int cpu_is_part_of_mp_system(void)
>> {
>> ? ? ? u32 mpidr;
>> ? ? ? asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
>> ? ? ? return (mpidr >> 31) ? !(mpidr >> 30) : 0;
>> }
>
> I guess this register is only available on MP Core extensions.
>
> Regards,
> Santosh
>
