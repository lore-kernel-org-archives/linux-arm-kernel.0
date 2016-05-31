From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 May 2016 15:12:30 +0200
Subject: [BUG] CONFIG_UNINLINE_SPIN_UNLOCK important for Cortex-A9
In-Reply-To: <20160531121640.GU19428@n2100.arm.linux.org.uk>
References: <874m9eoetu.fsf@gmail.com> <6689734.3ffZe38SoY@wuerfel>
 <20160531121640.GU19428@n2100.arm.linux.org.uk>
Message-ID: <11929103.x2FTA7ihIh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2016 1:16:40 PM CEST Russell King - ARM Linux wrote:
> 
> > > [17827.766279] pgd = ee09c000
> > > [17827.769003] [00001014] *pgd=3eba3831, *pte=00000000, *ppte=00000000
> > > [17827.775383] Internal error: Oops: 17 [#1] SMP ARM
> > > [17827.780108] Modules linked in: usbhid btusb btrtl btbcm btintel bluetooth flexcan smsc95xx usbnet mii ptxc(O)
> > > [17827.790242] CPU: 1 PID: 372 Comm: stress-ng-socke Tainted: G           O    4.5.4 #1
> > > [17827.797995] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > > [17827.804536] task: ed614780 ti: eebba000 task.ti: eebba000
> > > [17827.809977] PC is at __netif_receive_skb_core+0x328/0xa9c
> > 
> > Unfortunately in the middle of a rather long function, and I don't
> > see a spin_unlock in this function, in fact it's not even called
> > with a spinlock held, so it must be something more indirect.
> 
> On a kernel here, I have:
> 
>     1290:       e51b4058        ldr     r4, [fp, #-88]  ; 0xffffffa8
> ...
>     12b0:       e5943014        ldr     r3, [r4, #20]
>     12b4:       e5b37054        ldr     r7, [r3, #84]!  ; 0x54
>     12b8:       e1570003        cmp     r7, r3
>     12bc:       e2477014        sub     r7, r7, #20
>     12c0:       0a00001f        beq     1344 <__netif_receive_skb_core+0x3c0>
> ...
>     1314:       e1a0300a        mov     r3, sl
>     1318:       e12fff3c        blx     ip
>     131c:       e51b4058        ldr     r4, [fp, #-88]  ; 0xffffffa8
>     1320:       e1a02007        mov     r2, r7
>     1324:       e5971014        ldr     r1, [r7, #20]
> 
> So it's a list of some sort.  fp, #-88 is the first arg, so that's
> the struct sk_buff pointer.
> 
> Adding debug info to the build, reveals that it's this:
> 
>         list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
>                 if (pt_prev)
>                         ret = deliver_skb(skb, pt_prev, orig_dev);
>                 pt_prev = ptype;
>         }
> 
> specifically, the load is for __read_once_size() inside
> list_for_each_entry_rcu().

Ok, so this is an rcu protected list that gets written to using the function

void dev_add_pack(struct packet_type *pt)
{
        struct list_head *head = ptype_head(pt);

        spin_lock(&ptype_lock);
        list_add_rcu(&pt->list, head);
        spin_unlock(&ptype_lock);
}
EXPORT_SYMBOL(dev_add_pack);

and the respective __dev_remove_pack taking the same lock. These get called
once for each network protocol (which basically should never change) and
also for af_packet.c when registering a new listener.

Somehow we managed to get an invalid entry in the list, which could
be related to lots of af_packet registering/unregistering.

Does the stress-ng test case do that?

Do the other oops output logs have any relation to the above?

	Arnd
