From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 16 Dec 2016 12:46:12 +0100
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <201612150109.20868@pali>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <20161214235224.GH14217@n2100.armlinux.org.uk> <201612150109.20868@pali>
Message-ID: <201612161246.12155@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 December 2016 01:09:20 Pali Roh?r wrote:
> On Thursday 15 December 2016 00:52:24 Russell King - ARM Linux wrote:
> > On Wed, Dec 14, 2016 at 10:12:43PM +0100, Pali Roh?r wrote:
> > > Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi
> > > usage") broke support for setting cmdline on Nokia N900 via
> > > CONFIG_CMDLINE.
> > > 
> > > It is because arm code booted in DT mode parse cmdline only via
> > > function early_init_dt_scan_chosen() and that function does not
> > > fill variable boot_command_line when DTB does not contain /chosen
> > > entry. It is called from function early_init_dt_scan_nodes() in
> > > setup_machine_fdt().
> > > 
> > > This patch fixes it by explicitly filling boot_command_line in
> > > function setup_machine_fdt() after calling
> > > early_init_dt_scan_nodes() in case boot_command_line still
> > > remains empty.
> > 
> > This looks like a hack.
> > 
> > First, the matter of the ATAGs compatibility.  The decompressor
> > relies on there being a pre-existing /chosen node to insert the
> > command line and other parameters into.  If we've dropped it (by
> > dropping skeleton.dtsi) then we've just regressed more than just
> > N900 - the decompressor won't be able to merge the ATAGs into the
> > concatenated FDT.
> 
> Hm... I did not think about it. But right this can be broken too...

Tony, Javier: are you aware of above ??? problem?

It looks like commit 008a2ebcd677 ("ARM: dts: omap3: Remove 
skeleton.dtsi usage") should be really reverted.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161216/cf408722/attachment.sig>
