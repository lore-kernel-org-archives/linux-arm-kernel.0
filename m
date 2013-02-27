From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 27 Feb 2013 12:22:20 +0100
Subject: SMDKV210 support issue in kernel 3.8 (dma-pl330 and HDMI failed)
In-Reply-To: <CAG17yqQ3d+3Uwpfo+_r0Jwm4TQXcSY-bcW4qRcygzjq=9qXvvA@mail.gmail.com>
References: <51275DF7.4010600@gmail.com> <512D2780.3020103@gmail.com>
 <CAG17yqQ3d+3Uwpfo+_r0Jwm4TQXcSY-bcW4qRcygzjq=9qXvvA@mail.gmail.com>
Message-ID: <512DEC6C.60607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 11:51 AM, Inderpal Singh wrote:
> On 27 February 2013 02:52, Sylwester Nawrocki
> <sylvester.nawrocki@gmail.com> wrote:
>> On 02/22/2013 01:00 PM, Lonsn wrote:
>>>
>>> Hi,
>>> I have tested the kernel 3.8 with a SMDKV210 like board. But I failed
>>> with dma-pl330 and HDMI driver.
>>> For dma-pl330, kernel print:
>>> dma-pl330 dma-pl330.0: PERIPH_ID 0x0, PCELL_ID 0x0 !
>>> dma-pl330: probe of dma-pl330.0 failed with error -22
>>> dma-pl330 dma-pl330.1: PERIPH_ID 0x0, PCELL_ID 0x0 !
>>> dma-pl330: probe of dma-pl330.1 failed with error -22
>>
>>
>> Maybe there is some issue with the PL330 DMA controller clocks and the
>> read values are all 0 because the clocks are disabled ?
>>
>> It seems arch/arm/mach-s5pv210/clock.c might be missing "apb_pclk" clock
>> supply names, which I suspect may be required after commits:
>>
>> commit 7c71b8eb268ee38235f7e924d943ea9d90e59469
>> Author: Inderpal Singh <inderpal.singh@linaro.org>
>> Date:   Fri Sep 7 12:14:48 2012 +0530
>>
>>     DMA: PL330: Remove redundant runtime_suspend/resume functions
>>
>>     The driver's  runtime_suspend/resume functions just disable/enable
>>     the clock which is already being managed at AMBA bus level
>>     runtime_suspend/resume functions.
>>
>>     Hence, remove the driver's runtime_suspend/resume functions.
>>
>>     Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
>>     Tested-by: Chander Kashyap <chander.kashyap@linaro.org>
>>     Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
>>
>> commit faf6fbc6f2ca3b34bf464a8bb079a998e571957c
>> Author: Inderpal Singh <inderpal.singh@linaro.org>
>> Date:   Fri Sep 7 12:14:47 2012 +0530
>>
>>     DMA: PL330: Remove controller clock enable/disable
>>
>>     The controller clock is being enabled/disabled in AMBA bus
>>     infrastructre in probe/remove functions. Hence, its not required
>>     at driver level probe/remove.
>>
>>     Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
>>     Tested-by: Chander Kashyap <chander.kashyap@linaro.org>
>>     Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
>>
>> I have added people who made related changes at Cc, hopefully they
>> can provide some help in debugging this.
>>
> 
> The mentioned patches just removed the redundant clock enable/disable
> from the driver as clock is already being managed at amba bus level in
> the same code path. As per my understanding the issue should come even
> without these patches.

But were the clocks managed directly by the pl330 driver same as those
managed at amba bus level ? The first patch as above removed chunk

@@ -2887,24 +2884,17 @@ pl330_probe(struct amba_device *adev, const struct
amba_id *id)
                goto probe_err1;
        }

-       pdmac->clk = clk_get(&adev->dev, "dma");
-       if (IS_ERR(pdmac->clk)) {
-               dev_err(&adev->dev, "Cannot get operation clock.\n");
-               ret = -EINVAL;
-               goto probe_err2;
-       }
-

which suggest the driver was enabling directly "dma" clocks, defined at
S5PV210 platform level as:

        {
                .name           = "dma",
                .devname        = "dma-pl330.0",
                .parent         = &clk_hclk_psys.clk,
                .enable         = s5pv210_clk_ip0_ctrl,
                .ctrlbit        = (1 << 3),
        }, {
                .name           = "dma",
                .devname        = "dma-pl330.1",
                .parent         = &clk_hclk_psys.clk,
                .enable         = s5pv210_clk_ip0_ctrl,
                .ctrlbit        = (1 << 4),
        }, {

And amba bus was getting only dummy clocks behind "apb_pclk" clock
conn_id.

> @Lonsn: Can you please test without these patches?

I suspect reverting only patch
DMA: PL330: Remove redundant runtime_suspend/resume functions
with PM_RUNTIME enabled might fix the issue.

--

Regards,
Sylwester
