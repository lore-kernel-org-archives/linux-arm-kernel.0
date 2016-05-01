From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 1 May 2016 00:35:37 -0400
Subject: [PATCH V17 2/3] dmaengine: qcom_hidma: add debugfs hooks
In-Reply-To: <2c7ac0732fb16f952db24b7c70065318@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
 <20160426033029.GB2274@localhost>
 <b068ead6474f2ffee5acef9ea799aba3@codeaurora.org>
 <20160426162529.GK2274@localhost> <571F9D76.2060809@codeaurora.org>
 <20160427081501.GV2274@localhost>
 <2c7ac0732fb16f952db24b7c70065318@codeaurora.org>
Message-ID: <57258799.70803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/27/2016 8:51 AM, okaya at codeaurora.org wrote:
> On 2016-04-27 04:15, Vinod Koul wrote:
>> On Tue, Apr 26, 2016 at 12:55:18PM -0400, Sinan Kaya wrote:
>>> On 4/26/2016 12:25 PM, Vinod Koul wrote:
>>> > On Tue, Apr 26, 2016 at 08:08:16AM -0400, okaya at codeaurora.org wrote:
>>> >> On 2016-04-25 23:30, Vinod Koul wrote:
>>> >>> On Mon, Apr 11, 2016 at 10:21:12AM -0400, Sinan Kaya wrote:
>>> >>>
>>> >>>> +static int hidma_chan_stats(struct seq_file *s, void *unused)
>>> >>>> +{
>>> >>>> +    struct hidma_chan *mchan = s->private;
>>> >>>> +    struct hidma_desc *mdesc;
>>> >>>> +    struct hidma_dev *dmadev = mchan->dmadev;
>>> >>>> +
>>> >>>> +    pm_runtime_get_sync(dmadev->ddev.dev);
>>> >>>
>>> >>> debug shouldn't power up device, why do you want to do that
>>> >>
>>> >>
>>> >> Clocks are turned off while the hw is idle. I can?t reach hw
>>> >> registers without restoring power.
>>> >
>>> > Hmm, have you thought about using regmap?
>>> >
>>>
>>> To be honest, I didn't know what regmap is but I just read some code
>>> and looked at how it is used. Feel free to correct me if I got it
>>> wrong.
>>>
>>> Regmap seems to be designed for *slow* speed peripherals to improve frequent
>>> accesses by the SW. It looks like it is used by MFD, SPI and I2C drivers.
>>>
>>> It seems to cache the register contents and flush/invalidate them only when
>>> needed.
>>>
>>> The MMIO version seems to be assuming the presence of device-tree like CLK
>>> API which doesn't exist on ACPI systems and is not portable.
>>>
>>> My reaction is that it is a lot of code with no added functionality to what
>>> HIDMA driver is trying to achieve.
>>>
>>> Given that the use case here is only for debug purposes; I think it is OK
>>> to keep this runtime call here. I don't want to add any overhead into the
>>> existing code just to support the debug use case.
>>>
>>> None of my register read/writes are slow. This file will only be used to
>>> troubleshoot customer issues.
>>
>> $ is always faster than MMIO. This way you can give reg contents to users
>> without waking up hw.
>>
>> Also we at Intel use regmap on ACPI systems without CLK API
> 
> I can try and see the performance impact is. What happens to registers that hw updates like status registers. Those will be most interesting during debug. How does remap get updated for those? Is there a way to tell it not to cache certain registers

My evaluation turned out negative. The regmap code is nice for bus like peripherals
like I2C and SPI where everything is bitwise accessed. This is not the case
in this code. 

Regmap is a nice tool if used properly but it doesn't mean that it will work
in every single case. It doesn't match with the goal of this driver. 

As soon as I abstract register accesses, the regmap code writes all MMIO registers
with the readl variant functions.

Barriers are really expensive on ARM. I paid very special attention in the 
code to decide when to use relaxed version vs. the readl version. I lose 
all of this optimization. 

Since the clocks are restored only during the debug case, I don't see any
problems here. It is not worth the effort to do redo the whole thing and 
introduce errors as I see a lot of tripping points like regmap_sync variants.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
