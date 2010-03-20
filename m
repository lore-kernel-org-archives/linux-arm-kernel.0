From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sat, 20 Mar 2010 14:31:03 -0500
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <56d259a01003201140o8852165w7d1b3384927e70f7@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
	<20100320182500.GF30801@buzzloop.caiaq.de>
	<56d259a01003201140o8852165w7d1b3384927e70f7@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B02708426976368B755D3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 20, 2010 11:41 AM, Martin Guy wrote:
> On 3/20/10, Daniel Mack <daniel@caiaq.de> wrote:
>> On Sat, Mar 20, 2010 at 06:07:50PM +0000, Martin Guy wrote:
>>>   The chip revision is normally placed in the global unsigned int
>>> "system_rev", which is also reported by /proc/cpuinfo.
>>
>> No, that's the hardware revision number, which is different from the
>>  chip revision number.
>
> The board revision? Right, thanks. I don't see a place to report this
> in cpuinfo, since it is the SoC revision, which is neither the ARM CPU
> it contains nor the board that conatins the SoC.
>
>> If the ep93xx provides a unique serial number, then this could be an
>>  idea. I would still only set it in case it has not been given by the
>>  bootloader though.
>
> It does, world-unique, burned into the chip. Thanks again.

Hello all,

Just to clarify things.

'system_rev' is an unsigned int exported from arch/arm/kernel/setup.c
It is filled in with the ATAG_REVISION data passed from the bootloader.
What this data actually means is specific to the bootloader.

'system_serial_low' and 'system_serial_high' are also unsigned int's
exported from arch/arm/kernel/setup.c.  These are filled in with the
ATAG_SERIAL data passed from the bootloader.  Again, what this data
actually means is specific to the bootloader.

These three values are exposed to the user via /proc/cpuinfo.  The
seq_operations that handle this are also in arch/arm/kernel/setup.c.

Mika's patch has nothing to do with these.  As already noted, the
chip revision needs to be determined in order to figure out the
correct internal frequency of the SSP peripheral clock.

This chip revision is currently not exposed to the user in any fashion.

The ep93xx unique serial number, also called the MaverickCrunch ID, can
be found in the Sercurity registers.  There are actually two of them.
One is a 32-bit unique ID the other is a 128-bit random ID.  Random
meaning random per chip not per boot since it is created by means of
fuseable links on the chip that are set during manufacture.  These
also are not currently exposed to the user in any fashion.

I had submitted a patch previously that adds an architecture specific
extension to /proc/cpuinfo that would allow exposing this information
on the ep93xx.  The same extension could be used on platforms like the
TS-7200 to show the jumper settings on the board.

If there is any interest I will re-post that patch series.

Regards,
Hartley
