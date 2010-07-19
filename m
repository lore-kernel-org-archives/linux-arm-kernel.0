From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Jul 2010 17:23:33 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
In-Reply-To: <002801cb243c$e0a70130$a1f50390$@deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>	<1279209238-16234-2-git-send-email-will.deacon@arm.com>	<1279209238-16234-3-git-send-email-will.deacon@arm.com>	<20100715163216.GI29322@n2100.arm.linux.org.uk>
	<002801cb243c$e0a70130$a1f50390$@deacon@arm.com>
Message-ID: <000601cb275e$bce3dcd0$36ab9670$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> > > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > > index c6844cb..45896a9 100644
> > > --- a/arch/arm/mm/flush.c
> > > +++ b/arch/arm/mm/flush.c
> > > @@ -120,8 +120,8 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> > >
> > >  	/* VIPT non-aliasing cache */
> > >  	if (vma->vm_flags & VM_EXEC) {
> > > -		unsigned long addr = (unsigned long)kaddr;
> > > -		__cpuc_coherent_kern_range(addr, addr + len);
> > > +		__cpuc_flush_dcache_area(kaddr, len);
> > > +		__flush_icache_all();
> >
> > NAK.
> >
> > If we have aliases in the I-cache, there's probably more places that
> > need to be fixed - and in any case I think the VIPT aliasing case
> > should be used in that instance.

So I looked into this problem a bit more in order to confirm it's an aliasing
issue.

GDB sets breakpoints inside ld-linux.so so that it can control the loading of
shared libraries and insert any pending breakpoints.

If the inferior has a PID of 3233, we can see the dynamic loader living at
0x40000000:

root at will-lucid-nfs:~/tmp# cat /proc/3233/maps
...
40000000-40016000 r-xp 00000000 00:0b 3493469    /lib/ld-2.11.1.so
40016000-40017000 rw-p 00000000 00:00 0 
4001d000-4001f000 rw-p 00015000 00:0b 3493469    /lib/ld-2.11.1.so

GDB tries to insert a breakpoint on __dl_debug_state, at address 0x40002590.
Some examples of when this works (I hacked flush_ptrace_access to print uaddr
and dst):

[  110.910000] writing to user address 0x40002590 using Kernel mapping 0xbfe6c590
...
[  147.530000] writing to user address 0x40002590 using Kernel mapping 0xbfe7e590

Now, this can fail with a SIGILL:

(gdb) start
Temporary breakpoint 1 at 0x83b4: file test.c, line 7.
Starting program: /root/tmp/test 

Program received signal SIGILL, Illegal instruction.
0x40002590 in ?? () from /lib/ld-linux.so.3

This happens when GDB has removed a breakpoint instruction, but it still exists
in the I-cache because the mapping used to invalidate the relevant way was of a
different colour. In dmesg, we see:

[  150.780000] writing to user address 0x40002590 using Kernel mapping 0xbfe8b590

The I-cache in use is a 4-way 32KB cache, so we need 13 bits to represent an
index into an 8KB way and a byte index into the resulting line. Since the top
bit is not invariant to address translation, we have two colours.

Looking at the GDB examples:

0x40002590 and 0xbfe6c590 have bit 12 == 0, so they are the same colour.
0x40002590 and 0xbfe7e590 have bit 12 == 0, so they are the same colour.
0x40002590 and 0xbfe8b590 have bit 12 == 0 and bit 12 == 1 respectively.

In the last case, the wrong colour is invalidated in the I-cache and a SIGILL
occurs. This problem can be fixed either by invalidating the whole I-cache
(which is what is done in the patch I posted) or we could invalidate the
correct colour, but this would mean implementing something like kmap_coherent
from the MIPS world.

It would be good to get this fixed. Do you still object to my original patch or
can I submit it to the patch system if I get some tested-bys?

Thanks,

Will
