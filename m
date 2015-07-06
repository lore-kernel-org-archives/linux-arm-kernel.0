From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 6 Jul 2015 16:48:38 +0200
Subject: weird behavior of get/set_fiq_regs()
Message-ID: <CAOpc7mHkynAfmZKJhbwF0q0rco+3t7=wzh9owf6Brz6fmPRHsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to write a FIQ ISR handler. I wanted to use some registers
to transfer information to/from the the FIQ ISR. But something changes
the registers:

My_probe() does basically this:

    struct pt_regs regs;
    set_fiq_handler(&flexfiq_start, &flexfiq_end - &flexfiq_start);
    printk("##HS OCRAM %p", priv->ocram);
    regs.ARM_r8 = (long)priv->ocram;
    set_fiq_regs(&regs);
    set_fiq_handler(&myfiq_start, &myfiq_end - &myfiq_start);
    get_fiq_regs(&regs);
    printk("##HS %s:%d r8 %08lx\n", __func__, __LINE__, regs.ARM_r8);
    release_fiq(&fiq_handler);

Directly there, inside the probe() function, a call to get_fiq_regs()
will return what I have just set:

[ 5443.830458] ##HS OCRAM f1800000
[ 5444.956159] ##HS set_fiq_reqs
[ 5443.830487] ##HS my_probe:380 r8 f1800000


But not in my_remove():

    get_fiq_regs(&regs);
    printk("##HS %s:%d r8 %08lx\n", __func__, __LINE__, regs.ARM_r8);
    release_fiq(&fiq_handler);

[ 5444.956145] ##HS my_remove:401 r8 f1700000
[ 5444.956159] ##HS set_fiq_reqs



My FIQ ISR is currently a noop:

myfiq_start:
    subs pc, lr, #4
myfiq_end:

(My plan was to modify r8 intentionally in the ISR, so that I see
if/that my FIQ isr was actually called)



The output of this is:

The output line "set_fiq_reqs is from printk in
arch/arm/include/asm/fiq.h, I wanted to make sure that no-one else is
calling set_fiq_reqs. Then 2nd output you see is from
release_fiq(&fiq_handler) in my_remove(), so this is to be expected.


Hardware is an i.MX6, Kernel is 3.18.17 (but even Linux-GIT doesn't
show any FIQ related of importance: I don't think the "ret" macro to
use "bx" on ARMv6 makes a difference).
