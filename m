From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 06 Mar 2014 10:46:22 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140306085213.GU643@mal.justgohome.co.uk>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk>
Message-ID: <531843EE.8040102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 06/03/2014 09:52, Robie Basak ha scritto:
> On Sat, Mar 01, 2014 at 03:27:56PM +0000, Grant Likely wrote:
>> I would also reference section 3.3 (Boot Option Variables Default Boot
>> Behavior) and 3.4.1.1 (Removable Media Boot Behavior) here. It's fine to
>> restate the meaning of the requirement in this spec, but the UEFI spec
>> is the authoritative source. Distributed VM disk images fall under the
>> same scenario as the firmware not having any valid boot variables.
>
> What happens when the VM is first booted without boot variables, but
> then the OS expects to be able to set boot variables and see them on
> next boot?

UEFI scans the devices; looks for an EFI system partition on the disks; 
and builds a default boot order.

> If possible, I would prefer to mandate that the host implementation is
> permitted to no-op (or otherwise disable) boot variable write operations
> altogether to avoid having to deal with this. In the common case, I
> don't see why an OS installation shipped via a VM disk image would need
> to write boot variables anyway.
>
> Would there be any adverse consequences to doing this?

Given the experience on x86 UEFI, no.

Unlike bare metal, it is common to run UEFI VMs without persistent flash 
storage.  In this case the boot variables and boot order are rebuilt on 
the fly on every boot, and it just works for both Windows and Linux; 
there's no reason why it should be any different for ARM.

> My reason is that this would save us from blocking a general OpenStack
> implementation on ARM by requiring that these pieces are implemented
> further up the stack first, when it would bring actual gain to doing so.
>
> This would not preclude host implementations from implementing writeable
> variables, or guests from using them. Just that for a _portable VM disk
> image_, the OS on it cannot assume that this functionality is present.

This is already the case for most OSes.  Otherwise you wouldn't be able 
to move a hard disk from a (physical) machine to another.

I strongly suggest that you take a look at the work done in Tiano Core's 
OvmfPkg, which has support for almost every QEMU feature thanks to the 
work of Laszlo Ersek and Jordan Justen.

In particular, OvmfPkg has support for specifying a boot order in the VM 
configuration (which maps to the "-boot" option in QEMU).  In this case, 
the UEFI boot order is overridden by a variable that is placed in some 
architecture-specific firmware configuration mechanism (on x86 we have 
one called fw_cfg, on ARM you could look at the fdt).  This predates 
UEFI and is not a UEFI variable; in fact is is a list of OpenFirmware 
device paths.  UEFI will match the OF paths to UEFI paths, and use the 
result to build a UEFI boot order.

Paolo
