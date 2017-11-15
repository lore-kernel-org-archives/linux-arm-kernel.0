From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Nov 2017 09:06:15 -0600
Subject: [PATCH 0/4] [v7] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <CACRpkdYT1NDzuEuDU47jC-iXTE8JWxqGnKhJYKp0oGiL1wX7ig@mail.gmail.com>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <c219c289-9cad-f96c-f766-ec28af8f078d@codeaurora.org>
 <CACRpkdbwe9+TovFYoD-W_9kabe+jsVbN6juJQBUzicq=1XDphg@mail.gmail.com>
 <b8bbba8d-f91f-8e8f-8e79-2e772b48d9b9@codeaurora.org>
 <CACRpkdYT1NDzuEuDU47jC-iXTE8JWxqGnKhJYKp0oGiL1wX7ig@mail.gmail.com>
Message-ID: <8a0fe5e6-b27c-1e23-b9ec-5fc18a0ae27b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2017 04:03 AM, Linus Walleij wrote:
> The more intrusive design is on my request so I will look at it in detail
> ASAP. I took a quick look and liked what I saw, I just need to make
> sure about the details. Also it'd be nice to have a nod from Bj?rn.
> 
> The main reason for some of the work is ACPI, am I right?

Yes.  We don't have a nice hierarchical tree that lists the individual 
pins and their purposes.  We just have a dumb list of GPIOs.

> Timur could you look quickly at the series posted by Andy Shevchenko
> (6 patches prefixed gpiolib: acpi: ) for augmenting ACPI GPIOs in the core?
> Especially patch 5 and 6 which introduce the ability to add quirks in the
> core.

So this is something that I've never really understood with 
gpiolib-acpi.  I don't think this file is used with the pin control driver.

We do have GpioInt and GpioIo statements in our GPIO table, but they 
don't appear to be using the TLMM (our GPIO / pin control device)

For example:

GpioInt(Level, ActiveHigh, Exclusive, PullNone, , "\\_SB.TCS0.QIC5") {10}

The \\_SB.TCS0 device is NOT the TLMM.  It's our "irq combiner" which 
has something to do with performance measurement.  I think the

I don't think Andy's patch set has anything to do with my patches.  My 
patches just try to register a GPIO device, whereas the gpiolib-acpi 
patches are about ACPI nodes performing gpio-like operations.


> I'd like to get some ARM-based people to look at it to make sure we
> those systems can also quirk their GPIOs if need be.

My patches aren't about a quirk.  All I'm trying to do is registers 
specific GPIOs rather than one giant block of them.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
