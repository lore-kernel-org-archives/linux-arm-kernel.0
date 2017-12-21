From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 20 Dec 2017 19:06:56 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <20171221003947.GJ7997@codeaurora.org>
References: <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
 <20171220022626.GH7997@codeaurora.org>
 <d511f096-bad4-c7b3-d7d4-11b1fa3b1cce@codeaurora.org>
 <20171220081556.GA30524@codeaurora.org>
 <a5809701-3f81-3f79-f558-a831ce4091c2@codeaurora.org>
 <20171221003947.GJ7997@codeaurora.org>
Message-ID: <38463c81-eeab-85dc-d197-6081ce1d1130@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/17 6:39 PM, Stephen Boyd wrote:
> I don't see how it hurts to treat it generically. Presumably
> that's the way it will be done on ACPI platforms going forward?
> No need to tie it to some ACPI HID.

But it is tied to a HID.  The "num-gpios" and "gpios" properties belong 
to a specific HID.  Someone could create a new HID with different 
properties, and then what?  That's why I want all the ACPI stuff in the 
client driver.

At this point I don't really care any more about what the patches look 
like, but I really do think that putting the ACPI code in pinctrl-msm is 
a bad idea.

We're debating adding support for multiple TLMMs, and we may create a 
new HID for that, so that we can define all pins on all TLMMs in one 
device.  We would need to create a new HID and new DSDs to go with it.

> I'm trying to resolve everything at once: gpios, pinctrl pins,
> and irqs exposed by the TLMM hardware. The value is that we solve
> it all, once, now.

Keep in mind that I am now in vacation, and so I won't be able to submit 
any more patches for a while.

> The DT binding can also be resolved at the
> same time, so when we need to express this in DT it's already
> done.

Ok.

> Otherwise, something can request irqs from the irqdomain
> even if the irq can't be enabled, or it can try to mux the pin to
> some other function, even if the function selection can't be
> configured.

Is it possible to request an IRQ for a pin if the pin itself can't be 
requested?

> Boiling everything down into the irq valid mask should cover all
> these cases, and not require us to strip const from all the data
> in the non-ACPI pinctrl drivers to replace the value in the npins
> field at runtime.

Ok.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
