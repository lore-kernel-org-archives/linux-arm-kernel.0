From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 7 Jun 2013 09:14:52 +0900
Subject: [PATCH 01/02] ARM: shmobile: Let romImage rely on default ATAGS
In-Reply-To: <201306061819.58616.arnd@arndb.de>
References: <20130605075514.17653.77135.sendpatchset@w520>
 <201306051351.14978.arnd@arndb.de>
 <CANqRtoQZWmyMS6w2n9uW1-92-DOZcBst7gpCMrAC7GE9EwZUuQ@mail.gmail.com>
 <201306061819.58616.arnd@arndb.de>
Message-ID: <CANqRtoSNpdXHixfgRaF7_u5U8HnHpcbfZYeBcTEt_6hgoAawAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jun 7, 2013 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 06 June 2013, Magnus Damm wrote:
>> There are basically 4 types of zImages for mach-shmobile:
>>
>> 1) Regular zImage/uImage - DTB and ATAGS are passed from boot loader -
>> head-shmobile.S is not used.
>>
>> 2) Boot directly from MASK ROM from MMCIF/SDHI - head-shmobile.S loads
>> via MMC, sets up memory via mach/zboot.h, set ATAGS to NULL and passes
>> MACH_TYPE to kernel, ->fixup() sets up the actual memory bank
>> information.
>>
>> 3) Boot directly from NOR Flash - head-shmobile.S includes memory
>> setup code from mach/zboot.h, passes MACH_TYPE to kernel running in
>> flash.
>>
>> 4) Boot directly from MASK ROM via USB gadget - (r_usb_boot [1] runs
>> on your PC and loads to internal SRAM) - starts same image as 3)
>> above.
>>
>> To answer your question about multiplatform images, I believe  the
>> majority case 1) above will run just fine.
>
> Ok, got it, thanks for the explanation!
>
>> Regarding 2) -> 4), those are currently very specific to a certain
>> platform and they start directly from the reset vector which would
>> require them to either keep the board info hard-coded in the image or
>> somehow auto-detect board. From a hardware point of view I don' t
>> think there is any simple way to auto detect the boards in
>> mach-shmobile I'm afraid, so it looks to me that 2) -> 4) need to stay
>> board-specific.
>
> Yes, that makes sense.
>
> Just for completeness, am I guessing right that cases 2-4 are only for
> the previous "Renesas Technology" chips and their suggessors, while
> the previous NEC Emma EV2 only does the regular zImage boot?

You are correct that Emma Mobile EV2 only supports regular zImage boot
(1 above) in upstream. It is quite possible that the hardware in
theory could boot in other ways (this depends on the Mask ROM
capability), but I have not heard about anyone trying anything else.

> What about the current "Renesas Electronics" parts that include NEC
> technology, do they all support the head-shmobile.S direct boot?

As for chips coming from "Renesas Electronics", "Renesas Technology"
and if I may add "Renesas Mobile", the relationships between the
companies are quite complex so I'm afraid I can't give any good
answer.

The MMCIF/SDHI boot code was initially written for some older SH based
SoCs, but was re-implemented for ARM and sh7372 at some point. To boot
Linux directly from the reset vector it is necessary with memory
controller setup, and this is only supported by a few boards. At this
point AP4EVB and Mackerel have enough upstream coverage to boot
directly from NOR flash, MMCIF, SDHI or over USB gadget.

As for actual SoC support - which that support what boot methods much
depends on the product line and what has been implemented in the Mask
ROM. The boot mode is usually selected with a couple of pins at boot
time. Those pins are usually tied to DIP switches on the different
boards. On more recent SoCs I believe the Mask ROM allows for boot
over a wide range of I/O devices, but lately I have not seen anyone
booting Linux directly from the reset vector.

Regarding USB gadget boot and the "r_usb_boot" tool, it is known to
work on sh7372 and sh73a0.

Hope this helps,

/ magnus
