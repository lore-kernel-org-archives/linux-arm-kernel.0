From: mario.smarduch@huawei.com (Mario Smarduch)
Date: Wed, 12 Jun 2013 08:56:21 +0200
Subject: [PATCH 2/2] add initial kvm dev passhtrough support
In-Reply-To: <2DDB038789B01B4B80B0D3F1FF7CBDC2214E9024@lhreml509-mbb.china.huawei.com>
References: <51B6D52E.4030707@huawei.com>
 <CAG8rG2zzasO--3y2HsKXBUpof6DXqNkvqxN1VZGQR4Q8f=iuUw@mail.gmail.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2214E9024@lhreml509-mbb.china.huawei.com>
Message-ID: <51B81B95.4090406@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending, initial email from my exchange client got rejected
due to HTML content

On 6/12/2013 8:45 AM, Mario Smarduch wrote:
>  
> 
Hi Antonios, 
     thanks for your feedback, initially we?ll work with static binding
     gain performance data given latency/throughput is key, later add dynamic
     binding (as well as re-optimize affinity code). And as you already
     know move towards VFIO, which is a longer term effort.
> 
> 
> +struct kvm_arm_assigned_dev_kernel {
> +       struct list_head list;
> +       struct kvm_arm_assigned_device dev;
> +       irqreturn_t (*irq_handler)(int, void *);
> +       void *irq_arg;
> +};
> +
> 
>  
> 
> Instead of irq_arg, isn't something such as target_vcpu more clear?
> 
>  
> 
MS> Agree.
> 
>  
> 
>     diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
>     index 17c5ac7..f4cb804 100644
>     --- a/arch/arm/kvm/vgic.c
>     +++ b/arch/arm/kvm/vgic.c
>     @@ -449,6 +449,41 @@ static u32 vgic_get_target_reg(struct kvm *kvm, int irq)
>             return val;
>      }
> 
>     +/* Follow the IRQ vCPU affinity so passthrough device interrupts are injected
>     + * on physical CPU they execute.
>     + */
>     +static void vgic_set_passthru_affinity(struct kvm *kvm, int irq, u32 target)
>     +{
>     +       struct list_head *dev_list_ptr = &kvm->arch.assigned_dev_head;
>     +       struct list_head *ptr;
>     +       struct kvm_arm_assigned_dev_kernel *assigned_dev;
>     +       struct vgic_dist *dist = &kvm->arch.vgic;
>     +       char *buf;
>     +       int cpu, hwirq;
>     +
>     +       mutex_lock(&kvm->arch.dev_pasthru_lock);
>     +       list_for_each(ptr, dev_list_ptr) {
>     +               assigned_dev = list_entry(ptr,
>     +                               struct kvm_arm_assigned_dev_kernel, list);
>     +               if (assigned_dev->dev.guest_res.girq == irq) {
>     +                       if (assigned_dev->irq_arg)
>     +                               free_irq(irq, assigned_dev->irq_arg);
>     +                       cpu = kvm->vcpus[target]->cpu;
>     +                       hwirq = assigned_dev->dev.dev_res.hostirq.hwirq;
>     +                       irq_set_affinity(hwirq, cpumask_of(cpu));
>     +                       assigned_dev->irq_arg = kvm->vcpus[target];
>     +                       buf = assigned_dev->dev.dev_res.hostirq.host_name;
>     +                       sprintf(buf, "%s-KVM Pass-through",
>     +                                       assigned_dev->dev.dev_res.devname);
>     +                       gic_spi_set_priodrop(hwirq);
>     +                       dist->guest_irq[hwirq - VGIC_NR_PRIVATE_IRQS] = irq;
>     +                       request_irq(hwirq, assigned_dev->irq_handler, 0, buf,
>     +                                                       assigned_dev->irq_arg);
>     +               }
>     +       }
>     +       mutex_unlock(&kvm->arch.dev_pasthru_lock);
>     +}
>     +
> 
>  
> 
> Maybe vgic_set_pasthru_affinity is not an ideal name for the function, since you do more than that here.
> 
> After looking at your code I think things will be much easier if you decouple the host irq affinity bits from here. After that there is not much stopping from affinity following the CPU a vCPU will execute.
> 
> I would rename this to something to reflect that you enable priodrop for this IRQ here, for example only vgic_set_passthrough could suffice (I'm don't like the pasthru abbreviation a lot). Then the affinity bits can be put in a different function.
> 
>  
> 
MJS> Agree naming could be better.
> 
> 
> 
> In arch/arm/kvm/arm.c kvm_arch_vcpu_load() you can follow up whenever a vcpu is moved to a different cpu. However in practice I don't know if the additional complexity of having the irq affinity follow the vcpu significantly improves irq latency.
> 
>  
> 
MJS>  This should save a costly IPI if for example Phys IRQ is taken on CPU 0
and target vCPU on CPU 1. I agree kvm_arch_vcpu_load() is a good place if you 
let vCPUs float. vigic_set_passthrough_affinity can be optimized more to eliminate 
the free_irq(), requesnt_irq(). For now it?s a simple implementation we?re
assuming static binding, start gathering performance/latency data. 
Will change the name as you suggest.
> 
> 
> 
> 
> -- 
> 
> *Antonios Motakis*, Virtual Open Systems*
> */Open Source KVM Virtualization Development
> /www.virtualopensystems.com <http://www.virtualopensystems.com>
> 
