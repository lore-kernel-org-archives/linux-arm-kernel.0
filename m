From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 5 Aug 2011 13:36:56 -0500
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110805070729.GA26563@huya.qualcomm.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<20110805070729.GA26563@huya.qualcomm.com>
Message-ID: <CAKGA1bkM6X533w20hDV7GCPwzzj2nrjGdN6zkXsS+hCvUD_s2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2011 at 2:07 AM, David Brown <davidb@codeaurora.org> wrote:
> On Thu, Aug 04, 2011 at 06:07:15PM -0500, Matt Sealey wrote:
>> Hi Grant, Shawn,
>>
>> On Mon, Jul 25, 2011 at 3:46 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> > This could get really verbose in a really big hurry. ?Fortunately the
>> > dtb format is sophisticated enough to only store each unique property
>> > name once, so the data shouldn't be huge, but it is still going to
>> > make for huge source files. ?Can you think of a more concise
>> > representation?
>>
>> Yes: no representation at all. The correct place for IOMUX setup being
>> done is *inside the boot firmware as soon as physically possible* and
>> not seconds into boot after U-Boot has made a console, done a boot
>> timeout, loaded scripts, kernels and ramdisks from media and then
>> uncompressed and entered a Linux kernel.
>
> This is true in situations where we have control over the bootloader,
> but that isn't always the case.

Indeed it is not, but then it is "their" fault the board won't boot
Linux, and not yours, right? :)

I think it is a given that when designing hardware (and we do that)
and proprietary firmware that the Linux kernel guys can't "control",
you have to keep up with the changes when reasonable. While sometimes
that is very difficult, this is not one of those "sometimes" -
providing a setup that can boot Linux implies that you configured the
chip correctly such that Linux is supplementing that configuration,
not reimplementing it from scratch.

Back in the days when device trees were dynamically generated for
hardware based on their in-firmware state and then passed to Linux,
and not just bolted into the kernel binary, if you left a device in
the tree that didn't have it's pins muxed, you could consider that a
fatal firmware flaw, and the response we usually got from Linux
developers was "well, fix your firmware". It is far more prudent to
treat device trees as a state description of the hardware Linux was
booted on, and not a configuration file for drivers.. we've already
been through this a thousand times on PowerPC.

I know that FDT doesn't have the capability of a real OpenFirmware or
even an ACPI device tree, but the core concept that was most beautiful
and the most engaging that made us all want to have device trees and
real dynamic firmware was the fact that you could, if described in the
tree, bind a driver to it. This implies giving it the address of the
device in the memory map, information that describes it's behavior. At
the lowest level it maps almost 1:1 with the Linux "resource" concept
(i.e. memory, dma channels, buses, interrupts) and allows probing
based on human-readable strings and identifiers, so that differences
in PCB design and pin routing of different products can be reported to
Linux. And that's the thing here; reported to Linux, not "I left it
completely unconfigured, but here are the instructions on how to make
it work". At the point you end up rewriting a device tree to tell
Linux to configure this, and managed to make your firmware load it,
you may as well have modified the firmware to do the work and give
Linux an easy ride.

Yes, it puts the onus of the work on the firmware guys, but they're
the ones writing the device trees for their hardware anyway.

I understand that if Device Vendor A decides they want to support
Windows 8 and leave the system configured in a state such that
basically only Windows 8 works on it because the Right Thing To Do For
Linux(tm) is not the same as what it actually does to get up to the
point it brings up Windows 8, Linux is not going to work unless some
effort is expended to basically get the "right thing" done. This is
not necessarily a good fit for a device tree.. this is probably where
effort needs to be expended in putting a custom U-Boot on it so you
can do the right thing. Or writing a second-stage bootloader (like
Luigi for the Cr-48) which does the right thing.. and then providing
the device tree, which is the defacto standard here, based on the
right things it did.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
