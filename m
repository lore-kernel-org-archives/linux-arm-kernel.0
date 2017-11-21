From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 21 Nov 2017 14:49:35 -0500
Subject: [PATCH 1/2] usb: xhci: add relaxed timing quirk bit
In-Reply-To: <20171121191103.5oczqvrlo4gtwjqc@rob-hp-laptop>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
 <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
 <20171121191103.5oczqvrlo4gtwjqc@rob-hp-laptop>
Message-ID: <f200ce55-ac67-02f9-4dbf-7a3ba5b52b39@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2017 2:11 PM, Rob Herring wrote:
> On Tue, Nov 21, 2017 at 12:18:09PM -0500, Adam Wallis wrote:
>> Certain systems may run with CPUs at a very slow frequency. This
>> patch adds a quirk bit that can be used to relax certain timings, etc.
>>
>> This quirk might be needed for other fields in the future, but
>> initially, it will be used only on the IRQ control register to allow
>> firmare to control the value of the register. This can prevent an
> 
> s/firmare/firmware/
> 

Thanks, good catch.

> By firmware control, you mean the register is initialized on boot and 
> then not touched by the kernel? What if the XHCI block is reset? Not 
> sure if that's possible.
> 
>> "interrupt storm" effect on certain systems.
> 
> So now we have 2 ways to deal with this? The existing MediaTek quirk and 
> now this one. 

I do agree that 2 different ways to deal with it is not ideal. I also think that
having one hard-coded value (and one alternate for MTK) is also not ideal.

> 
> I think you should change the existing quirk to a value and set the 
> value based on compatible strings.

I like where you are going with this. Are you saying that I could read for a
device property read from firmware (for DTB or ACPI) like DWC3 does for
"snps,hird-threshold"? If you mean this, where do you recommend I store the
desired IRQ_CONTROL value - in struct xhci_hcd ?

Or by "compatible" strings, did you mean storing hard-coded values in the
of_device_id usb_xhci_of_match[] array? This would still be hard-coding (which I
would like to avoid) and also would not work for the ACPI case.

> 
>> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
>>  drivers/usb/host/xhci.c                            | 25 +++++++++++++++-------
>>  drivers/usb/host/xhci.h                            |  1 +
>>  3 files changed, 19 insertions(+), 8 deletions(-)

Thanks for the feedback Rob.

Adam

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
