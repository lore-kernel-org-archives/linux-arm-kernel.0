From: alex.bou9@gmail.com (Alex Bounine)
Date: Wed, 1 Aug 2018 11:14:11 -0400
Subject: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180801103855.GD30658@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <20180731155228.GN17271@n2100.armlinux.org.uk>
 <044af717-3883-a7a6-c346-18fa8cebce76@gmail.com>
 <20180731181834.GA30658@n2100.armlinux.org.uk>
 <570ad147-3c58-8911-0111-29e21087ca7a@gmail.com>
 <20180801103855.GD30658@n2100.armlinux.org.uk>
Message-ID: <ea3b7ad0-feef-0a53-d0e7-d3bbe8c52251@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2018-08-01 06:38 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 04:01:27PM -0400, Alex Bounine wrote:
>> On 2018-07-31 02:18 PM, Russell King - ARM Linux wrote:
>>> On Tue, Jul 31, 2018 at 01:59:27PM -0400, Alex Bounine wrote:
>>>> On 2018-07-31 11:52 AM, Russell King - ARM Linux wrote:
>>>>> On Tue, Jul 31, 2018 at 08:54:14AM -0400, Alex Bounine wrote:
>>>>>> On 2018-07-31 04:41 AM, Will Deacon wrote:
>>>>>>> On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
>>>>>>>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>>>>>>>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>>>>>>>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>>>>>>>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>>>>>>>
>>>>>>>> Tested that kernel builds for arm64 with RapidIO subsystem and
>>>>>>>> switch drivers enabled, also that the modules load successfully
>>>>>>>> on a custom Aarch64 Qemu model.
>>>>>>>>
>>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>>>>> Cc: John Paul Walters <jwalters@isi.edu>
>>>>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>>>>> Cc: linux-kernel at vger.kernel.org,
>>>>>>>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>>>>>>>> ---
>>>>>>>>   arch/arm64/Kconfig | 2 ++
>>>>>>>>   1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> Thanks, this looks much cleaner than before:
>>>>>>>
>>>>>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>>>>>
>>>>>>> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
>>>>>>> unconditionally in the arm64 Kconfig. Does selecting only that option
>>>>>>> actually pull in new code to the build?
>>>>>>>
>>>>>> HAS_RAPIDIO option is intended for SOCs that have built in SRIO controllers,
>>>>>> like TI KeyStoneII or FPGAs. Because RapidIO subsystem core is required
>>>>>> during RapidIO port driver initialization, having separate option allows us
>>>>>> to control available build options for RapidIO core and port driver (bool
>>>>>> vs. tristate) and disable module option if port driver is configured as
>>>>>> built-in.
>>>>>
>>>>> Your explanation doesn't make much sense to me.
>>>>>
>>>>> RAPIDIO is the bus-level support, right?  So drivers that depend on
>>>>> the bus-level support should depend on RAPIDIO, and so, if RAPIDIO
>>>>> is configured as a module, they will also be allowed to be disabled
>>>>> or a module, but not built-in if tristate.  If it is boolean, and
>>>>> causes the driver to be built-in to the kernel, then you need to use
>>>>> "RAPIDIO=y" so that it's dependency is only satisfied when the core
>>>>> is built-in.
>>>>>
>>>>
>>>> RapidIO host controllers (on local bus like SoC internal or PCIe) are
>>>> serviced by MPORT device drivers that are subsystem specific and communicate
>>>> with RapidIO core using set of callbacks. Depending on HW architecture these
>>>> drivers may be defined as built-in or module.
>>>
>>> Why does hardware architecture define whether something has to be built
>>> in or can be modular?
>>>
>>> It is the case today that (eg) on-SoC hardware _can_ be built as a module
>>> if desired - just because it's on the SoC does not mean it has to be
>>> built in to the kernel.  Why is RapidIO any different?
>>>
>>
>> Not HW architecture - legacy can be blamed as well. Freescale's FSL_RIO
>> driver still exist as built-in so far. Intent of this patch set is to allow
>> RapidIO support in more architectures without reworking old stuff.
>> I do not think that anyone will be updating FSL_RIO driver soon.
> 
> Sorry, but I'm even more confused.  If it's not hardware architecture,
> then why did you say previously "Depending on HW architecture these
> drivers may be defined as built-in or module." ?

My fault, I took some shortcuts in writing here and that made it not 
clear enough. In this case I was talking about legacy code existing in 
PowerPC architecture branch. FSL_RIO host driver can be built only as 
built-in what forces RIO core to be built-in as well.

> If it's that the driver isn't written to be a module, then that is not
> "HW architecture".  Are you just trying to muddy the water?

Not at all :) See above. Driver within architectural branch.

>> Also we cannot dictate to developers of future drivers which method to use -
>> they may have built-in option only for the first release.
> 
> How is that any different from all the other drivers that we have?
> 
> If a driver can only be built-in, then we do this in the Kconfig:
> 
> config DRIVERFOO
> 	bool "Support driverfoo"
> 	depends on SUBSYSTEM=y
> 
> which ensures that the driver can only be built when it's dependent
> subsystem is also built-in.
> 
> There is another alternative way, which is:
> 
> config SUBSYSTEM
> 	tristate
> 
> config DRIVERFOO
> 	bool "Support driverfoo"
> 	select SUBSYSTEM
> 
> config DRIVERBAR
> 	tristate "Support driverbar"
> 	select SUBSYSTEM
> 
> and "SUBSYSTEM" will automatically adopt either 'm' or 'y' correctly
> depending on whether any drivers are built-in or not.
> 
Agree.

