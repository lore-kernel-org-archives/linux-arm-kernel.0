From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 8 Nov 2016 17:37:25 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <20161108160625.GU1041@n2100.armlinux.org.uk>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <20161108145118.GR1041@n2100.armlinux.org.uk>
 <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
 <20161108154038.GS1041@n2100.armlinux.org.uk>
 <20161108160625.GU1041@n2100.armlinux.org.uk>
Message-ID: <fb4348a8-197c-2219-ff01-8716e2a0b955@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/16 16:06, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2016 at 03:40:38PM +0000, Russell King - ARM Linux wrote:
>> As it contains a zero sized Image and .dtb files, I tried copying my
>> Image and .dtb over, and also copied my original config.txt (only
>> change is AUTORUN: FALSE).  It still doesn't appear to boot beyond
>> this point.
>
> Well, it seems that I can't even go back to my original set of firmware
> as UEFI has stopped working:
>
> NOTICE:  Booting Trusted Firmware
> NOTICE:  BL1: v1.0(release):14b6608
> NOTICE:  BL1: Built : 14:15:51, Sep  1 2014
> NOTICE:  BL1: Booting BL2
> NOTICE:  BL2: v1.0(release):14b6608
> NOTICE:  BL2: Built : 14:15:51, Sep  1 2014
> NOTICE:  BL1: Booting BL3-1
> NOTICE:  BL3-1: v1.0(release):14b6608
> NOTICE:  BL3-1: Built : 14:15:53, Sep  1 2014
> UEFI firmware (version v2.1 built at 14:41:56 on Oct 23 2014)
> Warning: Fail to load FDT file 'juno.dtb'.
>

This again because of incompatibility of the configuration data saved in
NOR flash. The erase command I gave early is to erase that when you
switched between the UEFI binaries. It's really horrible mess UEFI
created in the initial days of Juno, and hopefully they have moved to
some standard format these days.

> and UEFI is the most unfriendly thing going - the "boot manager" thing
> doesn't let you view the configuration:
>

I completely agree. I had real bad times in past dealing with such
things in UEFI.

> [1] Linux from NOR Flash
> [2] Shell
> [3] Boot Manager
> Start: 3
> [1] Add Boot Device Entry
> [2] Update Boot Device Entry
> [3] Remove Boot Device Entry
> [4] Reorder Boot Device Entries
> [5] Update FDT path
> [6] Set Boot Timeout
> [7] Return to main menu
> Choice:
>
> and dropping into the shell... well, I've no idea how to get a listing
> of what it thinks is in the NOR device (or even how to refer to the
> NOR device.)  "devices" shows nothing that's even remotely English.
>

I think startup.nsh needs some edits. Just replace it with something like:

"norkern dtb=board.dtb console=ttyAMA0,115200n8 root=/dev/nfs rw
rootwait ip=dhcp systemd.log_target=null nfsroot=..." or something
alike. Currently it just echos and stops.

Regarding the new firmware stopping abruptly, I have no clue, except
asking you to erase the flash completely when switching between the
firmware versions. That has worked for me for all UEFI related issues in
the past. It's really annoying I understand.

flash> eraseall

-- 
Regards,
Sudeep
