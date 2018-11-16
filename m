From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Fri, 16 Nov 2018 16:39:56 +0530
Subject: [PATCH] boot_constraint: Add constraints for earlycon on
 dragonboard 410c
In-Reply-To: <20181116105317.5zpbzhgt5cnssuki@vireshk-i7>
References: <20181116104607.26671-1-saiprakash.ranjan@codeaurora.org>
 <20181116105317.5zpbzhgt5cnssuki@vireshk-i7>
Message-ID: <83416a56-df25-caad-29be-a722f93c3008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2018 4:23 PM, Viresh Kumar wrote:
> Hi,
> 
> On 16-11-18, 16:16, Sai Prakash Ranjan wrote:
>> iface clock is shared with other drivers, which may reconfigure
>> this before the serial driver comes up. This may lead to
>> crashes like the one below where GCC_BLSP1_AHB_CLK is same across
>> multiple drivers like bam dma.
>>
>> <0>[    3.164471] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
>> <4>[    3.164479] Modules linked in:
>> <4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8-00008-ge033b9909fff-dirty #175
>> <4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>> <4>[    3.164508] pstate: 40000085 (nZcv daIf -PAN -UAO)
>> <4>[    3.164514] pc : msm_read.isra.2+0x20/0x50
>> <4>[    3.164520] lr : msm_read.isra.2+0x1c/0x50
>> <4>[    3.164526] sp : ffff000008033a50
>> <4>[    3.164531] x29: ffff000008033a50 x28: ffff000009486018
>> <4>[    3.164548] x27: 0000000000000001 x26: ffff7dfffe7ff070
>> <4>[    3.164565] x25: 0000000000000034 x24: ffff000009486000
>> <4>[    3.164582] x23: 0000000000000000 x22: ffff00000978e190
>> <4>[    3.164599] x21: ffff0000095e8228 x20: 0000000000000034
>> <4>[    3.164616] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
>> <4>[    3.164632] x17: 0000000000000000 x16: 0000000000000000
>> <4>[    3.164649] x15: ffff0000094a96c8 x14: ffff00008978e6bf
>> <4>[    3.164666] x13: ffff00000978e6cd x12: 0000000000000038
>> <4>[    3.164683] x11: ffff0000094c6000 x10: 0000000000000c24
>> <4>[    3.164699] x9 : ffff80003c89b400 x8 : ffff000008033970
>> <4>[    3.164716] x7 : ffff80000eb04100 x6 : 00000000000af304
>> <4>[    3.164732] x5 : 0000000000000c40 x4 : ffff80003c06f000
>> <4>[    3.164750] x3 : ffff80003c89b498 x2 : 0000000000000000
>> <4>[    3.164766] x1 : ffff80003ca68000 x0 : 0000000000000800
>> <0>[    3.164785] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
>> <4>[    3.164791] Call trace:
>> <4>[    3.164797]  msm_read.isra.2+0x20/0x50
>> <4>[    3.164804]  msm_reset_dm_count+0x44/0x80
>> <4>[    3.164810]  __msm_console_write+0x1c8/0x1d0
>> <4>[    3.164816]  msm_serial_early_write_dm+0x3c/0x50
>> <4>[    3.164823]  console_unlock.part.6+0x468/0x528
>> <4>[    3.164829]  vprintk_emit+0x210/0x218
>> <4>[    3.164835]  vprintk_default+0x48/0x58
>> <4>[    3.164841]  vprintk_func+0xf0/0x1c0
>> <4>[    3.164847]  printk+0x74/0x94
>> <4>[    3.164853]  sci_init+0x24/0x3c
>> <4>[    3.164859]  do_one_initcall+0x54/0x248
>> <4>[    3.164866]  kernel_init_freeable+0x210/0x378
>> <4>[    3.164872]  kernel_init+0x18/0x118
>> <4>[    3.164878]  ret_from_fork+0x10/0x1c
>> <0>[    3.164884] Code: aa1e03e0 8b214273 97e616f7 d503201f (b9400260)
>>
>> Link: https://lore.kernel.org/lkml/1cae8f10-55f5-20ce-9105-30af6f88bd6e at codeaurora.org/
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> ---
>>
>> This is purely dependent on boot constraint subsystem by Viresh.
>>
>> Link: https://lore.kernel.org/lkml/cover.1519380923.git.viresh.kumar at linaro.org/
>> ---
>>   drivers/soc/qcom/boot_constraint.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
> 
> Nice to see that the new subsystem has fixed your issue as well and
> thanks for the patch. I am afraid though that this patch isn't going
> to get merged anywhere as the subsystem isn't merged yet as Greg
> wasn't too confident [1] about it. We are looking for more use-cases
> apart from earlycon and clcd.
> 
> 

Hi Viresh,

Thanks for your time.

I wanted to get this patch out so that once we have enough use cases,
maybe we can add this as well.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
