From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 20:56:25 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <5AA88E43-1A40-4409-9A56-334988483843@suse.de>
References: <20140226183454.GA14639@cbox> <11174980.YJ21cfsHoG@wuerfel>
 <5AA88E43-1A40-4409-9A56-334988483843@suse.de>
Message-ID: <6039706.L1ZWvgjHF0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 22:24:13 Alexander Graf wrote:
> 
> If you want to assign a platform device, you need to generate a respective
> hardware description (fdt/dsdt) chunk in the hypervisor. You can't take
> the host's description - it's too tightly coupled to the overall host layout.

But at that point, you need hardware specific drivers in both the hypervisor
and in the guest OS. When you have that, why do you still care about a
system specification? 

Going back to the previous argument, since the hypervisor has to make up the
description for the platform device itself, it won't matter whether the host
is booted using DT or ACPI: the description that the hypervisor makes up for
the guest has to match what the hypervisor uses to describe the rest of the
guest environment, which is independent of what the host uses.

> Imagine you get an AArch64 notebook with Windows on it. You want to run
> Linux there, so your host needs to understand ACPI. Now you want to run
> a Windows guest inside a VM, so you need ACPI in there again.

And you think that Windows is going to support a VM system specification
we are writing here? Booting Windows RT in a virtual machine is certainly
an interesting use case, but I think we will have to emulate a platform
that WinRT supports then, rather than expect it to run on ours.
 
> Replace Windows by "Linux with custom drivers" and you're in the same
> situation even when you neglect Windows. Reality will be that we will
> have fdt and acpi based systems.

We will however want to boot all sorts of guests in a standardized
virtual environment:

* 32 bit Linux (since some distros don't support biarch or multiarch
  on arm64) for running applications that are either binary-only
  or not 64-bit safe.
* 32-bit Android
* big-endian Linux for running applications that are not endian-clean
  (typically network stuff ported from powerpc or mipseb.
* OS/v guests
* NOMMU Linux
* BSD based OSs
* QNX
* random other RTOSs

Most of these will not work with ACPI, or at least not in 32-bit mode.
64-bit Linux will obviously support both DT (always) and ACPI (optionally),
depending on the platform, but for a specification like this, I think
it's much easier to support fewer options, to make it easier for other
guest OSs to ensure they actually run on any compliant hypervisor.

	Arnd
