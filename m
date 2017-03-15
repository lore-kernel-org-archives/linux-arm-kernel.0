From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 14 Mar 2017 22:08:50 -0700
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <f1152d48-004e-71bc-16a1-3a25990ba9e4@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
 <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
 <20170314233040.GH10239@codeaurora.org>
 <c40b0ee7-6d8c-8c5d-d4c5-9ecf8076e44f@codeaurora.org>
 <20170314234140.GI10239@codeaurora.org>
 <f1152d48-004e-71bc-16a1-3a25990ba9e4@codeaurora.org>
Message-ID: <20170315050850.GC1694@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 14 Mar 17:12 PDT 2017, Timur Tabi wrote:

> Stephen Boyd wrote:
> 
> > > > The idea is to notify drivers with an error code when they make a
> > > > mistake. Perhaps the device tree or the ACPI table has an error?
> 
> > In general the kernel isn't a firmware validator. At least that's
> > the way I view it. Others may have different opinions here.
> 
> I would be okay with wrapping that check around #ifdef CONFIG_DEBUG_GPIO.
> 

This will, more or less, only be useful for system integrators - whom
likely won't enable DEBUG_GPIO. But I'm generally fine with failing
gpio_set if we're not in function 0.

My question is if we should wrap that check in a WARN(), just to make it
easy for said system integrator to spot the issue - or if that will just
leave another chunk of printouts that people will ignore in their
products.

> > > > I could add that, but I still think returning an error code is
> > > > appropriate.  On the TLMM, we know for sure that the pin must be set
> > > > to function 0 in order for the read/write routines to operate
> > > > correctly.
> 
> > On ACPI we could make the gpio_get() path fail if the pin isn't
> > in GPIO mode?
> 
> Did you mean the gpio_chip.request callback?  Currently that points to
> gpiochip_generic_request in pinctrl-msm.c.
> 

It might be useful to fail gpio_get, as that gives a much nicer error
path in the client. But I'm slightly concerned about the few cases where
one of the pinmux states is gpio and that this would force the
gpio_get() only to be called after switching to that particular mode.


@Linus, have there been any discussion around this in other drivers?

Regards,
Bjorn
