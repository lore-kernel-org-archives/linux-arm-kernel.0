From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 16 Dec 2015 16:59:39 -0600
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <3023844.AYbAYqvHUZ@wuerfel>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <3023844.AYbAYqvHUZ@wuerfel>
Message-ID: <CAL_Jsq+KAF6FGyOyC0JzODsSVoK4+V6umpj=cANywgui_wOKMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 3:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 14 December 2015 15:26:11 Peter Chen wrote:
>> Hi all,
>>
>> There is a known issue that the USB code can't handle USB HUB's
>> external pins well, in that case, it may cause some onboard
>> USB HUBs can't work since their PHY's clock or reset pin needs to
>> operate.
>>
>> The user reported this issue at below:
>> http://www.spinics.net/lists/linux-usb/msg131502.html
>>
>> In this patch set, I add a generic onboard USB HUB driver to
>> handle this problem, the external signals will be configured
>> before usb controller's initialization, it much likes we did
>> it at board code before.
>>
>> The user needs to add this generic hub node at dts to support it.
>>
>> @The udoo users, help to test please.
>
> I still think need to do this properly by representing the hub
> device as a USB device, using power sequencing code like MMC does.

I agree on doing it properly, but am not sure that pwrseq binding for
MMC is proper. The pwrseq binding is fairly limited and working around
the driver model IMO. Hubs may also need I2C setup which I don't think
could be done generically other than some defined sequence of i2c
transactions. The current project I'm working on needs to use I2C to
configure the hub to use HSIC mode for example. I really think we need
a pre-probe driver hook to handle this. That would allow device
specific setup to live in the driver.

Perhaps a more simple approach would be just forcing driver probe if a
DT node is present. I'm not all that familiar with USB drivers, but
presumably there is some setup before probe like setting the USB
device address. We'd have to allow doing that later during probe.

Rob
