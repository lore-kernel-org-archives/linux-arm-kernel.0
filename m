From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Mon, 15 Nov 2010 21:07:38 -0800
Subject: [PATCH 10/11] ARM: pxa: add 32KHz timer as clock source
In-Reply-To: <alpine.LFD.2.00.1011121246000.13911@xanadu.home>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-6-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-7-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-8-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-9-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-10-git-send-email-haojian.zhuang@marvell.com>
	<alpine.LFD.2.00.1011121246000.13911@xanadu.home>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986C74A6@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Nicolas Pitre [mailto:nico at fluxnic.net]
>Sent: 2010?11?13? 1:50 AM
>To: Haojian Zhuang
>Cc: linux-arm-kernel at lists.infradead.org; Eric Miao
>Subject: Re: [PATCH 10/11] ARM: pxa: add 32KHz timer as clock source
>
>On Fri, 12 Nov 2010, Haojian Zhuang wrote:
>
>> PXA silicons are using 3MHz timer as default clock source. But it'll be stopped
>> counting in low power mode. Although 32KHz timer is slow, it can continue
>> counting in low power mode. While low power mode is implemented as idle,
>> stopped timer can't be accepted.
>>
>> Add 32KHz timer as an alternative clock source. User can switch clock source
>> on demand.
>
>Why are you doing this?  What's wrong with  having timers stopped when
>in sleep mode?  I don't think a 32K timer is precise enough for
>runtime usage in general.
>
>What you should do instead is to use the 32KHz timer to readjust OSCR
>when the CPU comes out of sleep mode.
>
>
>Nicolas

Hi Nicolas,

It's not suspend mode. It's idle mode. System will enter idle frequently and time shouldn't stop counting in idle time.

If we use 32KHz timer to compensate OSCR, the drifts on OSCR will be larger and larger. Because 32KHz time isn't precise. System time is based on our timer. I don't think this solution could be acceptable.

If we only use 32KHz timer, it can't meet precise time requirement in performance test.

So I use both clock source. While we need to get a precise time usage for performance calculating, we can switch clock source to fast clock. While we need to keep system to save power, we shouldn't care precise time at this time. We have to choose one in this scenario.

Thanks
Haojian
