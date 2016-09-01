From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 1 Sep 2016 13:16:43 +0000
Subject: [PATCH] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <fdf48f3c-c7f5-4b9b-ff6b-f801b04f3f33@ti.com>
References: <20160829153242.18615-1-kbeldan@baylibre.com>
 <7h37lk5wrd.fsf@baylibre.com>
 <3945712b-d02f-d97a-2356-9383d7fe1984@ti.com>
 <20160901095857.GA27385@gobelin>
 <fdf48f3c-c7f5-4b9b-ff6b-f801b04f3f33@ti.com>
Message-ID: <20160901131643.GA19295@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 03:46:44PM +0530, Sekhar Nori wrote:
> On Thursday 01 September 2016 03:30 PM, Karl Beldan wrote:
> > On Thu, Sep 01, 2016 at 10:47:04AM +0530, Sekhar Nori wrote:
> >> On Thursday 01 September 2016 05:14 AM, Kevin Hilman wrote:
> >>> Karl Beldan <kbeldan@baylibre.com> writes:
> >>>
> >>>> This adds DT support for the NAND connected to the SoC AEMIF.
> >>>> Passed torture hashing a 40MB file on top of UBIFS using subpages.
> >>>>
> >>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> >>>> ---
> >>>> v2:
> >>>>
> >>>> - Removed comments pertaining to the BSP the LCDK ships with (Sekhar)
> >>>> - s/"ok"/"okay"/
> >>>> - Removed partitions since it relates to the BSP the LCDK ships with
> >>>
> >>> IMO, some default partitions are nice to have, at least for u-boot and
> >>> u-boot env so factory-shipped u-boot is not accidentally overridden.
> >>> The left over space can be labeled "free space".
> >>>
> >>> Anyways, after adding some partitions back, I tested with ubifs on my
> >>> LCDK:
> >>
> >> This[1] is what I had commented on the partitions before. I did not 
> >> mean to remove partitions altogether, just comments referring to 
> >> compatibility with pre-flashed software shipping with LCDK (since that 
> >> changes without notice).
> >>
> >> Apologies for any confusion caused. The "Rest of the patch looks good
> >> to me" in the end was to say that the partitions themselves look fine :)
> >>
> > 
> > None necessary, I just pushed the logic further on my own as specified
> > in the changelog. I can add the partitions back as I don't have any
> > strong preference on this, but not without mentioning that it is because
> > that is what the LCDK ships with, as in my original version, please see
> > if the adjustments below accomodate your preferences.
> > 
> >> Can you please submit a v2 with partitions added?
> >>
> >> Thanks,
> >> Sekhar
> >>
> >> [1]
> >>
> >>> +
> >>> +			/*
> >>> +			 * LCDK original partitions:
> >>> +			 * 0x000000000000-0x000000020000 : "u-boot env"
> >>> +			 * 0x000000020000-0x0000000a0000 : "u-boot"
> >>> +			 * 0x0000000a0000-0x0000002a0000 : "kernel"
> >>> +			 * 0x0000002a0000-0x000020000000 : "filesystem"
> >>> +			 *
> >>> +			 * The 1st NAND block being guaranted to be valid w/o ECC (> 1k cycles),
> >>> +			 * it makes a perfect candidate as an SPL for the BootROM to jump to.
> >>> +			 * However the OMAP-L132/L138 Bootloader doc SPRAB41E reads:
> >>> +			 * "To boot from NAND Flash, the AIS should be written to NAND block 1
> >>> +			 * (NAND block 0 is not used by default)", which matches the LCDK
> >>> +			 * original partitioning.
> >>
> >> FWIW, silicon version 2.1 supports booting from block 0, but needs new
> >> boot pin settings not possible in stock LCDK.
> >>
> > 
> > I'd add [1]:
> > Same doc reads for ROM "Silicon Revision 2.1", "Updated NAND boot mode
> > to offer boot from block 0 or block 1", (Sekhar:) "but needs new boot pin
> > settings not possible in stock LCDK".
> > 
> >>> +			 * Also, the LCDK ships with only the u-boot partition provisioned and
> >>> +			 * boots on it in its default configuration while using the MMC for the
> >>> +			 * kernel and rootfs, so preserve that one as is for now.
> >>> +			 * [1]: Ensuring for example that U-Boot LCDK SPL can handle it properly
> >>> +			 * and a proper boot chain ROM->SPL->U-Boot->Linux wrt ECC, would allow
> >>> +			 * for a better partitioning.
> >>> +			 */
> >>
> >> I would rather not refer to the software that LCDK ships with in the
> >> comments at all. Because that can change without notice. At some point,
> >> if mainline kernel works well enough on LCDK, TI might decide to ship
> >> LCDKs with mainline kernel flashed.
> >>
> > 
> > If you want me to keep the partitions, I would change that to [2] "Here
> > we keep the first two provisioned default partitions and labels the LCDK
> > ships with as is." (although FWIU it conflicts with your request above).
> 
> The reason for choosing the two partitions like the way you do is not
> because "LCDK ships with as is", but because:
> 

