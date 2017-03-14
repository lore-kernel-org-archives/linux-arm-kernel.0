From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 14 Mar 2017 16:55:13 -0500
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
Message-ID: <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2017 04:41 PM, Linus Walleij wrote:
> On Mon, Mar 6, 2017 at 10:52 PM, Timur Tabi <timur@codeaurora.org> wrote:
> 
>> On ACPI platforms, the kernel has no control over the muxing (aka function)
>> of the various pins.  Firmware configures the TLMM controller for all pins,
>> and configures them for whatever functions they're supposed to be.
> 
> I think it would be better if pin control and ACPI play along, and I bet that
> will happen in the future. This is I guess a question for ACPI standardization
> work.

Maybe.  During the development of the ACPI standard, everyone made a big stink
about how muxing should be handled by the firmware and never touched by the OS.
It would be a significant reversal if they decide to add mux configuration to ACPI.

>> Therefore, on ACPI, the driver should never change the function of any pin.
>> If it's set to something other than 0, then it should never touch that pin.
>> Don't write to it, don't change the direction, and definitely don't change
>> the function.
> 
> Does that mean that pins with 0 are free to play around with?

Yes.

>> So would it be acceptable, for example, to change msm_gpio_set() such that
>> if the function of that pin is non-zero, just return an error?
> 
> I would ask the driver maintainer about his opinion, and also whoever
> is an authority on ACPI for the TLMM-chips, I am no expert
> in ACPI. Hell I'm not even good at device tree. Not to mention SFI.
> Oh well...

Well, I was hoping that Stephen would respond to this question. :-)

My point is, if the driver knows that the GPIO cannot be written to (because
it's muxed to something else), shouldn't the driver return with an error if the
caller attempts to write?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
