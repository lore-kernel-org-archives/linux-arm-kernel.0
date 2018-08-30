From: olof@lixom.net (Olof Johansson)
Date: Thu, 30 Aug 2018 08:06:36 -0700
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
In-Reply-To: <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
 <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
Message-ID: <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>> Hi Olof,
>>
>>
>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>>
>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>>> parameter to function with efi loader.
>>>>
>>>> Required to boot on existing bootloaders that do not support devicetree
>>>> provided by the platform or by the bootloader.
>>>>
>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>>> DTB loader")
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>
>>> Why did Ard create an option for this if it's just going be turned on
>>> in default configs? Doesn't make sense to me.
>>>
>>> It would help to know what firmware still is crippled and how common
>>> it is, since it's been a few years that this has been a requirement by
>>> now.
>>
>> Broadcom NS2 and Stingray in current development and production need this
>> option in the kernel enabled in order to boot.
>
> And these production systems run mainline kernels in a defconfig configuration?
>
> The simply reality is that the DTB loader has been deprecated for a
> good reason: it was only ever intended as a development hack anyway,
> and if we need to treat the EFI stub provided DTB as a first class
> citizen, there are things we need to fix to make things works as
> expected. For instance, GRUB will put a property in the /chosen node
> for the initramfs which will get dropped if you boot with dtb=.
>
> Don't be surprised if some future enhancements of the EFI stub code
> depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
> tables] are used by the firmware to describe itself and the underlying
> platform to the OS, and the practice of booting with DTB file images
> (taken from the kernel build as well) conflicts with that view. Note
> that GRUB still permits you to load DTBs from files (and supports more
> sources than just the file system the kernel Image was loaded from).

Ard,

Maybe a WARN() splat would be more useful as a phasing-out method than
removing functionality for them that needs to be reinstated through
changing the config?

Once the stub and the boot method is there, it's hard to undo as we
can see here. Being loud and warn might be more useful, and set a
timeline for hard removal (12 months?).

Scott; an alternative for you is to do a boot wrapper that bundles a
DT and kernel, and boot that instead of the kernel image (outside of
the kernel tree). Some 32-bit platforms from Marvell use that. That
way the kernel will just see it as a normally passed in DT.


-Olof
