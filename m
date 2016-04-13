From: robh@kernel.org (Rob Herring)
Date: Wed, 13 Apr 2016 08:17:56 -0500
Subject: [PATCH] arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip
In-Reply-To: <570E0BE4.2080007@arm.com>
References: <1459245786-11905-1-git-send-email-suzuki.poulose@arm.com>
 <20160412191149.GC4174@localhost> <570E0BE4.2080007@arm.com>
Message-ID: <CAL_Jsq+_2byE=Bd7cs_ULCnsWobKW3QQ+6XE8LVEqmu=R-ur8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 4:05 AM, Suzuki K Poulose
<Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 20:11, Olof Johansson wrote:
>>
>> On Tue, Mar 29, 2016 at 11:03:06AM +0100, Suzuki K Poulose wrote:
>>>
>>> Commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option"),
>>> added support for ARCH_SUNXI on arm64, but failed to select
>>> GENERIC_IRQ_CHIP, which is required for drivers/irqchip/irq-sunxi-nmi.c
>>> and causes build failures like :
>>>
>>>    UPD     include/generated/compile.h
>>>    CC      init/version.o
>>>    LD      init/built-in.o
>>> drivers/built-in.o: In function `sunxi_sc_nmi_set_type':
>>> drivers/irqchip/irq-sunxi-nmi.c:114: undefined reference to
>>> `irq_setup_alt_chip'
>>> drivers/built-in.o: In function `irq_domain_add_linear':
>>> include/linux/irqdomain.h:253: undefined reference to
>>> `irq_generic_chip_ops'
>>> include/linux/irqdomain.h:253: undefined reference to
>>> `irq_generic_chip_ops'
>>> drivers/built-in.o: In function `sunxi_sc_nmi_irq_init':
>>> drivers/irqchip/irq-sunxi-nmi.c:146: undefined reference to
>>> `irq_alloc_domain_generic_chips'
>>> drivers/irqchip/irq-sunxi-nmi.c:161: undefined reference to
>>> `irq_get_domain_generic_chip'
>>> drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to
>>> `irq_gc_mask_clr_bit'
>>> drivers/irqchip/irq-sunxi-nmi.c:171: undefined reference to
>>> `irq_gc_mask_set_bit'
>>> drivers/irqchip/irq-sunxi-nmi.c:172: undefined reference to
>>> `irq_gc_ack_set_bit'
>>> drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to
>>> `irq_gc_mask_clr_bit'
>>>
>>> Fixes: commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config
>>> option")
>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>>
>> It'd be nice to have a silent Kconfig entry that selects from ARCH_SUNXI
>> that
>> sets this dependency, instead of having it from the architecture code.
>> This
>> pushes down the dependency to the right level.
>
>
> Do you mean something like :
> config ARCH_SUNXI
>         ...
>         select SUNXI_PLATFORM
>
> And have
>
> config SUNXI_PLATFORM
>         select SUNXI_DEPENDENCY_1
>         select SUNXI_DEPENDENCY_2
>
> where SUNXI_PLATFORM drives the dependencies for both ARM and ARM64 ?

No, I believe what Olof is saying is make the kconfig symbol for the
irqchip (irq-sunxi-nmi) select it. If there is not a kconfig symbol
already for it because you just use ARCH_SUNXI directly, then add it.

Rob
