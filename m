From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 8 Nov 2016 16:08:38 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <20161108154038.GS1041@n2100.armlinux.org.uk>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <20161108145118.GR1041@n2100.armlinux.org.uk>
 <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
 <20161108154038.GS1041@n2100.armlinux.org.uk>
Message-ID: <e83e8462-6d63-7253-f69c-afb507463bba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/16 15:40, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2016 at 03:11:07PM +0000, Sudeep Holla wrote:
>> On 08/11/16 14:51, Russell King - ARM Linux wrote:
>>> On Wed, Nov 02, 2016 at 10:52:03PM -0600, Sudeep Holla wrote:
>>>> This is minor rework of the series[1] from Neil Armstrong's to support
>>>> legacy SCPI protocol to make DT bindings more generic and move out all
>>>> the platform specific bindings out of the generic binding document.
>>>
>>> Is this what would be in my HBI0282B Juno?
>>>
>>
>> No, it's one on the AmLogic Meson GXBB platform. Juno never supported
>> that except that old firmware use it internally. By that I mean some
>> version of trusted firmware used legacy SCPI but they are generally
>> bundled together in fip, so you should not see any issue with upgrade.
>
> I was wondering whether it'd work with my existing 1st September 2014
> version of the trusted firmware.  I've pretty much come to the
> conclusion that there's no way I can run the later firmware on this
> hardware.
>

No, we should be able to fix it. It's just some weird configuration
that has triggered this. Generally people just replace entire tarball
into uSD and hence it is not tested very well for such cases.

>> I am currently trying to run Linaro 16.10 release, I don't see any issue
>> except network boot from UEFI which is known and reported.
>
> Interesting - maybe the hardware is different then?
>

No, we have seen issues in past especially UEFI.

>> I will go through your logs in detail and try to replicate your issue.
>> I assume you have tried replacing the entry contents of the uSD with the
>> release. I will start with that now.
>
> I haven't wiped it and copied the entire contents of the zip file over.
> I instead backed up the old board.txt and images.txt files, and copied
> the HBI0282B directories on top of the others.
>
> This correctly causes all the various components to be updated when the
> board boots, updating the MBB BIOS, iofpga, and reprogramming the NOR
> flash with the updated images.  I even diff'd what was on the uSD card
> and what was supplied in the zip file.
>
> That's one state I tested: it also allowed me to edit the board.txt and
> similar to wind back to what I have now on the board - which is all the
> old versions of the firmware except for the MBB BIOS.
>
> Anyway, I've wiped the uSD, and copied the contents of the 16.10 release
> over:
>

[...]

> Memory Allocation 0x00000004 0xFE07B000 - 0xFE826FFF
> Memory Allocation 0x00000004 0xFE03B000 - 0xFE07AFFF
> Memory Allocation 0x00000003 0xFE03B000 - 0xFE07AFFF
> FV Hob            0xE0000000 - 0xE00EFFFF
> FV Hob            0xFE07B000 - 0xFE8253BF
> FV2 Hob           0xFE07B000 - 0xFE8253BF
>
> which looks more hopeful... except it stops there.
>

Ah that's good, some progress.

> As it contains a zero sized Image and .dtb files, I tried copying my
> Image and .dtb over, and also copied my original config.txt (only
> change is AUTORUN: FALSE).  It still doesn't appear to boot beyond
> this point.
>

I will focus on this and see what's happening. I have issue with network
on my setup with debug build and Linaro guys are not seeing it. I revert
to release build of UEFI for that. Anyways one suggestion I have right
now is to erase the second partition of NOR flash where the old UEFI
config is placed and it could be conflicting with the new UEFI image.

Cmd> flash
 

Switching on main power...
PMIC RAM configuration (pms_v105.bin)...
IOFPGA config: PASSED
Enabling usb remote...
 

Flash> ERASERANGE 0x0BFC0000 0x0BFF0000

I will looking into that further.

-- 
Regards,
Sudeep
