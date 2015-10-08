From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 21:16:51 +0200
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
In-Reply-To: <56169E38.1050803@ti.com>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
 <5870815.PiO7rCVXjJ@wuerfel> <56169E38.1050803@ti.com>
Message-ID: <5673608.IRgyBTXroY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 12:47:52 Murali Karicheri wrote:
> Arnd,
> 
> On 10/08/2015 11:41 AM, Arnd Bergmann wrote:
> > On Tuesday 06 October 2015 10:19:18 Santosh Shilimkar wrote:
> >> Couple of patches for ARM Keystone SOC drivers
> >>          - irq affinity bug fix
> >>          - display the firmware name
> >>
> >> ----------------------------------------------------------------
> >> Murali Karicheri (2):
> >>        soc: ti: reset irq affinity before freeing irq
> >>        soc: ti: display firmware file name as part of boot log
> >>
> >>   .../bindings/soc/ti/keystone-navigator-qmss.txt      | 20 +++++++++++++++++++-
> >>   drivers/soc/ti/knav_qmss_acc.c                       |  4 ++++
> >>   drivers/soc/ti/knav_qmss_queue.c                     |  3 +++
> >>   3 files changed, 26 insertions(+), 1 deletion(-)
> >
> > The new text you add to the binding document doesn't really seem to
> > belong in there, so I'm not pulling this until we've discussed how
> > this should be better handled.
> >
> > Ideally, the firmware should just get merged into the linux-firmware.git
> > tree.
> 
> I have got the firmware merged to the linux-firmware.git. I will post a 
> patch to change the document to reflect that. Will it suffice?

The binding document isn't really the right place for that. It's certainly
good to document this, but somewhere else would be more appropriate.

How about the Kconfig text for this driver?

> > Regarding the method of storing the firmware file name in DT, we
> > recently had a longer discussion about that and basically concluded
> > that this doesn't work for most devices, in particular when the
> > communication between the driver and the firmware uses an interface
> > that is not 100% stable and can change depending on the firmware
> > blob.
> >
> > Can you guarantee that there will never be changes to the interface?
> This firmware is in use for almost 3 years for now on K2 SoCs, but in a 
> different kernel version. The interface itself is used not only by Linux 
> OS, but other OS as well. So it is not expected to change in the future 
> as backward compatibility will be an issue for other OS as well.

Ok.

> > If not, we should try to come up with a better mechanism here, and
> > only provide the current method for backwards compatibility.
> Assuming we need to change interface in the future, How is this handled 
> in other devices? Do they have something like a version to check 
> compatibility between software and firmware? As this firmware has been 
> frozen for almost 3 years, I wouldn't expect any change to it. Could you 
> point me to the thread where this was discussed in the past. Also in my 
> experience, mostly changes are to the firmware itself, but not to the 
> interface. In such cases, do we keep the name of firmware in DT without 
> version information so that in the file system, user could  create a 
> soft link to the firmware matching with the DT name. So this way as long 
> as interface doesn't change, firmware upgrade is possible. If you agree, 
> I can send an incremental patch to rename the firmware to exclude the 
> version information.

Normally, the firmware name is fixed in the driver. If the API changes
in order to support a new feature, the driver of course needs to be
aware of that, but it should not require a device tree change to
update the file name.

Conversely, if you get a new chip that needs a slightly different
blob but has an identical API, the driver should ideally not need to
be changed, but still see  a new file name.

The first can be done once you need it, e.g. by appending the number
of the API version to the file name inside of the driver, and trying
the highest version supported by the driver first, before falling
back to older version in reverse order until the oldest version
that is supported by the driver.

The second one basically depends on the "compatible" string of the
device, which identifies which device you have. The driver can
then look up the file name for each device it supports based on this
string, and by using multiple compatible strings in DT, you can
provide the specific version of the hardware that is used for
the file name without having to match that hardware name in the
driver

> W.r.t to the patch for documentation update, can I send an incremental 
> patch to the update the linux-firmware.git reference as well?

I'd rather skip that documentation change until we have decided on how
to handle the firmware loading in the future.

	Arnd
