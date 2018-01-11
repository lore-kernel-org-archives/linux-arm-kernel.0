From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 11 Jan 2018 19:00:43 +0530
Subject: [PATCH] phy: work around 'phys' references to usb-phy devices
In-Reply-To: <CAK8P3a0F4sK=ou8HXmSktq+0S22juYaCaY48RStDKwk8QGgviQ@mail.gmail.com>
References: <20180108130116.80148-1-arnd@arndb.de>
 <aa02104b-d80d-8b12-4403-b5cedc23f03a@ti.com>
 <CAK8P3a0F4sK=ou8HXmSktq+0S22juYaCaY48RStDKwk8QGgviQ@mail.gmail.com>
Message-ID: <6dd37865-9c71-29f9-16b4-26e51e6b1c70@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thursday 11 January 2018 02:27 AM, Arnd Bergmann wrote:
> On Mon, Jan 8, 2018 at 7:32 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi Arnd,
>>
>> On Monday 08 January 2018 06:31 PM, Arnd Bergmann wrote:
>>> Stefan Wahren reports a problem with a warning fix that was merged
>>> for v4.15: we had lots of device nodes with a 'phys' property pointing
>>> to a device node that is not compliant with the binding documented in
>>> Documentation/devicetree/bindings/phy/phy-bindings.txt
>>>
>>> This generally works because USB HCD drivers that support both the generic
>>> phy subsystem and the older usb-phy subsystem ignore most errors from
>>> phy_get() and related calls and then use the usb-phy driver instead.
>>>
>>> However, usb_add_hcd() (along with the respective functions in dwc2 and
>>> dwc3) propagate the EPROBE_DEFER return code so we can try again whenever
>>> the driver gets loaded. In case the driver is written for the usb-phy
>>> subsystem (like usb-generic-phy aka usb-nop-xceiv), we will never load
>>> a generic-phy driver for it, and keep failing here.
>>>
>>> There is only a small number of remaining usb-phy drivers that support
>>> device tree, so this adds a workaround by providing a full list of the
>>> potentially affected drivers, and always failing the probe with -ENODEV
>>> here, which is the same behavior that we used to get with incorrect
>>> device tree files. Since we generally want older kernels to also want
>>> to work with the fixed devicetree files, it would be good to backport
>>> the patch into stable kernels as well (3.13+ are possibly affected).
>>> Reverting back to the DTS sources that work would in theory fix USB
>>> support for now, but in the long run we'd run into the same problem
>>> again when the drivers get ported from usb-phy to generic-phy.
>>>
>>> Fixes: 014d6da6cb25 ("ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells")
>>> Link: https://marc.info/?l=linux-usb&m=151518314314753&w=2
>>> Cc: stable at vger.kernel.org
>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>> Cc: Felipe Balbi <balbi@kernel.org>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>> This obviously needs to be tested, I wrote this up as a reply to
>>> Stefan's bug report. I'm fairly sure that I covered all usb-phy
>>> driver strings here. My goal is to have a fix merged into 4.15
>>> rather than reverting all the DT fixes.
>>
>> Shouldn't the fix be in phy consumer drivers to not return error if it's able
>> to find the phy either using usb-phy or generic phy?
> 
> Stefan has posted a patch to that effect now, but I fear that might be
> a little fragile, in particular this short before the release with the
> regression
> in place.
> 
> The main problem is that we'd have to change the generic
> usb_add_hcd() function in addition to dwc2 and dwc3 to ignore
> -EPROBE_DEFER from phy_get() whenever usb_get_phy_dev()
> has already succeeded.
> 
> If there is any HCD that relies on usb_add_hcd() to get both the
> usb_phy and the phy structures, and it may need to defer probing
> when the latter one isn't ready yet, that fix would break another
> driver.

hmm.. IMO the better thing right now would be to revert the dt patch which adds
#phy-cells.
We have to see if there are better fixes in order to add #phy-cells warning fix
in stable tree.

Thanks
Kishon
