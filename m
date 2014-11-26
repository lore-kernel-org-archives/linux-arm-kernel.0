From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 27 Nov 2014 00:38:01 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141126231435.GQ2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411270001.44871@pali>
 <20141126231435.GQ2817@atomide.com>
Message-ID: <201411270038.01312@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 00:14:36 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141126 15:03]:
> > On Wednesday 26 November 2014 21:08:06 Tony Lindgren wrote:
> > 
> > With your patch I'm getting:
> > 
> > Hardware        : Nokia RX-51 board
> > 
> > So patch is good.
> 
> Is that a Tested-by: then? :)
> 

Yes for Hardware line you can add my:

Tested-by: Pali Roh?r <pali.rohar@gmail.com>

> > > > Revision comes from bootloader (via ATAG) and it is HW
> > > > revision of N900 device. It cannot be hardcoded into
> > > > kernel or DTS as it it depends on HW.
> > > 
> > > Well for the "Revision" line problem, we could pass the
> > > revision in cmdline or .dts if not passed in the legacy
> > > ATAGs. It sounds like were just not copying it to
> > > system_rev for DT based booting? Maybe it's just some
> > > missing CONFIG_ATAG option that needs to be enabled?
> > 
> > Yes it looks like DT code does not read Revision ATAG... I
> > tried to enable everything but always same problem...
> 
> Maybe check if it shows up properly in /proc/atags or whatever
> the interface for it was?
> 

With enabled CONFIG_ARM_APPENDED_DTB=y file /proc/atags is 
missing.

> The build_tag_list() should parse ATAG_REVISION and then
> parse_tag_revision() should copy it to system_rev. Maybe try
> adding some printks to see if those functions get called?
> 
> Regards,
> 
> Tony

Now I see... Problem is that build_tag_list() is called from 
convert_to_tag_list() which is called from setup_machine_tags() 
which is called from setup_arch() only if setup_machine_fdt() 
call fails. And it fails for *non* DT boot. You can check this 
chain too.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/c8e39090/attachment.sig>
