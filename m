From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2011 16:35:05 +0100
Subject: KVM ARM interrupt virtualization
In-Reply-To: <CAOMgcGJoF74=q4uzuC+FGQYP3QiLEZvC+duJDAt0m8et8zmCqA@mail.gmail.com>
References: <CAOMgcGJoF74=q4uzuC+FGQYP3QiLEZvC+duJDAt0m8et8zmCqA@mail.gmail.com>
Message-ID: <CAHkRjk6Vm2yNLm8Gzk3+4mYAfiXVjufv2xc0Kc-6ac-oS4zytw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 September 2011 04:01, carson bill <bill4carson@gmail.com> wrote:
> I am trying to put interrupt virtualization support into KVM ARM
> implementation by Christoffer.
>
> The approach is like this:
>
> ? Distributor emulation stays in Qemu, whenever Guest OS touch
> ? Distributor iomem, this action is handled by Qemu as it is.
>
> ? Each time a device in Qemu call 'gic_update' to inject an
> ? interrupt, the emulated Distributor figure out the 'best_irq'.
> ? With the help of GIC virtulization, this "best_irq" can be routed
> ? to virtual cpu interface which Guest OS has directly access into.
>
> ? Of course, when Guest OS query which interrupt fired, it need not
> ? trapped out into Qemu anymore.
...
> Problem:
> ? ?I did the experiment, and found the biggest obstoble on the way
> ? ?is creating the mapping.
>
> ? ?arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
> ? ?#define CT_CA9X4_MPIC ? ? ? (0x1e000000)
> ? ?#define A9_MPCORE_SCU ? ? ? (CT_CA9X4_MPIC + 0x0000)
> ? ?#define A9_MPCORE_GIC_CPU ? (CT_CA9X4_MPIC + 0x0100)
> ? ?#define A9_MPCORE_GIT ? ? ? (CT_CA9X4_MPIC + 0x0200)
> ? ?#define A9_MPCORE_TWD ? ? ? (CT_CA9X4_MPIC + 0x0600)
> ? ?#define A9_MPCORE_GIC_DIST ?(CT_CA9X4_MPIC + 0x1000)
>
> ? ?If I create an identical mapping at A9_MPCORE_GIC_CPU, all the iomem
> ? ?from CT_CA9X4_MPIC ~ CT_CA9X4_MPIC + 0x1000 could be access for
> ? ?Guest OS, which means access to SCU/GIT/TWD will not been trapped
> ? ?any more.

Shouldn't you use the CT_CA15X4_MPIC base address? As for TWD, with
A15 we use the generic timers (which also have support for
virtualisation). The SCU doesn't need to be touched on A15, AFAIK.

With the VE/A15 memory map, the GIC Dist is placed at offset 0x1000
and the GIC CPU interface a 0x2000. I think the VGIC interfaces are
placed as follows:

base + 0x4000 - GICV (Virtual Machine CPU interface - same registers
as the physical GIC CPU interface)
base + 0x6000 - GICH (GIC Hypervisor control registers)

So you would have to map GICH inside the host OS to control the VGIC.
The guest OS would most likely want to use the same address as the
physical GIC CPU interface (at offset 0x2000). In this case, the host
OS needs to set up a stage 2 translation from the GIC CPU interface
physical page at offset 0x2000 to offset 0x4000 where the VGIC is
found.

-- 
Catalin