>> Unfortunately we have on hands dependency between mport driver build mode
>> and  RapidIO core which we need to respect.
> 
> How is that any different from (eg) hundreds of network drivers and the
> networking core code that we already have?  That doesn't have such a
> convoluted configuration system, and what you have is much simpler.
> 
>>> For example, can you point out why my idea I present below would not
>>> work?
>>
>> See below.
>>
>>>
>>>> For peripheral devices attached to the RapidIO fabric such dependency on
>>>> local mport implementation does not exist and therefore they all can be
>>>> treated as tristate.
>>>>
>>>>> HAS_RAPIDIO gives the impression that it defines whether or not
>>>>> the rapidio core code is allowable or not - it doesn't suggest that
>>>>> it has anything to do with drivers. However, reading the PowerPC
>>>>> Kconfig files, it seems to be used that way.  That's confusing, and
>>>>> ought to be fixed.  From what I can tell, it's only used for FSL_RIO,
>>>>> so I suggest that gets converted to:
>>>>>
>>>>> config HAS_RAPIDIO
>>>>> 	bool PCI
>>
>> PCI and RAPIDIO can be mutually exclusive.
> 
> Please explain this in light of your patches which contain:
> 

Availability of PCIe and RapidIO can be mutually exclusive on specific 
boards.
On oter boards we may have both buses at the same time.
Any platform with PCIe can add RapidIO support using PCIe-to-SRIO host 
bridge.

> config RAPIDIO
> 	tristate "RapidIO support"
> 	depends on HAS_RAPIDIO || PCI
> 
> This allows RAPIDIO can be selected when PCI is enabled.  Therefore,
> PCI and RAPIDIO *are not* mutually exclusive as your comment above
> states, therefore, I have to assume that your comment is wrong.
> 
>>>>>
>>>>> config RAPIDIO
>>>>> 	tristate "RapidIO support"
>>>>> 	depends on HAS_RAPIDIO
>>>>>
>>>>> config HAS_FSL_RIO
>>>>> 	bool
>>>>> 	select HAS_RAPIDIO
>>
>> Introducing new variable HAS_FSL_RIO here. Do you suggest having one for
>> each ARM-based board that has on-chip RIO?
> 
> No, I'm suggesting a solution for what I see in the kernel tree today,
> which is frankly a mess for the reasons I've already outlined.
> 
> HAS_FSL_RIO is based on the _only_ SoC driver apparently in the tree
> based on what I could find in the arch/*/Kconfig files.  If you don't
> think having individual HAS_* options in this way is appropriate,
> then maybe instead having per-SoC hidden HAS_* config options are
> more appropriate.
> 
This is what we are trying to use here: per-SoC option HAS_RAPIDIO. 
While the name does not have an individual designation (like 
HAS_FSL_RIO) it will be only the SoC in the given system that selects 
it. This will enable RapidIO configuration menu, allowing user to go 
ahead with remaining RIO configuration. Enabling on-chip port stays as 
per-SoC option.

Having PCIe bus brings another twist because PCIe-to-SRIO bridge can be 
used when HAS_RAPIDIO=n. As result every platform that has PCIe should 
enable RapidIO (except in architectures that do not support RIO at this 
moment).

>>>>>
>>>>> config FSL_RIO
>>>>> 	bool "Freescale Embedded SRIO Controller support"
>>>>> 	depends on RAPIDIO = y && HAS_FSL_RIO
>>>>>
>>>>> This frees up HAS_RAPIDIO to operate as one would expect - to define
>>>>> whether or not RAPIDIO should be offered.  This also allows:
>>>>>
>>>>> config ARM
>>>>> 	select HAS_RAPIDIO if PCI
>>
>> Some SOCs can be configured without PCI. We have confusing action here - we
>> have to enable PCI on platform that does not have it.
> 
> Again, you said above "PCI and RAPIDIO can be mutually exclusive."  This
> comment self-conflicts with your previous comment.

I explained "mutually exclusive" above.

> 
> What you now seem to be saying goes against the patches and the current
> Kconfig.  You seem to be saying that RAPIDIO _requires_ PCI.
> 
> So, we now have three completely different statements from you:
> - "we have to enable PCI on platform that does not have it."
> - "PCI and RAPIDIO can be mutually exclusive."
> - RAPIDIO does not require PCI (since HAS_RAPIDIO=y RAPIDIO=y PCI=n is
>    a permissible configuration as things stand with PowerPC.)
> 
> Which is it?
> 
> It seems to be that your replies are just muddying the water - I can
> only assume that this is to make us give up.  Please don't do that,
> it's not in your interest.
> 
>> Why we cannot use "select HAS_RAPIDIO" HW-specific Kconfig file
>> (mach-*/Kconfig)? And have on-chip port selection in the same board-specific
>> place.
> 
> As I've already explained, HAS_RAPIDIO has the expectation that it
> controls the availability of the RAPIDIO option, not of drivers.
> It is HAS_*RAPIDIO*, the clue is in the name.  Using it as you are
> (basically, to mean that on-SoC rapidio hardware is present) and
> allowing such configurations as HAS_RAPIDIO=n RAPIDIO=y PCI=y is
> completely counter-intuitive.
> 
