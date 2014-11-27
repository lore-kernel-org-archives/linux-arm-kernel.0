From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 27 Nov 2014 12:32:47 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141127011203.GR2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411270038.01312@pali>
 <20141127011203.GR2817@atomide.com>
Message-ID: <201411271232.47231@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141126 15:40]:
> > With enabled CONFIG_ARM_APPENDED_DTB=y file /proc/atags is
> > missing.
> 
> OK I guess it should not be needed for DT based booting.
> 

If I do not enable CONFIG_ARM_APPENDED_DTB=y then kernel is 
booting in legacy mode (not in DT).

> > > The build_tag_list() should parse ATAG_REVISION and then
> > > parse_tag_revision() should copy it to system_rev. Maybe
> > > try adding some printks to see if those functions get
> > > called?
> > 
> > Now I see... Problem is that build_tag_list() is called from
> > convert_to_tag_list() which is called from
> > setup_machine_tags() which is called from setup_arch() only
> > if setup_machine_fdt() call fails. And it fails for *non*
> > DT boot. You can check this chain too.
> 
> Thinking about this probably the best long term solution is
> to pass optional board_revision in the kernel cmdline that
> can be parsed early and copied to system_rev variable.
> 

Not possible. Our bootloader is closed & proprietary. I tried to 
replace it with u-boot I was not able to do that. So we will use 
that Nokia closed bootloader forever and it can provide data only 
in ATAG structure.

> Or if you can think of some other way to get it, we can set
> system_rev in pdata-quirks.c.
> 
> Or maybe add some code to copy the ATAGs somewhere where
> they are out of the way and don't conflict with the device
> tree data? Then we can query ATAG_REVISION from pdata-quirks.c
> and set system_rev.
> 
> Regards,
> 
> Tony

If we are able to read ATAG from pdata-quirks, then we can parse 
it there and fix problems... But I do not know if address of ATAG 
structure is available there...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/04fc59bf/attachment-0001.sig>
