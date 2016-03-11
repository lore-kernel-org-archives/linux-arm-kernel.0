From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Mar 2016 04:05:37 +0000
Subject: [PATCH 1/2] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56E1AB38.8020702@codeaurora.org>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
 <56E14858.9050401@linaro.org> <56E1AB38.8020702@codeaurora.org>
Message-ID: <20160311040537.4067a210@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Mar 2016 12:13:28 -0500
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 3/10/2016 5:11 AM, Eric Auger wrote:
> > Hi Sinan,
> > On 03/08/2016 04:33 PM, Sinan Kaya wrote:
> >> The  code is using the compatible DT string to associate a reset driver with
> >> the actual device itself. The compatible string does not exist on ACPI
> >> based systems. HID is the unique identifier for a device driver instead.
> >> The change allows a driver to register with DT compatible string or ACPI
> >> HID and then match the object with one of these conditions.
> >>
> >> Rules for loading the reset driver are as follow:
> >> - ACPI HID needs match for ACPI systems
> >> - DT compat needs to match for OF systems
> >>
> >> Tested-by: Eric Auger <eric.auger@linaro.org> (device tree only)
> >> Tested-by: Shanker Donthineni <shankerd@codeaurora.org> (ACPI only)
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >> ---
> >>  .../vfio/platform/reset/vfio_platform_amdxgbe.c    |   4 +-
> >>  .../platform/reset/vfio_platform_calxedaxgmac.c    |   4 +-
> >>  drivers/vfio/platform/vfio_platform_common.c       | 112 +++++++++++++++++----
> >>  drivers/vfio/platform/vfio_platform_private.h      |  43 ++++----
> >>  4 files changed, 125 insertions(+), 38 deletions(-)

[...]

> >> -	vfio_platform_get_reset(vdev);
> >> +	ret = vfio_platform_get_reset(vdev);
> >> +	if (ret) {
> >> +		iommu_group_put(group);
> >> +		return ret;
> >> +	}
> > This change is not related to your commit message. Also here you change
> > the use model of VFIO platform and forbid any usage if no reset module
> > is available, right? I don't think this is something we discussed and I
> > think it removes some flexibility. Currently a warning is emitted in
> > case we don't have a reset function.
> 
> Well, I haven't seen that warning during testing. I was trying to be more 
> proactive.
> 
> I'm fine removing these checks but not having a reset driver needs a really
> big warning here.

This code really needs to be moved to a separate patch, but I agree
overall: a reset function should be made mandatory - I cannot imagine
trusting the HW to be left in a sane state after being used by a guest.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
