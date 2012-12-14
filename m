From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Dec 2012 16:33:29 +0000
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
In-Reply-To: <20121214151002.GK14363@n2100.arm.linux.org.uk>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20121214151002.GK14363@n2100.arm.linux.org.uk>
Message-ID: <20121214163329.GS27617@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Dec 2012, Russell King - ARM Linux wrote:

> On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:
> > From: Lee Jones <lee.jones@linaro.org>
> > 
> > There are currently two instances of the ios_handler being used.
> > Both of which mearly toy with some regulator settings. Now there
> > is a GPIO regulator API, we can use that instead, and lessen the
> > per platform burden. By doing this, we also become more Device
> > Tree compatible.
> 
> Err, why is this needed?  What's wrong with using the 'vmmc' for this?

It's a different regulator. The core knows about 'vmmc', which is the
primary one, then there is a regulator called 'vqmmc' which is for I/O
voltage. Until now this was done in a very platform specific way.
Normally by doing gpio_set's. Now there is a regulator API which can
deal with GPIO controlled regulators and there is provision for it in
MMC core also, so it's time to move it to the driver.

> From what I read in the mmc core, vmmc handling via mmc_regulator_set_ocr()
> can cope with GPIO-based regulators, and if you have a single GPIO signal
> then you have a single supply (it's either on or off).  So what's wrong
> with using the existing regulator hooks for this which are already there?

In our case it's not a 'fixed' regulator (i.e. on/off). The new GPIO
regulator API can also control voltage selection using GPIOs too.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
