From: dianders@chromium.org (Doug Anderson)
Date: Fri, 29 Apr 2016 12:43:39 -0700
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20160429181248.GW19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Apr 29, 2016 at 11:12 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
>> This series picks patches from various different places to produce what
>> I consider the best solution to getting consistent mmc and mmcblk
>> ordering.
>>
>> Why consistent ordering and why not just use UUIDs?  IMHO consistent
>> ordering solves a few different problems:
>
> NAK.  Really.  Use UUIDs, that's the proper solution here.

Un-NAK.  UUIDs don't solve point #1.


> Exactly the same issue arises if you have more than one ATA or SCSI
> adapter in your PC - things can be probed out of order and end up
> in different /dev/sd* slots.

Yup, UUIDs are awesome and great and super.  Best invention since
sliced bread, really.  I definitely _won't_ submit a patch to remove
UUID support.  I promise.

A few notes, though:

* Presumably on a PC you've got an extra bit in the middle (like grub
or something like that) that can help you resolve your UUIDs even if
you get your kernel from somewhere else.  In my case, I don't have
that.  Maybe this is a failing of coreboot / depthcharge's netboot and
I suppose.  ...and I suppose I could modify the BIOS to take a root
filesystem of "eMMC" and have it resolve that to the eMMC's UUID or
something like that.  ...or I just take these patches locally and
things keep working like they did before.

* Presumably in the non-embedded world kernel hackers have a different
workflow.  They probably don't swap between different devices with
different configurations on an hourly basis.  They're not in the habit
of totally reimaging their system periodically.  Etc.  Trying to force
the workflow of a PC kernel hacker and an embedded kernel hacker to be
the same doesn't seem like a worthwhile goal.

* Presumably an embedded kernel hacker running with ATA / SCSI could
_usually_ assume that "sda" is his/her root filesystem.  It's unlikely
an embedded system would have more than one "sda" disk builtin and
it's nearly guaranteed (I think) that a builtin ATA / SCSI controller
would probe before any USB based devices.  Sure, if your root
filesystem is USB based (really?) and you've got additional USB
storage devices then you're SOL.  Sorry.

-Doug