This is not exactly what I have written, but this all looks like a drag
to me so I'll pass.

> a) LCDK cannot book from block 0 (needs a different boot mode)
> 
> b) Block 0 is guaranteed to be good and capable of ~1000 erase cycles on
> most NANDs so using it to store environment variables makes sense.
> Especially on development boards where environment might be updated
> frequently during course of usage. Coupled with the fact that U-Boot
> does not implement any sort of wear-leveling on environment block (AFAIK).
> 
> c) If block 0 is dedicated to env, block 1 is the next logical block to
> be used for u-boot.ais
> 
> d) rest of the space is left to be used as the user deems fit.
> 

If I put those HW facts in my original patch before you stated them,
it is obviously because they strongly guide the partitioning, so I will
skip that (except for c) which I address below).

> I still disagree with any references to legacy software that ships with
> LCDK. The partitioning scheme is used because it makes most sense. Not
> because the board ships with it.
> 

I, along with most people I believe, would choose to use what makes most
sense ;).
If you insist on asserting this particular scheme makes most sense and
that is the reason it is used:
- First obviously, if you didn't provision the NAND, I wouldn't provide
  a partition, no matter your desiderata (if I saw your scheme was the
  one making the most sense I would though), would you ?
- Isn't it a matter of preserving the factory-shipped u-boot ?
- Next, you are reserving ~0xa0000 space for U-Boot which itself is
  several 100KBs for the boot ROM to jump to, can't you imagine someone
  else using way less space for an SPL ? Advantages include less chance
  to corrupt the 1st piece of SW the HW jumps to and proper U-Boot (or
  whatever) mirroring.

Some digression:
This morning I hesitated to send a patch to choose a proper OOB layout,
here's what the sprab41e.pdf (BootROM info for OMAP-L132/L138) I found
on the net states wrt OOB layout:
"Each segment of spare bytes contains 6 test bytes and 10 ECC
bytes. For those pages that are checked during bad block detection, all
the test bytes in each segment must equal FFh; any other value indicates
that the page (and its entire block) is bad and should not be used."
U-Boot has a provision to use this scheme, (although it doesn't really
match since it considers the 3 last segment 'test bytes' as free).
What I found is that it is only used for one board only and keystone has
a compile time define to use said layout while having to pay attention
that Linux is using a layout like nand_ooblayout_lp_ops. What makes even
less sense, is that the Linux driver still uses the 10bytes<->8bytes
(un)packing scheme unconditionally which is of no use except for saving
2 bytes per OOB 'section' (ie. 2 bytes / 512 bytes data) which moreover
would otherwise not be used and have no use except for compatibility
with the boot ROM. This has been the case for years.
What also made little sense is how you put during the nand DTS addition
that you would not accept 1bit ECC to switch to 4bit ECC right-away,
while ECC issues have been registered in TI forums with such issues for
years, and is also a 1 (among 17) entries in the MTD section of
bugzilla.kernel.org.
I think I have also raised some other issues along our recent exchanges.

This digression to say that it is a little bit difficult to eat such
nits while reading your "partitioning scheme is used because it makes
most sense.", and not getting a tad annoyed.

I can't remember the name of this guy who said, if you want to drag
research today, just grant more money, but via comitees, I guess it's
the same in many other areas.  It might well be something else, such
nits are sometimes just a pretext, though if they are bona fide, it's
all to your credit to take upon yourself that they might seem so.

It is not comfortable to doubt the attitude of a maintainer but it is
even less so to see them abusing their prerogatives, and do nothing
about it.

On my side I can't thrive on such things, especially what we are
presently discussing so I'll pass.

Thanks, 
Karl
