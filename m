From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 May 2016 13:16:40 +0100
Subject: [BUG] CONFIG_UNINLINE_SPIN_UNLOCK important for Cortex-A9
In-Reply-To: <6689734.3ffZe38SoY@wuerfel>
References: <874m9eoetu.fsf@gmail.com> <4854518.jvbplH0SM0@wuerfel>
 <871t4io608.fsf@gmail.com> <6689734.3ffZe38SoY@wuerfel>
Message-ID: <20160531121640.GU19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 01:43:43PM +0200, Arnd Bergmann wrote:
> > [17827.758966] Unable to handle kernel paging request at virtual address 00001014
> 
> 0x1014 is a rather long offset, but still a plausible NULL pointer. The
> r10 register contains 0x1000, so this is probably an incorrect value and
> is being used as a pointer with offset 0x14 added in. With an objdump of
> your net/core/dev.o, we could see which pointer that was, to maybe figure
> out which lock is supposed to protect it and where that lock gets released.

Or maybe disassemble the code line.

   0:   e1a03006        mov     r3, r6
   4:   e12fff3c        blx     ip
   8:   e51b4058        ldr     r4, [fp, #-88]  ; 0xffffffa8
   c:   e1a0200a        mov     r2, sl
  10:   e59a3014        ldr     r3, [sl, #20]

So yes, sl (r10) is the base register, with an offset of 0x14.

> > [17827.766279] pgd = ee09c000
> > [17827.769003] [00001014] *pgd=3eba3831, *pte=00000000, *ppte=00000000
> > [17827.775383] Internal error: Oops: 17 [#1] SMP ARM
> > [17827.780108] Modules linked in: usbhid btusb btrtl btbcm btintel bluetooth flexcan smsc95xx usbnet mii ptxc(O)
> > [17827.790242] CPU: 1 PID: 372 Comm: stress-ng-socke Tainted: G           O    4.5.4 #1
> > [17827.797995] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > [17827.804536] task: ed614780 ti: eebba000 task.ti: eebba000
> > [17827.809977] PC is at __netif_receive_skb_core+0x328/0xa9c
> 
> Unfortunately in the middle of a rather long function, and I don't
> see a spin_unlock in this function, in fact it's not even called
> with a spinlock held, so it must be something more indirect.

On a kernel here, I have:

    1290:       e51b4058        ldr     r4, [fp, #-88]  ; 0xffffffa8
...
    12b0:       e5943014        ldr     r3, [r4, #20]
    12b4:       e5b37054        ldr     r7, [r3, #84]!  ; 0x54
    12b8:       e1570003        cmp     r7, r3
    12bc:       e2477014        sub     r7, r7, #20
    12c0:       0a00001f        beq     1344 <__netif_receive_skb_core+0x3c0>
...
    1314:       e1a0300a        mov     r3, sl
    1318:       e12fff3c        blx     ip
    131c:       e51b4058        ldr     r4, [fp, #-88]  ; 0xffffffa8
    1320:       e1a02007        mov     r2, r7
    1324:       e5971014        ldr     r1, [r7, #20]

So it's a list of some sort.  fp, #-88 is the first arg, so that's
the struct sk_buff pointer.

Adding debug info to the build, reveals that it's this:

        list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
                if (pt_prev)
                        ret = deliver_skb(skb, pt_prev, orig_dev);
                pt_prev = ptype;
        }

specifically, the load is for __read_once_size() inside
list_for_each_entry_rcu().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
