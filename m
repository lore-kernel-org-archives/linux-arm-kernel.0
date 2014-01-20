From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Mon, 20 Jan 2014 09:03:16 +0000
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6sl
In-Reply-To: <30BEA0EF-C7F3-48FB-9B07-2C244788DD38@freescale.com>
References: <CACUGKYOgJDMO-xF9GC4Xh7+t6FDk6DwJ0iYX17Hh6LvqSjVa4Q@mail.gmail.com>
 <30BEA0EF-C7F3-48FB-9B07-2C244788DD38@freescale.com>
Message-ID: <953bc7807ffe45119eece19c803b047f@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Tobias and Shawn
	I debug into this issue today, the root cause is that we have a usleep_range(50, 500); in arch/arm/mach-imx/clk-pllv3.c's clk_pllv3_wait_lock function, which will cause kernel schedule during cpufreq change, and the idle thread has another clk operation which will cause mutex nest, and it will try to wake up previous mutex hold by cpufreq change's pll1 clk_set_rate.
	So, to fix this issue, we should not use any usleep in the wait function of pllv3's code, or we should not call any clk API in the imx6sl_set_wait_clk function. What do you think?

	BTW, I found another issue, if EVK board boot up with 396MHz, then the initialized clock parent status is wrong, as ARM is from PFD 396MHz, I will generate another patch to fix that once I have bandwidth.

Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Huang Yongcai-B20788
>Sent: Saturday, January 18, 2014 7:53 AM
>To: John Tobias
>Cc: <linux-arm-kernel@lists.infradead.org>; Shawn Guo
>Subject: Re: [PATCH] ARM: imx: add cpuidle support for i.mx6sl
>
>Hi, Tobias
>        I will debug it next week and feedback to you. Thanks.
>
>Sent from Anson's iPhone
>
>> ? 2014?1?18??7:42?"John Tobias" <john.tobias.ph@gmail.com> ???
>>
>> Hi Anson,
>>
>> My kernel for iMX6SL has a imx6q-cpufreq and I used your patch.
>> Unfortunately, the kernel crashes if the imx6sl_set_wait_clk being
>> called in imx6sl_enter_wait.
>>
>> [  288.166905] [<80044b80>] (dequeue_task+0x0/0xc8) from [<80045650>]
>> (deactivate_task+0x30/0x34)
>> [  288.176403] [<80045620>] (deactivate_task+0x0/0x34) from
>> [<8050ac88>] (__schedule+0x318/0x58c) [  288.185848] [<8050a970>]
>> (__schedule+0x0/0x58c) from [<8050af34>]
>> (schedule+0x38/0x88)
>> [  288.194758] [<8050aefc>] (schedule+0x0/0x88) from [<8050b1c8>]
>> (schedule_preempt_disabled+0x10/0x14)
>> [  288.204858] [<8050b1b8>] (schedule_preempt_disabled+0x0/0x14) from
>> [<8050bcd4>] (mutex_lock_nested+0x16c/0x334) [  288.215850]
>> [<8050bb68>] (mutex_lock_nested+0x0/0x334) from [<8034763c>]
>> (clk_prepare_lock+0x90/0x104) [  288.226041] [<803475ac>]
>> (clk_prepare_lock+0x0/0x104) from [<80349254>]
>> (clk_set_rate+0x1c/0xbc) [  288.235535]  r6:806fd360 r5:00000000
>> r4:bf817f80 r3:80713d80 [  288.242679] [<80349238>]
>> (clk_set_rate+0x0/0xbc) from [<8001e574>]
>> (imx6sl_set_wait_clk+0x28/0x70)
>> [  288.252354]  r5:00000043 r4:00000001 [  288.256585] [<8001e54c>]
>> (imx6sl_set_wait_clk+0x0/0x70) from [<8001def4>]
>> (imx6sl_enter_wait+0x24/0x2c) [  288.266684]  r5:00000043 r4:00000001
>> [  288.270949] [<8001ded0>] (imx6sl_enter_wait+0x0/0x2c) from
>> [<80317608>] (cpuidle_enter_state+0x44/0xfc) [  288.281051]
>> r4:13bf2645 r3:8001ded0 [  288.285682] [<803175c4>]
>> (cpuidle_enter_state+0x0/0xfc) from [<803177bc>]
>> (cpuidle_idle_call+0xfc/0x150) [  288.295871]  r8:806e00d8 r7:00000001
>> r6:00000000 r5:80c58034 r4:806fd360 [  288.304428] [<803176c0>]
>> (cpuidle_idle_call+0x0/0x150) from [<8000fa68>]
>> (arch_cpu_idle+0x10/0x44) [  288.314108]  r9:8070970a r8:8070970a
>> r7:806d2000 r6:806da0dc r5:806d2000
>> r4:806d2000
>> [  288.323611] [<8000fa58>] (arch_cpu_idle+0x0/0x44) from [<800590f4>]
>> (cpu_startup_entry+0xe0/0x120)
>> [  288.333460] [<80059014>] (cpu_startup_entry+0x0/0x120) from
>> [<80503c8c>] (rest_init+0xcc/0xdc) [  288.342810]  r7:ffffffff
>> r3:00000000 [  288.347115] [<80503bc0>] (rest_init+0x0/0xdc) from
>> [<806a2b00>]
>> (start_kernel+0x348/0x354)
>> [  288.356099]  r6:806da040 r5:806da040 r4:806da150 [  288.361972]
>> [<806a27b8>] (start_kernel+0x0/0x354) from [<80008070>]
>> (0x80008070)
>>
>>
>> Regards,
>>
>> john
>>
>>
