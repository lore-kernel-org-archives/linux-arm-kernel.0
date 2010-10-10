From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sun, 10 Oct 2010 04:52:36 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009092127.GB20975@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<AANLkTinhwORqdWU43yr1AXJGZm2zPKGG+Q9twruNs2aH@mail.gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimQJLmDZPHtVJLCv9ZQgx_Yjh9=MOwOxMSAz4QX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 9, 2010 at 12:21 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> static unsigned long reserve_mem(struct meminfo *mi, unsigned long size)
> {
> ? ? ? ?unsigned long addr = ~0;
> ? ? ? ?int i;
>
> ? ? ? ?for (i = mi->nr_banks - 1; i >= 0; i--)
> ? ? ? ? ? ? ? ?if (mi->bank[i].size >= size) {
> ? ? ? ? ? ? ? ? ? ? ? ?mi->bank[i].size -= size;
> ? ? ? ? ? ? ? ? ? ? ? ?addr = mi->bank[i].start + mi->bank[i].size;
> ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? ?}
>
> ? ? ? ?return addr;
> }
>
> static void __init my_fixup(struct machine_desc *desc, struct tag *tags,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ?char **cmdline, struct meminfo *mi)
> {
> ? ? ? ?omapfb_buffer_phys = reserve_mem(mi, 32*1048576);
> ? ? ? ?if (omapfb_buffer_phys == ~0)
> ? ? ? ? ? ? ? ?pr_warn("Unable to allocate omapfb buffer\n");
> }
>
> Then later:
>
> ? ? ? ?omapfb_buffer = ioremap(omapfb_buffer_phys, 32*1048576);
>
> That's a damned simple and direct implementation of exactly what I
> described, and results in something which is much more architecturally
> correct than what's going on today.

I tried this, it doesn't work.

At the time 'fixup' is called, 'meminfo' is empty; the tags haven't
been parsed. So my solution is to move the memblock_add() after
'reserve', and pass 'meminfo' as an argument:

--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -272,8 +272,6 @@ void __init arm_memblock_init(struct meminfo *mi,
struct machine_desc *mdesc)
        int i;

        memblock_init();
-       for (i = 0; i < mi->nr_banks; i++)
-               memblock_add(mi->bank[i].start, mi->bank[i].size);

        /* Register the kernel text, kernel data and initrd with memblock. */
 #ifdef CONFIG_XIP_KERNEL
@@ -295,7 +293,10 @@ void __init arm_memblock_init(struct meminfo *mi,
struct machine_desc *mdesc)

        /* reserve any platform specific memblock areas */
        if (mdesc->reserve)
-               mdesc->reserve();
+               mdesc->reserve(mi);
+
+       for (i = 0; i < mi->nr_banks; i++)
+               memblock_add(mi->bank[i].start, mi->bank[i].size);

        memblock_analyze();
        memblock_dump_all();

-- 
Felipe Contreras
