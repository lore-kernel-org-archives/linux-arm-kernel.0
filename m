From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sat, 20 Mar 2010 14:42:26 -0500
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <20100320183127.GA2904@gw.healthdatacare.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
	<20100320183127.GA2904@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B02708426976368B755D5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 20, 2010 11:31 AM, Mika Westerberg wrote:
> On Sat, Mar 20, 2010 at 06:07:50PM +0000, Martin Guy wrote:
>> On 3/18/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>>> Added a new function: ep93xx_chip_revision() which reads chip revision from the
>>>  sysconfig register.
>>>
>>>  diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>>>  index 90fb591..07572bb 100644
>>>  --- a/arch/arm/mach-ep93xx/core.c
>>>  +++ b/arch/arm/mach-ep93xx/core.c
>>>  @@ -222,6 +222,20 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
>>>   }
>>>   EXPORT_SYMBOL(ep93xx_devcfg_set_clear);
>>>
>>>  +/**
>>>  + * ep93xx_chip_revision() - returns the EP93xx chip revision
>>>  + *
>>>  + * See <mach/platform.h> for more information.
>>>  + */
>>>  +unsigned int ep93xx_chip_revision(void)
>>>  +{
>>>  +       unsigned int v;
>>>  +
>>>  +       v = __raw_readl(EP93XX_SYSCON_SYSCFG);
>>>  +       v &= EP93XX_SYSCON_SYSCFG_REV_MASK;
>>>  +       v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
>>>  +       return v;
>>>  +}
>> 
>>   The chip revision is normally placed in the global unsigned int
>> "system_rev", which is also reported by /proc/cpuinfo.
>
> Is system_rev same as cpu chip revision? I think it should contain
> board revision number or something similar.

The system_rev != the chip revision.

>>   It normally seems to be set from the atags passed by the bootloader
>> but uboot on this platform doesn't provide that, so it remains 0.
>
> Neither my platform (uses redboot):
>
> Hardware        : Technologic Systems TS-72xx SBC
> Revision        : 0000
> Serial          : 0000000000000000
>
>>   The same applies to the very similar variables system_serial_low and
>> system_serial_high (which also remain 0 on this u-boot platform).
>> Shall we also set these from the hardware on ep93xx during thus giving
>> them non-zero values in /proc/cpuinfo too?
>>   As to where...? The other platforms that set these variables from
>> hardware queries do it in the board-specific files' MACHINE_START
>> function, but we'd have to do this in every board file, or have some
>> comon routine and modify every mach-ep93xx board file. The only common
>> routine all ep93xx board inits seem to have is ep93xx_init_devices.
>> This seems the least-resistance place to do this, but has nothing to
>> do with initlalizing devices of course. Is making another function in
>> toe core file and modifying every board's init function preferable?
>> 
>> Also, I have the simpler
>>     system_rev = *((unsigned int *)EP93XX_SYSCON_CHIP_ID) >> 28;
>>     system_serial_low = *((unsigned int *)EP93XX_SECURITY_UNIQID);
>> but maybe explicit readl and use of long defines are preferable.
>
> I'm not the best guy to answer these. Maybe Hartley Sweeten or Ryan
> Mallon have some ideas about this. I didn't even know that such
> variable exists :)

This is not a good idea.

system_rev, system_serial_high, and system_serial_low are all passed to
the kernel by the bootloader as ATAGs.  If your bootloader doesn't pass
the ATAGs it should be fixed.  Overriding the variables breaks what they
are intended for.

I have some patches for Redboot but Cirrus still has not sent in the FSF
paperwork to transfer the ep93xx port to eCos.  With those patches and
the /proc/cpuinfo extension patches I mentioned previously I get the
following on my system:

/ # cat /proc/cpuinfo
Processor       : ARM920T rev 0 (v4l)
BogoMIPS        : 99.53
Features        : swp half thumb crunch
CPU implementer : 0x41
CPU architecture: 4T
CPU variant     : 0x1
CPU part        : 0x920
CPU revision    : 0

Hardware        : Vision Engraving Systems EP9307
Revision        : 0001
Serial          : 4943410027260017

System Type     : iMARC

Unique ID       : 921040f8
Maverick Key    : 921040f85b6f0e7b76eb23d24309b3 OK
Silicon Rev     : E2
Watchdog        : active
Reset duration  : active
Boot mode       : normal async internal 16-bit
/ #

Regards,
Hartley
