From: Claudio.Fontana@huawei.com (Claudio Fontana)
Date: Tue, 27 Nov 2012 09:39:13 +0100
Subject: [PATCH 0/1 RESEND 2] ARM: plat-versatile: move secondary CPU startup
 out of .init.
Message-ID: <50B47C31.2040709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

I am implementing virtual CPU hotplug for the the ARM Cortex A-15 VExpress motherboard.
This is mainly a QEMU feature, which allows dynamically changing the number
of CPUs in the guest.

I stumbled upon a limitation in the kernel support for plat-versatile,
which contains the secondary CPU startup code for the VExpress.

Basically, the secondary CPU startup code is preceded by the macro __INIT,
which causes the code to be freed in free_initmem() during kernel_init().

This means that any attempt at hot-booting CPUs in the guest results in
VCPUs jumping to a memory address that was freed, after which the VCPU
behaves erratically, as can be expected.

With this patch applied, we use __CPUINIT instead of __INIT, so that
the right thing happens:
under CONFIG_HOTPLUG_CPU, the secondary CPU startup code is not freed,
the secondary VCPUs start successfully, and it's all gardens and blue skies.

Tested successfully using the ARM fast models for the Cortex-A15.

--
Claudio Fontana (1):
  ARM: plat-versatile: move secondary CPU startup code out of .init.

 arch/arm/plat-versatile/headsmp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.12.1
