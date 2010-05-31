From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 31 May 2010 01:39:54 +0100
Subject: [PATCH 4/4] usb: s3c-hsotg: Enable HCLK for the OTG module.
In-Reply-To: <4BFF9F79.106@ru.mvista.com>
References: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
	<1275014477-23133-5-git-send-email-kgene.kim@samsung.com>
	<20100528102232.GZ4720@trinity.fluff.org>
	<4BFF9F79.106@ru.mvista.com>
Message-ID: <20100531003954.GN7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 02:48:25PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Ben Dooks wrote:
>
>>> From: Thomas Abraham <thomas.ab@samsung.com>
>
>>> This patch modifies the following in S3C hsotg driver.
>
>>> 1. Gets a reference to the USB OTG hclk clock and enables it. This is
>>>    required for plaforms on which the USB OTG hclk is disabled during
>>>    the boot time clock intialization.
>
>>> 2. Add necessary clock clean up in case of error during initialization
>>>    failure or during module unload.
>
>>> 3. Add a new field 'clk_otg' in 'struct s3c_hsotg' to maintain a
>>>    reference to the USB OTG hclk clock.
>
>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>> ---
>>>  drivers/usb/gadget/s3c-hsotg.c |   17 +++++++++++++++++
>>>  1 files changed, 17 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
>>> index 81c47d2..526d081 100644
>>> --- a/drivers/usb/gadget/s3c-hsotg.c
>>> +++ b/drivers/usb/gadget/s3c-hsotg.c
>
> [...]
>
>>> @@ -3269,6 +3271,14 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
>>>  		goto err_regs_res;
>>>  	}
>>>  +	hsotg->clk_otg = clk_get(&pdev->dev, "otg");
>>> +	if (IS_ERR(hsotg->clk_otg)) {
>>> +		dev_err(dev, "failed to find usb otg clock source\n");
>>> +		ret = -ENODEV;
>
>> hmm, -ENODEV isn't really the right error to return here, it'll
>> get silently ignored by the device core.
>
>    Right, PTR_ERR(hsotg->clk_otg) should be returned in this case.
>
> WBR, Sergei

yes, missed that thanks.
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
