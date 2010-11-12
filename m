From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 00:53:33 -0800
Subject: [PATCH 04/11] ARM: pxa: update to read ICHP
In-Reply-To: <AANLkTinn2=G35motQoQhGbw+rk7cQ9trBxqPQKBcj+af@mail.gmail.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTinn2=G35motQoQhGbw+rk7cQ9trBxqPQKBcj+af@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C7028@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?12? 4:35 PM
>To: Haojian Zhuang
>Cc: linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 04/11] ARM: pxa: update to read ICHP
>
>On Fri, Nov 12, 2010 at 3:17 PM, Haojian Zhuang
><haojian.zhuang@marvell.com> wrote:
>> ICHP records the highest priority interrupt occured. In PXA27x/PXA3xx, we
>> can read ICHP via cooprocessor. In PJ4, we can only read ICHP via bus
>> register. So use the same method to read ICHP via bus register.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> ---
>> ?arch/arm/mach-pxa/include/mach/entry-macro.S | ? ?6 +++++-
>> ?1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-
>pxa/include/mach/entry-macro.S
>> index a73bc86..91457dd 100644
>> --- a/arch/arm/mach-pxa/include/mach/entry-macro.S
>> +++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
>> @@ -41,11 +41,15 @@
>> ? ? ? ? ? ? ? ?b ? ? ? 1001f
>> ?1002:
>> ? ? ? ? ? ? ? ?@ Core Generation 2 (PXA27x) or Core Generation 3 (PXA3xx)
>> - ? ? ? ? ? ? ? mrc ? ? p6, 0, \irqstat, c5, c0, 0 ? ? ?@ ICHP
>> + ? ? ? ? ? ? ? @ or Core PJ4
>> + ? ? ? ? ? ? ? mov ? ? \base, #io_p2v(0x40000000) ? ? ?@ IIR Ctl = 0x40d00000
>> + ? ? ? ? ? ? ? add ? ? \base, \base, #0x00d00000
>> + ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base, #0x18] ? ? ? ?@ ICHP offset
>
>Accessing from co-processor is supposed to be faster than MMIO.
>
>BTW, this could be addressed by MULTI_IRQ_HANDLER as in patch:
>
>http://www.spinics.net/lists/arm-kernel/msg88817.html
>
>Once it gets merged.
>
No problem. I can reformat this patch for MULTI_IRQ_HANDLER after it merged. You can skip this patch from current patch series since it won't impact old silicons.

Thanks
Haojian
