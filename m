From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 23 Mar 2010 11:34:32 -0500
Subject: [PATCH 2/3] ep93xx: add /proc/cpuinfo extension
In-Reply-To: <20100323153554.GD2904@gw.healthdatacare.com>
References: <0D753D10438DA54287A00B02708426976368DDCD38@AUSP01VMBX24.collaborationhost.net>
	<20100323153554.GD2904@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B02708426976368E58039@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 23, 2010 8:36 AM, Mika Westerberg wrote:
> On Mon, Mar 22, 2010 at 01:39:00PM -0500, H Hartley Sweeten wrote:
>> Add a callback to mach-ep93xx for the /proc/cpuinfo extension.
>> 
>> This cpuinfo extension dumps the processor unique ID and Maverick
>> Key as well as the processor silicon revision and a number of
>> boot configuration options.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> 
>> ---

[snip]

>> +	seq_printf(m, "Boot mode\t: %s %ssync %sternal %d-bit\n",
>> +		(val & EP93XX_SYSCON_SYSCFG_SBOOT) ? "serial" : "normal",
>> +		(val & EP93XX_SYSCON_SYSCFG_LASDO) ? "" : "a",
>> +		(val & EP93XX_SYSCON_SYSCFG_LEECLK) ? "in" : "ex",
>> +		ep93xx_boot_width());
>           ^^^^^^^^^^^^^^^^^
> 
> I got following compile error:
>
>  CC      arch/arm/mach-ep93xx/core.o
> arch/arm/mach-ep93xx/core.c: In function 'ep93xx_cpuinfo':
> arch/arm/mach-ep93xx/core.c:707: error: implicit declaration of function 'ep93xx_boot_width'
> make[1]: *** [arch/arm/mach-ep93xx/core.o] Error 1
> make: *** [arch/arm/mach-ep93xx] Error 2
>
> Should this function be included in the patch set also? I applied these on top of
> latest mainline kernel.

Grr.. Left that piece out, sorry about that.

I will post the updated patch in a bit.

If you want to test this now, just put the following after the 
ep93xx_chip_revision() in core.c (and of course the proper prototype in
platform.h).

Regards,
Hartley

---

/**
 * ep93xx_boot_width() - returns the external bus width for the boot device
 */
int ep93xx_boot_width(void)
{
	u32 val;
	int width;

	val = __raw_readl(EP93XX_SYSCON_SYSCFG);
	if (val & EP93XX_SYSCON_SYSCFG_LASDO) {
		/* Sync boot */
		if (val & EP93XX_SYSCON_SYSCFG_LCSN7)
			width = 32;
		else
			width = 16;
	} else {
		/* Async boot */
		if (val & EP93XX_SYSCON_SYSCFG_LCSN7)
			width = 32;
		else if (val & EP93XX_SYSCON_SYSCFG_LCSN6)
			width = 16;
		else
			width = 8;
	}
	return width;
}
