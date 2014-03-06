From: lersek@redhat.com (Laszlo Ersek)
Date: Thu, 06 Mar 2014 12:44:57 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <531843EE.8040102@redhat.com>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk> <531843EE.8040102@redhat.com>
Message-ID: <53185FB9.1040308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/14 10:46, Paolo Bonzini wrote:
> Il 06/03/2014 09:52, Robie Basak ha scritto:
>> On Sat, Mar 01, 2014 at 03:27:56PM +0000, Grant Likely wrote:
>>> I would also reference section 3.3 (Boot Option Variables Default Boot
>>> Behavior) and 3.4.1.1 (Removable Media Boot Behavior) here. It's fine to
>>> restate the meaning of the requirement in this spec, but the UEFI spec
>>> is the authoritative source. Distributed VM disk images fall under the
>>> same scenario as the firmware not having any valid boot variables.

"+1"

>>
>> What happens when the VM is first booted without boot variables, but
>> then the OS expects to be able to set boot variables and see them on
>> next boot?
> 
> UEFI scans the devices; looks for an EFI system partition on the disks;
> and builds a default boot order.
> 
>> If possible, I would prefer to mandate that the host implementation is
>> permitted to no-op (or otherwise disable) boot variable write operations
>> altogether to avoid having to deal with this. In the common case, I
>> don't see why an OS installation shipped via a VM disk image would need
>> to write boot variables anyway.
>>
>> Would there be any adverse consequences to doing this?
> 
> Given the experience on x86 UEFI, no.
> 
> Unlike bare metal, it is common to run UEFI VMs without persistent flash
> storage.  In this case the boot variables and boot order are rebuilt on
> the fly on every boot, and it just works for both Windows and Linux;
> there's no reason why it should be any different for ARM.
> 
>> My reason is that this would save us from blocking a general OpenStack
>> implementation on ARM by requiring that these pieces are implemented
>> further up the stack first, when it would bring actual gain to doing so.
>>
>> This would not preclude host implementations from implementing writeable
>> variables, or guests from using them. Just that for a _portable VM disk
>> image_, the OS on it cannot assume that this functionality is present.
> 
> This is already the case for most OSes.  Otherwise you wouldn't be able
> to move a hard disk from a (physical) machine to another.
> 
> I strongly suggest that you take a look at the work done in Tiano Core's
> OvmfPkg, which has support for almost every QEMU feature thanks to the
> work of Laszlo Ersek and Jordan Justen.
> 
> In particular, OvmfPkg has support for specifying a boot order in the VM
> configuration (which maps to the "-boot" option in QEMU).  In this case,
> the UEFI boot order is overridden by a variable that is placed in some
> architecture-specific firmware configuration mechanism (on x86 we have
> one called fw_cfg, on ARM you could look at the fdt).  This predates
> UEFI and is not a UEFI variable; in fact is is a list of OpenFirmware
> device paths.  UEFI will match the OF paths to UEFI paths, and use the
> result to build a UEFI boot order.

If I understand correctly, the question is this:

  Given a hypervisor that doesn't support non-volatile UEFI variables
  (including BootOrder and Boot####), is it possible to automatically
  boot a carefully prepared VM image, made available as a fixed media
  device?

The answer is "yes". See

  3.3 Boot Option Variables Default Boot Behavior

in the UEFI spec (already referenced by Grant Likely in the context above).

  3.3 Boot Option Variables Default Boot Behavior

  The default state of globally-defined variables is firmware vendor
  specific. However the boot options require a standard default behavior
  in the exceptional case that valid boot options are not present on a
  platform. The default behavior must be invoked any time the BootOrder
  variable does not exist or only points to nonexistent boot options.

  If no valid boot options exist, the boot manager will enumerate all
  removable media devices followed by all fixed media devices. The order
  within each group is undefined. These new default boot options are not
  saved to non volatile storage. The boot manger will then attempt to
  boot from each boot option. If the device supports the
  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL then the removable media boot behavior
  (see Section 3.4.1.1) is executed. Otherwise, the firmware will
  attempt to boot the device via the EFI_LOAD_FILE_PROTOCOL.

  It is expected that this default boot will load an operating system or
  a maintenance utility. If this is an operating system setup program it
  is then responsible for setting the requisite environment variables
  for subsequent boots. The platform firmware may also decide to recover
  or set to a known set of boot options.

Basically, the "removable media boot behavior" applies to fixed media
devices as last resort. You can prepare a disk image where this behavior
will "simply" boot the OS.

See also Peter Jones' blog post about this:

http://blog.uncooperative.org/blog/2014/02/06/the-efi-system-partition/

(In short, my email is a "+1" to what Grant said.)

Thanks
Laszlo
