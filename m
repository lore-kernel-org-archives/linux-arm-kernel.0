From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 25 Jan 2011 21:18:13 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <AANLkTinNK75t1AQL9wdz4COAMAJ85o1SyY6STyHYCeDs@mail.gmail.com>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101231135.53384.marek.vasut@gmail.com>
	<AANLkTinNK75t1AQL9wdz4COAMAJ85o1SyY6STyHYCeDs@mail.gmail.com>
Message-ID: <201101252118.13500.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 January 2011 18:45:54 Bj?rn Forsman wrote:
> 2011/1/23 Marek Vasut <marek.vasut@gmail.com>:
> > On Friday 21 January 2011 18:46:48 Bj?rn Forsman wrote:
> >> 2011/1/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> > On Thu, Jan 20, 2011 at 08:18:10PM +0100, Bj?rn Forsman wrote:
> >> >> [   11.425363] cpufreq-core: saving 518144 as reference value for
> >> >> loops_per_jiffy; freq is 312000 kHz
> >> >> [   11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for
> >> >> frequency 624000 kHz
> >> 
> >> [snip]
> >> 
> >> > Is it possible to boot at 624MHz and report the resulting lpj?
> >> > Alternatively, call calibrate_delay() after the cpufreq switch to
> >> > 624MHz, disabling the 'printed' stuff and see what it reports.
> >> 
> >> Now I have an extra calibrate_delay() after cpufreq changes the
> >> frequency.
> >> 
> >> First call:
> >> Calibrating delay loop... 103.62 BogoMIPS (lpj=518144)
> >> 
> >> Second call:
> >> Calibrating delay loop... 622.59 BogoMIPS (lpj=3112960)
> >> 
> >> (udelay() is correct when having that second call.)
> >> 
> >> It seems cpufreq thinks it transitions from 312 to 624 MHz, but in
> >> reality it may be transitioning from 104 to 624 MHz (because it now
> >> runs 6 times as fast according to lpj). This may explain the udelay()
> >> error ratio (~0.32):
> >> 
> >>   104 MHz / 312 MHz = 0.3333..
> >> 
> >> I think this means either the clock speed or the jiffies interval do
> >> not match what the kernel thinks.
> >> 
> >> I also did some tests changing the clock speed in the bootloader. It
> >> seems like the only thing that works for the kernel is booting with a
> >> 104 MHz clock. Any other frequency and cpufreq will do bad things to
> >> udelay().
> >> 
> >> Any thoughts?
> >> 
> >> BTW, I failed at locating the jiffies implementation for PXA310. Any
> >> pointers?
> > 
> > DAMN.
> > 
> > I cannot replicate this. Bjorn, can you please write me a step-by-step
> > howto for morons?
> > 
> > Ah, also, please update your OBM2 and u-boot from openpxa_new branch ;-)
> 
> I updated OBM2, U-Boot and the kernel. The issue is now gone and
> udelay is correct. Yay!

Yay!
> 
> Below is a diff of two boot logs, one with old bootloaders and one
> with new. Notice the difference in kernel lpj and whether it thinks turbo
> mode is enabled or not. Both boots are with the same kernel (2.6.38-rc2).

Which means linux kernel probably blindly believes in what's in ACCR or whatever 
... which obviously isn't correct ? I smell a bug still.

> 
> Any idea why new bootloaders cause "write buffer coherency" failure
> (see below)? Do we need to worry?

We do, uboot left icache or dcache enabled, I'm not sure if it's disabled now 
before boot. But that shouldn't cause this, right ?

Cheers
> 
> --- boot.log	2011-01-25 17:24:37.000000000 +0100
> +++ boot2_openpxa_new.log	2011-01-25 17:24:39.000000000 +0100
> @@ -1,8 +1,10 @@
> -U-Boot 2010.06-00741-g48e5192-dirty (Dec 09 2010 - 10:13:49)
> +OpenPXA OBM 2, booting ... OK
> +
> +U-Boot 2010.12-02373-ga7a4c08 (Jan 24 2011 - 14:42:56)
> 
>  CPU: Marvell PXA31x A2
>  Clock: Core: 312MHz ; Turbo: x2
> -       [ SMC: 208MHz ; SRAM: 312MHz ; BUS: 312MHz ; DMC: 312MHz ]
> +       [ SMC: 208MHz ; SRAM: 312MHz ; BUS: 208MHz ; DMC: 260MHz ]
>  DRAM:  128 MiB
>  NAND:  512 MiB
>  In:    serial
> @@ -36,8 +38,8 @@
>  Memory policy: ECC disabled, Data cache writeback
>  RO Mode clock: 60.00MHz (inactive)
>  Run Mode clock: 312.00MHz (*24)
> -Turbo Mode clock: 624.00MHz (*2, inactive)
> -HSIO bus clock: 312.00MHz
> +Turbo Mode clock: 624.00MHz (*2, active)
> +HSIO bus clock: 208.00MHz
>  Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
>  Kernel command line: console=ttyS0,115200 root=/dev/nfs
> nfsroot=10.1.11.41:/srv/nfs ip=0
>  PID hash table entries: 512 (order: -1, 2048 bytes)
> @@ -59,10 +61,10 @@
>  NR_IRQS:288 nr_irqs:288 288
>  sched_clock: 32 bits at 3250kHz, resolution 307ns, wraps every 1321528ms
>  Console: colour dummy device 80x30
> -Calibrating delay loop... 103.83 BogoMIPS (lpj=519168)
> +Calibrating delay loop... 622.59 BogoMIPS (lpj=3112960)
>  pid_max: default: 32768 minimum: 301
>  Mount-cache hash table entries: 512
> -CPU: Testing write buffer coherency: ok
> +CPU: Testing write buffer coherency: failed, enabling work-around
>  NET: Registered protocol family 16
>  colibri_pxa3xx_init_eth(): no valid serial boot tag found, taking MAC
> from device
>  bio: create slab <bio-0> at 0
> 
> Best regards,
> Bj?rn Forsman
