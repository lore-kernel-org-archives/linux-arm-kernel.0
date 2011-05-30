From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 29 May 2011 18:45:17 -0700
Subject: [PATCH 2/2] ARM: S5P: Add 64bit PWM timer counter for	sched_clock
In-Reply-To: <20110528071710.GU24876@n2100.arm.linux.org.uk>
References: <1306534210-32659-1-git-send-email-kgene.kim@samsung.com>
	<1306534210-32659-2-git-send-email-kgene.kim@samsung.com>
	<20110528071710.GU24876@n2100.arm.linux.org.uk>
Message-ID: <4DE2F6AD.5000000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/11 00:17, Russell King - ARM Linux wrote:
> On Fri, May 27, 2011 at 03:10:10PM -0700, Kukjin Kim wrote:
>> From: Sangbeom Kim<sbkim73@samsung.com>
>>
>> Basically, PWM timer works with 33Mhz on S5P SoCs and counter
>> overflow every 128 secs. So it is needed 64-bit counter for
>> supporting proper sched_clock() by 32-bit timer. This patch
>> handle overflow control and can solve the problem of suspend
>> to resume
>
> NAK.
>
> This patch is a backwards step, and adds a hell of a lot of complexity
> which should already be dealt with in generic code.
>
Yes, I agree :)

> What is "problem of suspend to resume" exactly?
>
Could you please check below?

<6>[   43.125215] request_suspend_state: sleep (0->3) ...(snip)...
<6>[   43.385289] PM: Syncing filesystems ... done.
<4>[   43.391553] Freezing user space processes ...(snip)...
<4>[   43.408781] Freezing remaining freezable tasks ...(snip)...
<6>[   43.558009] PM: suspend of devices complete ...(snip)...
<6>[   43.558514] PM: late suspend of devices complete ...(snip)...

<7>[  128.784602] S5P_WAKEUP_STAT 0x1
<7>[  128.784602] EINT_PEND 0x6, 0x0, 0x60, 0x40

<6>[    0.000319] PM: early resume of devices complete ...(snip)...
<6>[    0.000595] wakeup wake lock: gpio_input
<6>[    0.321657] PM: resume of devices complete ...(snip)...
<4>[    0.321976] Restarting tasks ...
<6>[    0.325617] request_suspend_state: wakeup (3->0) ...(snip)...
<4>[    0.342688] done.
<6>[    0.342917] suspend: exit suspend, ret = 0 ...(snip)...

Yeah, the timestamp jumped back after a suspend/resume cycle.
Do you have any idea about that?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
