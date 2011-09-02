From: bill4carson@gmail.com (carson bill)
Date: Fri, 2 Sep 2011 11:01:04 +0800
Subject: KVM ARM interrupt virtualization
Message-ID: <CAOMgcGJoF74=q4uzuC+FGQYP3QiLEZvC+duJDAt0m8et8zmCqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

I am trying to put interrupt virtualization support into KVM ARM
implementation by Christoffer.

The approach is like this:

   Distributor emulation stays in Qemu, whenever Guest OS touch
   Distributor iomem, this action is handled by Qemu as it is.

   Each time a device in Qemu call 'gic_update' to inject an
   interrupt, the emulated Distributor figure out the 'best_irq'.
   With the help of GIC virtulization, this "best_irq" can be routed
   to virtual cpu interface which Guest OS has directly access into.

   Of course, when Guest OS query which interrupt fired, it need not
   trapped out into Qemu anymore.



How to do this:
   For now, I didn't take SMP into consideration.

   a: create identical mapping from GPA->HPA to allow Guest OS access
      its own cpu interface register.

   b: tell hypovisor the 'best_irq'
      struct kvm_irq_level->level upper bits could be used to represent
      this 'best_irq', and goes into hypovisor through KVM_IRQ_LINE IOCTL

   once inside kernel, 'kvm_arch_vm_ioctl_irq_line' fetch the 'best_irq'
   and by updating list register, route this interrupt into Guest OS
   virtual cpu interface.


Problem:
    I did the experiment, and found the biggest obstoble on the way
    is creating the mapping.

    arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
    #define CT_CA9X4_MPIC       (0x1e000000)
    #define A9_MPCORE_SCU       (CT_CA9X4_MPIC + 0x0000)
    #define A9_MPCORE_GIC_CPU   (CT_CA9X4_MPIC + 0x0100)
    #define A9_MPCORE_GIT       (CT_CA9X4_MPIC + 0x0200)
    #define A9_MPCORE_TWD       (CT_CA9X4_MPIC + 0x0600)
    #define A9_MPCORE_GIC_DIST  (CT_CA9X4_MPIC + 0x1000)

    If I create an identical mapping at A9_MPCORE_GIC_CPU, all the iomem
    from CT_CA9X4_MPIC ~ CT_CA9X4_MPIC + 0x1000 could be access for
    Guest OS, which means access to SCU/GIT/TWD will not been trapped
    any more.


Any comments and suggestions would be truly welcome.



bill
