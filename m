From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 06 Nov 2014 19:34:40 +0100
Subject: [PATCH] ARM: dts: zynq: Enable PL clocks for Parallella
In-Reply-To: <e78290abdb85497081f502e5886bf045@BL2FFO11FD057.protection.gbl>
References: <1415294531-8942-1-git-send-email-afaerber@suse.de>
 <e78290abdb85497081f502e5886bf045@BL2FFO11FD057.protection.gbl>
Message-ID: <545BBF40.8060602@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

Am 06.11.2014 um 18:33 schrieb S?ren Brinkmann:
> On Thu, 2014-11-06 at 06:22PM +0100, Andreas F?rber wrote:
>> The Parallella board comes with a U-Boot bootloader that loads one of
>> two predefined FPGA bitstreams before booting the kernel. Both define an
>> AXI interface to the on-board Epiphany processor.
>>
>> Enable clocks FCLK0..FCLK3 for the Programmable Logic by default.
>>
>> Otherwise accessing, e.g., the ESYSRESET register freezes the board,
>> as seen with the Epiphany SDK tools e-reset and e-hw-rev, using /dev/mem.
> 
> Yeah, this is the problem. Bypassing the kernel banging on memory
> directly through /dev/mem does not leave any chance of enabling clocks on
> demand through the proper interfaces.
> 
> Though, this is a valid workaround for the immediate problem, longer
> term, you should consider adding some kind of proper kernel driver for
> this interface that would then use the clock framework to control the
> required clocks dynamically.

Yes, Adapteva has a new char driver, and I have a proof-of-concept
platform driver on the branch I mentioned (where I had experimented with
enabling the wrong clock: adi,axi-clkgen-2.00a).
https://github.com/afaerber/linux/commits/parallella-next

But as there is no such driver in 3.17 or 3.18, I consider this patch
the right short-term fix according to your earlier message.

Apart from fixing functionality for users, it buys us more time to find
a consensus on how the kernel driver(s) should actually look like. ;)
My goal is having the DT describe the chip rather than some userspace
text/XML file and to have all chip-specific quirks in the driver.
I've been reading up on remoteproc, but it doesn't quite seem to match
the deployment model for Epiphany AFAICT.

Also, as discussed during the initial submission, we'll need to split
and reorganize the .dts file once we start adding nodes beyond the
common Epiphany IP.

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/17372208/attachment.sig>
