From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 22 Oct 2016 16:55:51 +0100
Subject: [RFC PATCH 0/8] Support GICv3 ITS and vITS in 32-bit mode
In-Reply-To: <1477042601-15227-1-git-send-email-vladimir.murzin@arm.com>
References: <1477042601-15227-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161022165551.07680200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016 10:36:33 +0100
Vladimir Murzin <vladimir.murzin@arm.com> wrote:

Hi Vladimir,

> Hi,
> 
> This series introduces GICv3 ITS and vITS to 32-bit world. The first
> six patches make it possible to use ITS in a 32-bit guest with vITS on
> 64-bit host. The last two patches extend vITS to 32-bit host.

I quite like this series, mostly because it deletes a bit of code and
fixes a number of shortcomings. My only gripes are than it doesn't
apply to my current tree (see my comment on patch 4), and that this
should effectively be split in two series: one enabling the ITS on
32bit, and the other switching on ITS emulation for 32bit KVM.
Effectively, these series are completely independent.

It also makes it easier for me to merge things as I don't have to
coordinate the merging strategy with... myself. ;-)

Please repost this once the GIC fixes have reached mainline, and this
should be in good shape for a quick merge.

> I used Andrea's its/v8 branch at [1] for testing with the following
> diff on top
> 
> diff --git a/arm/aarch32/arm-cpu.c b/arm/aarch32/arm-cpu.c
> index 27a8e17..16bba55 100644
> --- a/arm/aarch32/arm-cpu.c
> +++ b/arm/aarch32/arm-cpu.c
> @@ -12,7 +12,7 @@ static void generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  {
>  	int timer_interrupts[4] = {13, 14, 11, 10};
>  
> -	gic__generate_fdt_nodes(fdt, IRQCHIP_GICV2);
> +	gic__generate_fdt_nodes(fdt, kvm->cfg.arch.irqchip);
>  	timer__generate_fdt_nodes(fdt, kvm, timer_interrupts);
>  }
>  
> diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
> index 1632e3c..99231f6 100644
> --- a/arm/aarch32/include/kvm/kvm-arch.h
> +++ b/arm/aarch32/include/kvm/kvm-arch.h
> @@ -1,8 +1,8 @@
>  #ifndef KVM__KVM_ARCH_H
>  #define KVM__KVM_ARCH_H
>  
> -#define ARM_GIC_DIST_SIZE	0x1000
> -#define ARM_GIC_CPUI_SIZE	0x2000
> +#define ARM_GIC_DIST_SIZE	0x100000
> +#define ARM_GIC_CPUI_SIZE	0x200000
>  
>  #define ARM_KERN_OFFSET(...)	0x8000
>  
> 
> After passing --irqchip=gicv3-its --force-pci to kvmtool I can see
> that MSI is used:
> 
> # cat /proc/interrupts
>            CPU0       
>  18:       1251     GICv3  27 Level     arch_timer
>  28:          0   ITS-MSI 49152 Edge      virtio3-config
>  29:          0   ITS-MSI 49153 Edge      virtio3-input
>  30:          0   ITS-MSI 49154 Edge      virtio3-output
>  31:          0   ITS-MSI 32768 Edge      virtio2-config
>  32:          2   ITS-MSI 32769 Edge      virtio2-input.0
>  33:          1   ITS-MSI 32770 Edge      virtio2-output.0
>  34:          0   ITS-MSI   0 Edge      virtio0-config
>  35:        303   ITS-MSI   1 Edge      virtio0-requests
>  36:          0   ITS-MSI 16384 Edge      virtio1-config
>  37:        218   ITS-MSI 16385 Edge      virtio1-requests
> IPI0:          0  CPU wakeup interrupts
> IPI1:          0  Timer broadcast interrupts
> IPI2:          0  Rescheduling interrupts
> IPI3:          0  Function call interrupts
> IPI4:          0  CPU stop interrupts
> IPI5:          0  IRQ work interrupts
> IPI6:          0  completion interrupts
> Err:          0

Please also post these patches (I may try it in a model if I feel brave
enough...)!

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
