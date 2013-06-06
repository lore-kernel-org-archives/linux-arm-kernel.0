From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 6 Jun 2013 12:13:17 +0900
Subject: [PATCH 01/02] ARM: shmobile: Let romImage rely on default ATAGS
In-Reply-To: <201306051351.14978.arnd@arndb.de>
References: <20130605075514.17653.77135.sendpatchset@w520>
 <20130605075522.17653.20769.sendpatchset@w520>
 <201306051351.14978.arnd@arndb.de>
Message-ID: <CANqRtoQZWmyMS6w2n9uW1-92-DOZcBst7gpCMrAC7GE9EwZUuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jun 5, 2013 at 8:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 June 2013, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Remove the ATAGS data structure from head-shmobile.S
>> since a default ATAGS is already provided by the code
>> in arch/arm/kernel/atags_parser.c. Passing a NULL as
>> ATAGS is valid. For actual hardware specific setup
>> the fixup callback in the board code may be used.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Makes sense to me, but it's not really my area of expertise.
> Maybe Russell has some input on this.
>
> What about the rest of head-shmobile.S? If we ignore the mmcif boot
> code, can we boot an shmobile system using just the regular head.S
> code once we get to a multiplatform image with shmobile?

There are basically 4 types of zImages for mach-shmobile:

1) Regular zImage/uImage - DTB and ATAGS are passed from boot loader -
head-shmobile.S is not used.

2) Boot directly from MASK ROM from MMCIF/SDHI - head-shmobile.S loads
via MMC, sets up memory via mach/zboot.h, set ATAGS to NULL and passes
MACH_TYPE to kernel, ->fixup() sets up the actual memory bank
information.

3) Boot directly from NOR Flash - head-shmobile.S includes memory
setup code from mach/zboot.h, passes MACH_TYPE to kernel running in
flash.

4) Boot directly from MASK ROM via USB gadget - (r_usb_boot [1] runs
on your PC and loads to internal SRAM) - starts same image as 3)
above.

To answer your question about multiplatform images, I believe  the
majority case 1) above will run just fine.

Regarding 2) -> 4), those are currently very specific to a certain
platform and they start directly from the reset vector which would
require them to either keep the board info hard-coded in the image or
somehow auto-detect board. From a hardware point of view I don' t
think there is any simple way to auto detect the boards in
mach-shmobile I'm afraid, so it looks to me that 2) -> 4) need to stay
board-specific.

Cheers,

/ magnus

[1] http://marc.info/?l=linux-sh&m=131711553515485
