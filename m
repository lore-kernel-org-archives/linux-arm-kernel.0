From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jan 2018 17:21:13 -0200
Subject: [PATCH v2 1/6] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <CAOMZO5DK9xq-DfPbyerLL8+CHcsBjmd=ZBP27gWswTbFv-W1fg@mail.gmail.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-2-marc.zyngier@arm.com>
 <20180110175322.GZ3875@atomide.com>
 <6662dd72-121c-0cfb-ea31-aeecad4c7d03@arm.com>
 <87c06809-e035-52d7-0822-5fffb402c1dd@ti.com>
 <671e1901-f321-0731-45c7-19732970923b@arm.com>
 <CAOMZO5DK9xq-DfPbyerLL8+CHcsBjmd=ZBP27gWswTbFv-W1fg@mail.gmail.com>
Message-ID: <CAOMZO5C5D-Wx8Fre5uhKAijiKi4An5nmtzAT5YbuMCNGOqUaqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Jan 29, 2018 at 4:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Marc,
>
> On Thu, Jan 11, 2018 at 7:03 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
>>> OK. in u-boot, I had helped on the following:
>>> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=5902f4ce0f2bd1411e40dc0ece3598a0fc19b2ae
>>>
>>> maybe be build off that?
>>
>> Turn that into something unconditional, and you'll be good.

Maybe by 'unconditional' you mean the revision check like this?

--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -249,16 +249,13 @@ skip_errata_801819:
        pop     {r1-r5}                 @ Restore the cpu info - fall through
 #endif

-#ifdef CONFIG_ARM_ERRATA_430973
        mrc     p15, 0, r0, c1, c0, 1   @ Read ACR

-       cmp     r2, #0x21               @ Only on < r2p1
-       orrlt   r0, r0, #(0x1 << 6)     @ Set IBE bit
+       orr     r0, r0, #(0x1 << 6)     @ Set IBE bit

        push    {r1-r5}                 @ Save the cpu info registers
        bl      v7_arch_cp15_set_acr
        pop     {r1-r5}                 @ Restore the cpu info - fall through
-#endif

 #ifdef CONFIG_ARM_ERRATA_621766
