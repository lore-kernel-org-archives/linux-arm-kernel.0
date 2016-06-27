From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Jun 2016 10:13:05 +0100
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
Message-ID: <5770EE21.90103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Thanks Maxime for pointing me to this discussion, +RMK]

Hi Hans,

On 26/06/16 17:00, Hans de Goede wrote:
> Hi,
> 
> I've just spend most of my Sunday debugging a problem
> where Allwinner ARM SoC based boards will not shutdown when
> using a Fedora 24 userland, where as the exact same
> kernel works fine with Fedora 22.
> 
> It turns out that irq-balanced is to blame. In Fedora 24
> it pins the i2c controller, which talks to the pmic
> which is needed for poweroff to cpu-id 1:
> 
> [root at localhost ~]# cat /proc/irq/49/smp_affinity
> 2
> 
> Where as the reboot_cpu is cpu-id 0 and with
> cpu 1 disabled at poweroff time, the i2c transfer
> never gets past its first step leading to an i2c
> driver timeout + kernel panic due to machine_power_off()
> returning.
> 
> As a workaround I can stop irq-balanced and do:
> 
> echo 3 > /proc/irq/49/smp_affinity
> 
> Before doing poweroff and then everything works as
> expected again.
> 
> Now the question is how to fix this?

[...]

I'm wondering if that's not an effect of this patch:

https://lkml.org/lkml/2015/9/24/138

missing on the ARM side (the corresponding arm64 patch is 217d453d473c).

Otherwise, can you instrument the GIC set_affinity method and find out
if we're even trying to move this IRQ away from the CPU that is being
torn down?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
