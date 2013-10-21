From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Oct 2013 21:19:21 +0100
Subject: ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131021085420.GA21518@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131021085420.GA21518@ulmo.nvidia.com>
Message-ID: <52658C49.80400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 09:54 AM, Thierry Reding wrote:
> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
...
>> I wonder if DT is solving the problem at the right level of
>> abstraction? The kernel still needs to be aware of all the
>> nitty-gritty details of how each board is hooked up different,
>> and have explicit code to deal the union of all the different
>> board designs.
>> 
>> For example, if some boards have a SW-controlled regulator for a
>> device but others don't, the kernel still needs to have driver
>> code to actively control that regulator, /plus/ the regulator
>> subsystem needs to be able to substitute a dummy regulator if
>> it's optional or simply missing from the DT.
>> 
>> Another example: MMC drivers need to support some boards
>> detecting SD card presence or write-protect via arbitrary GPIOs,
>> and others via dedicated logic in the MMC controller.
>> 
>> In general, the kernel still needs a complete driver to every
>> last device on every strange board, and needs to support every
>> strange way some random board hooks all the devices together.
> 
> I have some difficulty understanding what you think should've been
> moved out of the kernel. There's only so much you can put into data
> structures and at some point you need to start writing device
> specific code for the peripherals that you want to drive.

My point was that (part of) the intent of adding DT support to the
kernel was to get rid of all the board-specific code/churn in the
kernel. That's not really possible, since DT is just representing the
data about the HW (e.g. which GPIO/IRQ numbers) and not the behaviour.
In order to really remove signifcant board-specific code from the
kernel, you need to move behaviour out of the kernel too, i.e. hide it
behind some kind of firmware or virtualization interface, and hence
have simpler drivers that don't know all the details.

...
>> * Would UEFI/ACPI/similar fulfill this role?
> 
> If I recall correctly, the original OpenFirmware that introduced
> the DT concept used to have something similar to UEFI/ACPI.
> Essentially it was possible to not only pass the DT to the
> operating system but also allow the operating system to call back
> into the firmware to request service.

Yes, OpenFirmware might be another possible firmware interface. I
don't know anything about it...

>> * Perhaps a standard virtualization interface could fulfil this
>> role?
...
> What will likely happen with such a solution is that we'll have to
> come up with a standard interface that the guest OS expects.

I think much of that is already defined for a paravirt KVM guest
though, right?

...
> Vendor kernels that implement the host OS will effectively become
> forks of their own since there's no incentive to upstream code
> anymore. Linux upstream becomes a single unified architecture
> because all interfaces are now the same. Vendors are back to
> brewing their own.

True. Many/most(?) vendors work like that for most *products* though
already...

> ...

(Yes, I fully acknowledge there are many issues with
firmware/virtualization as a platform...)
