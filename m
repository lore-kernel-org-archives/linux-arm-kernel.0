From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Mar 2017 16:30:40 -0700
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
 <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
Message-ID: <20170314233040.GH10239@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14, Timur Tabi wrote:
> On 03/14/2017 04:41 PM, Linus Walleij wrote:
> > On Mon, Mar 6, 2017 at 10:52 PM, Timur Tabi <timur@codeaurora.org> wrote:
> 
> >> So would it be acceptable, for example, to change msm_gpio_set() such that
> >> if the function of that pin is non-zero, just return an error?
> > 
> > I would ask the driver maintainer about his opinion, and also whoever
> > is an authority on ACPI for the TLMM-chips, I am no expert
> > in ACPI. Hell I'm not even good at device tree. Not to mention SFI.
> > Oh well...
> 
> Well, I was hoping that Stephen would respond to this question. :-)
> 
> My point is, if the driver knows that the GPIO cannot be written to (because
> it's muxed to something else), shouldn't the driver return with an error if the
> caller attempts to write?
> 

(I reply faster when my name is written!)

I don't see any problem with failing msm_gpio_set() when the
function is "not gpio", but I also wonder why it matters. Drivers
shouldn't be doing that, because if the gpio is muxed to some
other functionality they shouldn't be treating it as a gpio in
the first place.

Perhaps we can have some sort of gpio validation debug option
that the check goes under. Then we could fail and print a big
warning if this happens, but if we aren't debugging then we don't
do any checking and rely on drivers to do the right thing.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
