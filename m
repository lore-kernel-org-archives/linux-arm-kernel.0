From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Sep 2012 14:28:30 +0200
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <CAJuYYwQCQDTnpPR5WABtbozZOgc6_SZRBv3b6D8KY78tzMt-Eg@mail.gmail.com>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <2444562.GB3nOHUb9M@amdc1227>
 <CAJuYYwQCQDTnpPR5WABtbozZOgc6_SZRBv3b6D8KY78tzMt-Eg@mail.gmail.com>
Message-ID: <1390693.DWkgTZ1iNF@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for your comments.

On Thursday 06 of September 2012 16:36:08 Thomas Abraham wrote:
> > This patch shows the problem of the need to explicitly migrate all
> > drivers to pinctrl.
> > 
> > Maybe we should consider extending the pinctrl subsystem to set the
> > default state automatically before binding a driver to a device, at
> > least in case of DT-based platforms?
> 
> The pinctrl driver allows for activating default pin configuration
> when the pinctrl driver loads. This is referred to as "hogging".

What I suggested is that such default configuration would be applied just 
before binding a driver, i.e. when it's almost sure that the device will be 
actually used and the configuration will be needed.

Of course such functionality would not have to be obligatory. For example, 
we could add new property, like pinctrl-set-default, to point in device 
tree that this device should have its pinctrl state set up automatically.

> But
> should hog be used or not is something that needs to be decided. Some
> of the factors which favor the driver explicitly setting up the pin
> configuration are
> 
> 1. After a suspend and resume cycle, the pin configuration registers
> may be reset to default values. Hence, during resume, the pin
> configuration has be redone.

In my opinion it should be saved and restored by pinctrl driver (as it was 
done in case of GPIO subsystem previously). This is because the driver can 
usually quickly restore all pins at once and some hardware even provide 
facilities for restoring pin configuration after suspend. (e.g. s3c6410, 
probably not going to use pinctrl, but possibly there are more systems 
using this kind of solution, which allows to switch all pins at once from 
sleep mode settings to normal mode).

> 2. Runtime muxing/config is possible.

Of course, for cases where runtime remuxing is required this would be no 
option, but often there is just a single pin configuration used all the 
time.

> 3. Setting some of the config options such as pull-up by default might
> start consuming power from boot time itself, which could be avoided if
> such setup is done only when needed.

Making it optional would solve this issue, because in such cases the driver 
already has to be aware of setting pull-ups and similar.

> Adding pinctrl driver support in device drivers seems to be simple
> task. And it is just one time effort which can be reused on multiple
> SoC's.

I agree. Although not modifying the drivers at all would be nicer.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
