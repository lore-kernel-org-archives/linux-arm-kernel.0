From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jan 2018 16:41:07 -0200
Subject: [PATCH v2 1/6] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <671e1901-f321-0731-45c7-19732970923b@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-2-marc.zyngier@arm.com>
 <20180110175322.GZ3875@atomide.com>
 <6662dd72-121c-0cfb-ea31-aeecad4c7d03@arm.com>
 <87c06809-e035-52d7-0822-5fffb402c1dd@ti.com>
 <671e1901-f321-0731-45c7-19732970923b@arm.com>
Message-ID: <CAOMZO5DK9xq-DfPbyerLL8+CHcsBjmd=ZBP27gWswTbFv-W1fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jan 11, 2018 at 7:03 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

>> OK. in u-boot, I had helped on the following:
>> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=5902f4ce0f2bd1411e40dc0ece3598a0fc19b2ae
>>
>> maybe be build off that?
>
> Turn that into something unconditional, and you'll be good.

Do you mean like this?

--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -249,7 +249,6 @@ skip_errata_801819:
        pop     {r1-r5}                 @ Restore the cpu info - fall through
 #endif

-#ifdef CONFIG_ARM_ERRATA_430973
        mrc     p15, 0, r0, c1, c0, 1   @ Read ACR

        cmp     r2, #0x21               @ Only on < r2p1
@@ -258,7 +257,6 @@ skip_errata_801819:
        push    {r1-r5}                 @ Save the cpu info registers
        bl      v7_arch_cp15_set_acr
        pop     {r1-r5}                 @ Restore the cpu info - fall through
-#endif

 #ifdef CONFIG_ARM_ERRATA_621766
        mrc     p15, 0, r0, c1, c0, 1   @ Read ACR

Thanks
