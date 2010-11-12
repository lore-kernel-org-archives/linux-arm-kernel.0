From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 00:47:50 -0800
Subject: [PATCH 03/11] ARM: pxa: split pxa93x from pxa3xx
In-Reply-To: <AANLkTikBrBeNoECUh9_xOmjEW8FLSgJ6jtBJcgS6fY-d@mail.gmail.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTikBrBeNoECUh9_xOmjEW8FLSgJ6jtBJcgS6fY-d@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C7026@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?12? 4:08 PM
>To: Haojian Zhuang
>Cc: linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 03/11] ARM: pxa: split pxa93x from pxa3xx
>
>On Fri, Nov 12, 2010 at 3:17 PM, Haojian Zhuang
><haojian.zhuang@marvell.com> wrote:
>> In order to avoid confusion, seperate pxa93x from pxa3xx.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> +void pxa93x_clear_reset_status(unsigned int mask)
>> +{
>> + ? ? ? /* RESET_STATUS_* has a 1:1 mapping with ARSR */
>> + ? ? ? ARSR = mask;
>> +}
>
>This is not necessary now.
>
Thanks. It's fixed now.

>> +
>> +/*
>> + * Return the current HSIO bus clock frequency
>> + */
>> +static unsigned long clk_pxa93x_hsio_getrate(struct clk *clk)
>> +{
>> + ? ? ? unsigned long acsr;
>> + ? ? ? unsigned int hss, hsio_clk;
>> +
>> + ? ? ? acsr = ACSR;
>> +
>> + ? ? ? hss = (acsr >> 14) & 0x3;
>> + ? ? ? hsio_clk = (acsr & ACCR_D0CS) ? RO_CLK : hss_mult[hss] * BASE_CLK;
>> +
>> + ? ? ? return hsio_clk;
>> +}
>
>Provided that the AP side is exactly same as PXA3xx, I'm still not
>convinced that PXA93x should be separated as a family.
>
Yes, HSIO is nearly same. But DVFM operation is different. And using separated file can avoid too much cpu id checking.

Changelog:
1. Remove pxa93x_clear_reset_status() implementation in pxa93x.c
2. Remove pxa93x_clear_reset_status() definition in generic.h

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-ARM-pxa-split-pxa93x-from-pxa3xx.patch
Type: application/octet-stream
Size: 29158 bytes
Desc: 0003-ARM-pxa-split-pxa93x-from-pxa3xx.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101112/2c788260/attachment-0001.obj>
