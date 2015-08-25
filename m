From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Aug 2015 10:30:47 +0100
Subject: [PATCH-v6 5/6] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <55DC2F36.50305@linaro.org>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436358392-15449-6-git-send-email-vaibhav.hiremath@linaro.org>
 <20150824135422.GF3237@x1> <55DB3627.2030503@linaro.org>
 <20150824155129.GA19409@x1> <55DB4A91.9000702@linaro.org>
 <20150825083033.GJ19409@x1> <55DC2F36.50305@linaro.org>
Message-ID: <20150825093047.GO19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:
> On Tuesday 25 August 2015 02:00 PM, Lee Jones wrote:
> >On Mon, 24 Aug 2015, Vaibhav Hiremath wrote:
> >>On Monday 24 August 2015 09:21 PM, Lee Jones wrote:
> >>>On Mon, 24 Aug 2015, Vaibhav Hiremath wrote:
> >>>>On Monday 24 August 2015 07:24 PM, Lee Jones wrote:
> >>>>>On Wed, 08 Jul 2015, Vaibhav Hiremath wrote:
> >>>>>
> >>>>>>As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
> >>>>>>(page 0) controls the method of clearing interrupt
> >>>>>>status of 88pm800 family of devices;
> >>>>>>
> >>>>>>   0: clear on read
> >>>>>>   1: clear on write
> >>>>>>
> >>>>>>If pdata is not coming from board file, then set the
> >>>>>>default irq clear method to "irq clear on write"
> >>>>>>
> >>>>>>Also, as suggested by "Lee Jones" renaming variable field
> >>>>>>to appropriate name and removed unnecessary field
> >>>>>>pm80x_chip.irq_mode, using platform_data.irq_clr_method.
> >>>>>>
> >>>>>>Signed-off-by: Zhao Ye <zhaoy@marvell.com>
> >>>>>>Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> >>>>>>Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>>>>>---
> >>>>>>  drivers/mfd/88pm800.c       | 15 ++++++++++-----
> >>>>>>  include/linux/mfd/88pm80x.h |  9 +++++++--
> >>>>>>  2 files changed, 17 insertions(+), 7 deletions(-)

[...]

> >>If you are OK with it, I will spin another version and submit it.
> >
> >If you can't use the value directly, which if you want to pull the
> >value from DT you can't, then either use the method above, or
> >something like this might be better:
> >
> >int clear_on_write = 0;
> >
> >if (pdata->clear_irq_on_write)
> >    clear_on_write = PM800_WAKEUP2_INT_WRITE_CLEAR;
> >
> >.. this way you only need to add one new define and you can drop
> >PM800_WAKEUP2_INT_READ_CLEAR altogether.  This is better, because it
> >will aid you to move to the BIT() macro easier (there is no BIT()
> >value for shifting 0's).
> >
> 
> Just to clarify, I will adopt this implementation.

Sounds good.  Although, I would suggest just using 'val' as the local
variable.  It makes it more clear that PM800_WAKEUP2_INT_WRITE_CLEAR
is a bit value.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
