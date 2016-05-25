From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 25 May 2016 10:22:02 -0400
Subject: [PATCH 2/2] ARM: dts: Add async-bridge clock to MFC power domain
 for Exynos5420
In-Reply-To: <574558DF.1090000@samsung.com>
References: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
 <1464111662-15336-3-git-send-email-javier@osg.samsung.com>
 <574558DF.1090000@samsung.com>
Message-ID: <32174210-ad4e-8fae-1142-80e06dcd319f@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/25/2016 03:48 AM, Krzysztof Kozlowski wrote:
> On 05/24/2016 07:41 PM, Javier Martinez Canillas wrote:
>> The MFC IP is also inter-connected by an Async-Bridge so the CLK_ACLK333
>> has to be ungated during a power domain switch. Trying to do it when the
>> clock is gated will fail and lead to an imprecise external abort error
>> when the driver tries to access the MFC registers with the PD disabled.
>>
>> For example, if the s5p-mfc module is removed and the MFC PD turned off:
>>
>> [  186.835606] Power domain power-domain at 10044060 disable failed
>> [  186.835671] s5p-mfc 11000000.codec: Removing 11000000.codec
>> [  186.837670] Power domain power-domain at 10044060 disable failed
>>
>> And when the module is inserted again:
>>
>> [ 2395.176956] s5p_mfc_wait_for_done_dev:34: Interrupt (dev->int_type:0, command:12) timed out
>> [ 2395.177031] s5p_mfc_init_hw:272: Failed to load firmware
>> [ 2395.177384] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> [ 2395.177441] pgd = ec3b4000
>> [ 2395.177467] [00000000] *pgd=00000000
>> [ 2395.177507] Internal error: : 1406 [#1] PREEMPT SMP ARM
>> [ 2395.177550] Modules linked in: s5p_mfc mwifiex_sdio mwifiex uvcvideo s5p_jpeg v4l2_mem2mem videobuf2_vmalloc videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_core v4l2_common videodev media [last unloaded: s5p_mfc]
>> [ 2395.177774] CPU: 1 PID: 2382 Comm: v4l_id Tainted: G        W       4.6.0-rc6-next-20160502-00010-g7730dc64d2c1-dirty #179
>> [ 2395.177857] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [ 2395.177906] task: ed275500 ti: e6c8c000 task.ti: e6c8c000
>> [ 2395.177996] PC is at s5p_mfc_reset+0x1c4/0x284 [s5p_mfc]
>> [ 2395.178057] LR is at s5p_mfc_reset+0x1a4/0x284 [s5p_mfc]
>>
>> This patch fixes this issue by adding the CLK_ACLK333 as an Async-Bridge
>> clock for the MFC power domain, so the PD configuration works properly.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>>  arch/arm/boot/dts/exynos5420.dtsi | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Indeed patch #1 is not a hard dependency here because there are no other
> asb clocks. It is entirely obvious but works fine.
>

You are right, the reason why is not a hard dependency is because it fails
anyways so this patch (which will make it fail due the clock being missed)
won't have any effect.
 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Thanks!

> Unless all other patches are meant to current fixes cycle (and/or
> cc-stable), I do not plan to apply it now. I'll take it for v4.8, because:
> 1. Your previous patches are needed. Without them bind/unbind won't work.
> 2. This is not reproducible in a regular driver operation.
> 3. It needs clock change to actually be useful.
> 
> Is it okay?
>

Agreed, that's also why I didn't cc stable on this series.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
