From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jan 2015 11:52:19 +0000
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <2868984.6iP3luxIAM@wuerfel>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
 <2868984.6iP3luxIAM@wuerfel>
Message-ID: <20150108115219.GS12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 09:33:05AM +0100, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 18:11:28 Florian Fainelli wrote:
> > Enabling CPU_DCACHE_DISABLE on a SMP capable system will prevent the
> > kernel from booting because of the following ldrex instruction in
> > arch_spin_lock:
> > 
> > (gdb) x/10i $pc
> > => 0xc053cfa8 <_raw_spin_lock+4>:       ldrex   r3, [r0]
> >    0xc053cfac <_raw_spin_lock+8>:       add     r2, r3, #65536  ; 0x10000
> > 
> > which is taken by the very first printk call:
> > 
> >     at /home/fainelli/work/linux/arch/arm/include/asm/spinlock.h:65
> >     fmt=0xc0637650 "\001\066Booting Linux on physical CPU 0x%x\n", args=<incomplete type>)
> >     at kernel/printk/printk.c:1525
> >     fmt=0xc05370f4 <printk+52> "\024\320\215\342\004\340\235\344\020\320\215\342\036\377/\341\017") at kernel/printk/printk.c:1688
> > 
> > ldrex requires exclusive monitor(s) (local or global) which are no longer
> > working when the Data cache is disabled in CP15 and will just hang the CPU
> > there.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> We stumbled on this a while back when Kaixu was trying to fix allmodconfig
> builds to run on real hardware, but never submitted it in the end when
> Russell didn't like some of the other parts required for that to work.
> 
> This one clearly makes sense independently.

What about platforms where exclusives to strongly ordered memory do work?

I seem to remember patches from Tony for the pstore/ram_core driver to
allow it to map stuff strongly ordered, and use exclusives on it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
