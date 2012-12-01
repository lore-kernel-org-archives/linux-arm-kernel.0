From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 20:05:58 -0500
Subject: [PATCH v4 5/5] ARM: KVM: arch_timers: Wire the init code and
 config option
In-Reply-To: <20121123163109.GM32200@mudshark.cambridge.arm.com>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154632.3274.37896.stgit@chazy-air>
 <20121123163109.GM32200@mudshark.cambridge.arm.com>
Message-ID: <CANM98qKGSAFJPkCZ3pcbPgCSzYunPYeNkYbRRrHk9ViqaDgcOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 11:31 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:46:32PM +0000, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> It is now possible to select CONFIG_KVM_ARM_TIMER to enable the
>> KVM architected timer support.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  arch/arm/kvm/Kconfig  |    7 +++++++
>>  arch/arm/kvm/Makefile |    1 +
>>  arch/arm/kvm/arm.c    |   11 +++++++++++
>>  arch/arm/kvm/vgic.c   |    1 +
>>  4 files changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
>> index 3c979ce..eaecb9f 100644
>> --- a/arch/arm/kvm/Kconfig
>> +++ b/arch/arm/kvm/Kconfig
>> @@ -58,6 +58,13 @@ config KVM_ARM_VGIC
>>       ---help---
>>         Adds support for a hardware assisted, in-kernel GIC emulation.
>>
>> +config KVM_ARM_TIMER
>> +        bool "KVM support for Architected Timers"
>> +     depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
>> +     select HAVE_KVM_IRQCHIP
>> +     ---help---
>> +       Adds support for the Architected Timers in virtual machines
>> +
>
> This should probably be default y
>
yes, good idea, they all should, like this:

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 60d3d2a..739500b 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -21,6 +21,7 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
 	select KVM_MMIO
+	select KVM_ARM_HOST
 	depends on ARM_VIRT_EXT && ARM_LPAE
 	---help---
 	  Support hosting virtualized guest machines. You will also
@@ -54,6 +55,7 @@ config KVM_ARM_VGIC
         bool "KVM support for Virtual GIC"
 	depends on KVM_ARM_HOST && OF
 	select HAVE_KVM_IRQCHIP
+	default y
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.

@@ -61,6 +63,7 @@ config KVM_ARM_TIMER
         bool "KVM support for Architected Timers"
 	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
 	select HAVE_KVM_IRQCHIP
+	default y
 	---help---
 	  Adds support for the Architected Timers in virtual machines

--

Thanks,
-Christoffer
