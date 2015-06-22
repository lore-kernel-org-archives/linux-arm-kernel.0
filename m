From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 22 Jun 2015 09:58:28 +0200
Subject: [PATCH v4 0/4] VFIO platform reset
In-Reply-To: <CAN9JPjG7jpgPgAKJSR4JsdDVfBFXBJYPfAMBZzSX7SZx621Dow@mail.gmail.com>
References: <1434359385-19916-1-git-send-email-eric.auger@linaro.org>	<1434580294.5628.135.camel@redhat.com>	<CAN9JPjFKVTh7h=cPFecUTP56Muq54vruas3YG1D32hXd0Mh0LQ@mail.gmail.com>	<1434644277.3700.41.camel@redhat.com>
 <CAN9JPjG7jpgPgAKJSR4JsdDVfBFXBJYPfAMBZzSX7SZx621Dow@mail.gmail.com>
Message-ID: <5587C024.5030300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baptiste,
On 06/19/2015 09:53 AM, Baptiste Reynal wrote:
> [1-4/4]
> Acked-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
> Tested-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
> Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
> 
Thanks!

Eric
> On Thu, Jun 18, 2015 at 6:17 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
>> On Thu, 2015-06-18 at 17:23 +0200, Baptiste Reynal wrote:
>>> Hello everyone,
>>>
>>> I tested and reviewed the patches, everything's fine for me.
>>
>> Hi Baptiste,
>>
>> Would you like to provide a Sign-off/Ack/Review tag for the series then?
>>
>>> I agree to be maintainer of vfio platform drivers, though I don't
>>> think the volume of patches about VFIO will justify a new mailing
>>> list.
>>
>> Ok, I'll officially post the patch for MAINTAINERS then.  Until someone
>> complains, we'll continue to use the kvm list.  Thanks,
>>
>> Alex
>>
>>> On Thu, Jun 18, 2015 at 12:31 AM, Alex Williamson
>>> <alex.williamson@redhat.com> wrote:
>>>> On Mon, 2015-06-15 at 11:09 +0200, Eric Auger wrote:
>>>>> In situations where the userspace driver is stopped abnormally and the
>>>>> VFIO platform device is released, the assigned HW device currently is
>>>>> left running. As a consequence the HW device might continue issuing IRQs
>>>>> and performing DMA accesses.
>>>>>
>>>>> On release, no physical IRQ handler is setup anymore. Also the DMA buffers
>>>>> are unmapped leading to IOMMU aborts. So there is no serious consequence.
>>>>>
>>>>> However when assigning that HW device again to another userspace driver,
>>>>> this latter might face some unexpected IRQs and DMA accesses, which are
>>>>> the result of the previous assignment.
>>>>>
>>>>> In virtualization use-case, a VM newly granted with that HW device may be
>>>>> impacted by the assignment of that device to a previous VM:
>>>>> - IRQs may be injected very early when booting the new guest, even before
>>>>>   the guest driver has initialized leading to possible driver state
>>>>>   inconsistency.
>>>>> - DMA accesses may hit the newly mapped VM address space at addresses that
>>>>>   may jeopardize the integrity of the newly installed VM.
>>>>>
>>>>> Obviously the criticity depends on the assigned HW device.
>>>>>
>>>>> As opposed to PCI, there is no standard mechanism to reset the platform
>>>>> device.
>>>>>
>>>>> This series proposes to implement device specific reset functions in
>>>>> separate in-kernel vfio reset modules. The vfio-platform driver holds
>>>>> a whitelist of implemented triplets (compat string, module name,
>>>>> reset function name). When the vfio-platform driver is probed it identifies
>>>>> the fellow reset module/function matching the compat string of the
>>>>> device, if any, and forces the load of this reset module.
>>>>>
>>>>> A first reset module is provided: the vfio-platform-calxedaxgmac
>>>>> module which implements a basic reset for the Calxeda xgmac.
>>>>>
>>>>> The series can be found at
>>>>> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.1-rc8-reset-v4
>>>>>
>>>>> History:
>>>>> v3 -> v4:
>>>>> - fix the commit message of "VFIO: platform: add reset struct and lookup table"
>>>>
>>>> Baptiste,
>>>>
>>>> Any comments?  Should we also add something like this to MAINTAINERS
>>>> before we go much further?
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index d8afd29..c6bf7f6 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -10545,6 +10545,12 @@ F:     drivers/vfio/
>>>>  F:     include/linux/vfio.h
>>>>  F:     include/uapi/linux/vfio.h
>>>>
>>>> +VFIO PLATFORM DRIVER
>>>> +M:     Baptiste Reynal <b.reynal@virtualopensystems.com>
>>>> +L:     kvm at vger.kernel.org
>>>> +S:     Maintained
>>>> +F:     drivers/vfio/platform/
>>>> +
>>>>  VIDEOBUF2 FRAMEWORK
>>>>  M:     Pawel Osciak <pawel@osciak.com>
>>>>  M:     Marek Szyprowski <m.szyprowski@samsung.com>
>>>>
>>>> I'm not sure what you want to be the primary list, maybe it's time to
>>>> ask for a vfio list.  Thanks,
>>>> Alex
>>>>
>>>>>
>>>>> v2 -> v3:
>>>>> - remove void module_init/exit functions in calxeda reset module
>>>>> - remove enum vfio_platform_reset_type
>>>>> - for reset lookup, use ARRAY_SIZE
>>>>> - in reset put use symbol_put_addr
>>>>>
>>>>> v1 -> v2:
>>>>> - much simplified compared to v1 although principle of external modules is
>>>>>   kept: removed mechanism of dynamic registration of reset functions
>>>>> - list is replaced by whitelist lookup table
>>>>> - name of the reset function also stored in the lookup table
>>>>> - autoload of reset modules
>>>>>
>>>>> RFC -> PATCH v1:
>>>>> - solution now based on a lookup list instead of specialized driver
>>>>>
>>>>>
>>>>> Eric Auger (4):
>>>>>   VFIO: platform: add reset struct and lookup table
>>>>>   VFIO: platform: add reset callback
>>>>>   VFIO: platform: populate the reset function on probe
>>>>>   VFIO: platform: Calxeda xgmac reset module
>>>>>
>>>>>  drivers/vfio/platform/Kconfig                      |  2 +
>>>>>  drivers/vfio/platform/Makefile                     |  2 +
>>>>>  drivers/vfio/platform/reset/Kconfig                |  7 ++
>>>>>  drivers/vfio/platform/reset/Makefile               |  5 ++
>>>>>  .../platform/reset/vfio_platform_calxedaxgmac.c    | 86 ++++++++++++++++++++++
>>>>>  drivers/vfio/platform/vfio_platform_common.c       | 60 ++++++++++++++-
>>>>>  drivers/vfio/platform/vfio_platform_private.h      |  7 ++
>>>>>  7 files changed, 166 insertions(+), 3 deletions(-)
>>>>>  create mode 100644 drivers/vfio/platform/reset/Kconfig
>>>>>  create mode 100644 drivers/vfio/platform/reset/Makefile
>>>>>  create mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
>>>>>
>>>>
>>>>
>>>>
>>
>>
>>
