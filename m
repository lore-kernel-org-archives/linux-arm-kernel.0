From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 17 Jan 2015 15:52:17 +0100
Subject: [systemd-devel] Making udev emit a signal when it is done loading
 modules
In-Reply-To: <20150117135630.GA25585@kroah.com>
References: <54BA20D0.7060402@redhat.com> <20150117135630.GA25585@kroah.com>
Message-ID: <54BA7721.6030102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17-01-15 14:56, Greg KH wrote:
> On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:
>> Dear udev developers,
>>
>> We (me and some kernel devs mostly) would like to add support to
>> the kernel for userspace telling the kernel that it is done with
>> the *initial* loading of modules, with the purpose of cleaning up
>> (disabling) unused harware resources like e.g. regulators and
>> clocks.
>
> But you don't "know" when that happens.  Especially with discoverable
> busses (PCI, USB, etc.), you know this :)

Right, I'm just bringing this up because it keeps coming back as
a possible solution to hardware resources getting turned off
too early during various kernel discussions, so I thought that as
this is a re-occuring theme, at a minimum someone should discuss
this with the udev people.

IOW I'm merely the manager, and you know what they say about
messengers ...  :)

>
>> Currently the kernel does this cleanup just before it starts init
>> (which may very well be init from a ramdisk). In some cases this
>> is too early really, because later on a module may get loaded
>> which needs this resources, these resources will then get turned
>> on again by the loaded driver, and most of the time this is not
>> an issue, but sometimes it is.
>>
>> I realize very well that there is no magic moment where udev is
>> really ever done loading modules, but the case which we want to
>> support only involves devices which are *already enumerated*, but
>> may not yet have a driver loaded, when udev starts. We would like
>> udev to emit a signal (ABI to be discussed) when it is done
>> trying to load modules for everything which was already enumerated
>> when it starts, iow when there are no new device events pending
>> anymore when udev does its initial hotplug replay.
>
> The kernel doesn't even "know" when this type of thing is, how can udev
> know this?

This is why I clearly limited this to *already enumerated* devices,
udev will know when it has exhausted whatever the kernel has enumerated
before it started, because at one point it will stop getting uevents
when replaying. This does not mean enumeration is really complete in any
way, it just means that modprobe has been run for any *already enumerated*
devices.

Most of these problems are on embedded (ish) systems, and there it is
a good bet that the troublesome device is enumerated already, since it
likely is devicetree instantiated.


>
>> So the question to you is would you be willing to include such
>> functionality in udev ?  Note this signal would need to be emitted
>> when udev from the real rootfs is done with the initial module
>> loading, as the real rootfs may very well have more modules
>> available then the initrd.
>>
>> ###
>>
>> With the generic story above told let me also give the concrete
>> example / problem which has let to me asking this (note this has
>> been brought up before on various kernel lists, it is a
>> re-occuring theme, this is just an example really) :
>>
>> The problem at hand is a sata connector which also has a sata-power
>> connector on an embedded (ish) board where the sata-power is
>> controlled through a gpio. The sata-power connector is modeled
>> in devicetree as a power-supply and this supply gets controlled
>> by the ahci_platform driver.
>>
>> The disk power may very well have already been turned on by the
>> bootloader, so we add a regulator-boot-on property to the regulator
>> node in devicetree to make sure that it is left untouched when the
>> regulator driver loads. If the ahci_platform driver is build into
>> the kernel, it will then take control of the regulator and
>> everything works well.
>>
>> If however the ahci_platform driver is a module, then as soon as
>> the kernel is ready to start init, unused regulators are turned off
>> and the disk looses its power while spinning and ends up doing an
>> emergency heads park.
>
> What turns off the power in this situation?  The kernel?  Or userspace?

The kernel.

> Don't you have control of this?

To some degree, this can be controller by a driver, and a driver can
stop this turning off, but atm this means that the driver MUST be builtin,
that is what we would like to fix.

> Have you tried to even create a patch that could do this type of thing
> to udev to see if it is even possible?

No, because as you indicated at the start of your mail I know this
area pretty well and I know this a somewhat controversial proposal,
so IMHO there is no use in spending time on this without at least
some buy-in of involved people.

Regards,

Hans
