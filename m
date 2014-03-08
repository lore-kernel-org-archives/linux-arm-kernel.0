From: lersek@redhat.com (Laszlo Ersek)
Date: Sat, 08 Mar 2014 21:41:31 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <531B01D4.10806@linaro.org>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk> <531843EE.8040102@redhat.com>
 <531B01D4.10806@linaro.org>
Message-ID: <531B807B.4050004@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/14 12:41, Michael Casadevall wrote:
> 
> On 03/06/2014 05:46 PM, Paolo Bonzini wrote:
>> Il 06/03/2014 09:52, Robie Basak ha scritto:
>>> On Sat, Mar 01, 2014 at 03:27:56PM +0000, Grant Likely wrote:
>>>> I would also reference section 3.3 (Boot Option Variables Default Boot
>>>> Behavior) and 3.4.1.1 (Removable Media Boot Behavior) here. It's
>>>> fine to
>>>> restate the meaning of the requirement in this spec, but the UEFI spec
>>>> is the authoritative source. Distributed VM disk images fall under the
>>>> same scenario as the firmware not having any valid boot variables.
>>>
>>> What happens when the VM is first booted without boot variables, but
>>> then the OS expects to be able to set boot variables and see them on
>>> next boot?
>>
>> UEFI scans the devices; looks for an EFI system partition on the
>> disks; and builds a default boot order.
>>
>>> If possible, I would prefer to mandate that the host implementation is
>>> permitted to no-op (or otherwise disable) boot variable write operations
>>> altogether to avoid having to deal with this. In the common case, I
>>> don't see why an OS installation shipped via a VM disk image would need
>>> to write boot variables anyway.
>>>
>>> Would there be any adverse consequences to doing this?
>>
>> Given the experience on x86 UEFI, no.
>>
>> Unlike bare metal, it is common to run UEFI VMs without persistent
>> flash storage.  In this case the boot variables and boot order are
>> rebuilt on the fly on every boot, and it just works for both Windows
>> and Linux; there's no reason why it should be any different for ARM.
>>
> While I realize in the real world, we can live with non-persistent boot
> variables, this is a *direct* violation of the UEFI spec; we can't call
> our VMs UEFI-compatible if we do this.
> 
> However, I've been looking at the spec, and I think we're within spec if
> we save the variables on the HDD itself. There's some support for this
> already (Firmware Block Volume Device), but its possible we could
> implement boot variables as a file on system partition (UEFI's default
> search order can be used to figure out which variable file to use, or
> some sorta fingerprinting system). The biggest trick though is that
> UEFI's Runtime Services will need to be able to write this file, which
> may require us move a large chunk of UEFI to runtime services so the FAT
> filesystem stuff can stick around. If we give it a proper partition,
> then we can just do raw block read/writes. This however would require us
> mandating that said partition exists, and making sure there aren't any
> hidden gotchas in invoking this.

This is how OVMF fakes non-volatile variables when pflash is not enabled
or supported by the host. It stores variables in a file called \NvVars
in the EFI system partition. Before ExitBootServices(), changes are
synced out immediately. After ExitBootServices(), changes are kept only
in memory. If you then do an in-VM reboot, then you end up again
"before" ExitBootServices(), and then the in-memory changes are written
out. This was usually good enough to keep installers happy (because the
last step they do is install grub, run efibootmgr, and reboot).

Keeping around the UEFI FAT driver into runtime would be just one
problem. Another problem is that the OS could itself mount the partition
that holds the file, and then the two drivers (UEFI and Linux) would
corrupt the filesystem. A "raw" partition and a custom FVB driver would
probably be safer in this regard.

> Obviously this isn't ideal, but this might be the middle road solution
> we need here. I can dig through Tiano to get a realistic idea of how
> hard this will be in reality if we want to seriously look at this option.

You could check out Jordan's implementation for qemu pflash --
"OvmfPkg/QemuFlashFvbServicesRuntimeDxe".

The protocol to implement is EFI_FIRMWARE_VOLUME_BLOCK[2]_PROTOCOL,
everything else that should be seated on top "automatically" is already
present in edk2. The protocol is documented in Vol3 of the Platform Init
spec, chapter 3.4.2.

(...BLOCK2... is just a typedef to ...BLOCK..., see
MdePkg/Include/Protocol/FirmwareVolumeBlock.h)

Thanks
Laszlo
