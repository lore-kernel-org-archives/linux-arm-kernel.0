From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 8 Oct 2015 13:55:08 +0100
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <009901d101c7$3331b3b0$99951b10$@samsung.com>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <003a01d10199$58e96590$0abc30b0$@samsung.com> <20151008082302.GE14315@cbox>
 <005e01d101a9$31ee80f0$95cb82d0$@samsung.com> <20151008092858.GA16100@cbox>
 <561641F5.4060202@arm.com> <009501d101c4$dde8e2e0$99baa8a0$@samsung.com>
 <20151008123630.GC20936@cbox> <009901d101c7$3331b3b0$99951b10$@samsung.com>
Message-ID: <CAFEAcA8RWqipM7LRXc-Se6xJ9FkbVm=2Mr=pe1pB_NnS2wfsvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2015 at 13:45, Pavel Fedin <p.fedin@samsung.com> wrote:

>> Speaking of which, does the QEMU side of this patch set require first
>> adding the GICv3 emulation for the data structures or is there a
>> stand-alone migration patch set somewhere?
>
>  I rolled it out a week ago: https://www.mail-archive.com/qemu-devel at nongnu.org/msg325331.html. I
> tried to get reviewed/accepted/whatever at least data structure part, but Peter replied that he
> isn't interested before we have the kernel.

More specifically, I wanted us to agree on the kernel API for
migration, because that significantly affects how the QEMU
code looks.

A quick look at your patch suggests you still have data
structures like

+struct gicv3_irq_state {
+    /* The enable bits are only banked for per-cpu interrupts.  */
+    unsigned long *enabled;
+    unsigned long *pending;
+    unsigned long *active;
+    unsigned long *level;
+    unsigned long *group;
+    bool edge_trigger; /* true: edge-triggered, false: level-triggered  */
+    uint32_t mask_size; /* Size of bitfields in long's, for migration */
+};

I think it's probably going to be better to have an array
of redistributor structures (one per CPU), and then keep
the state that in hardware is in each redistributor inside
those sub-structures. Similarly for state that in hardware
is inside the distributor, and inside each cpu interface.

thanks
-- PMM
