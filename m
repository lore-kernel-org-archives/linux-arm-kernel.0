From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 15 Dec 2016 01:09:20 +0100
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <20161214235224.GH14217@n2100.armlinux.org.uk>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <20161214235224.GH14217@n2100.armlinux.org.uk>
Message-ID: <201612150109.20868@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 December 2016 00:52:24 Russell King - ARM Linux wrote:
> On Wed, Dec 14, 2016 at 10:12:43PM +0100, Pali Roh?r wrote:
> > Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
> > broke support for setting cmdline on Nokia N900 via
> > CONFIG_CMDLINE.
> > 
> > It is because arm code booted in DT mode parse cmdline only via
> > function early_init_dt_scan_chosen() and that function does not
> > fill variable boot_command_line when DTB does not contain /chosen
> > entry. It is called from function early_init_dt_scan_nodes() in
> > setup_machine_fdt().
> > 
> > This patch fixes it by explicitly filling boot_command_line in
> > function setup_machine_fdt() after calling
> > early_init_dt_scan_nodes() in case boot_command_line still remains
> > empty.
> 
> This looks like a hack.
> 
> First, the matter of the ATAGs compatibility.  The decompressor
> relies on there being a pre-existing /chosen node to insert the
> command line and other parameters into.  If we've dropped it (by
> dropping skeleton.dtsi) then we've just regressed more than just
> N900 - the decompressor won't be able to merge the ATAGs into the
> concatenated FDT.

Hm... I did not think about it. But right this can be broken too...

> Second, CONFIG_CMDLINE has never been in place on DT systems - it's
> something atags_parse.c has been dealing with which isn't involved on
> DT.  For DT, we expect the command line to be passed in.

If cmdline is not in DT, but /chosen exists, then function 
early_init_dt_scan_chosen() use cmdline from CONFIG_CMDLINE.

> Now, given that, I find your commit message rather fishy.  You seem
> to be claiming that CONFIG_CMDLINE used to work, but the fact is,
> we've never had it working on device tree systems.

Looks like that CONFIG_CMDLINE really did not worked (correctly) on DT 
booted systems... We have already discussed about it on #armlinux

> Instead, what I think was going on is that the bug you're seeing is
> that the removal of skeleton.dtsi results in the /chosen node being
> absent, which in turn prevents the decompressor picking the various
> parameters out of the ATAGs and dropping them into the DT blob.

In my case, bootloader did not provided any cmdline in ATAG, so 
decompressor did not parsed any cmdline...

> That, to me, sounds like a regression, and the fix is not to hack
> support for an unrelated feature, but to fix the original problem -
> and I think in this case, it's reasonable to ask for the offending
> commit to be reverted.

I will let decision to others, who created and accepted that patch 
008a2ebcd677. What I need is working CONFIG_CMDLINE as I had it before 
as bootloader for Nokia N900 does not pass any cmdline -- and without it 
I cannot boot userspace.

But still, I would like to see working CONFIG_CMDLINE support for DT 
systems. Other systems (e.g. arm ATAG based or x86) have it.

What is reason that CONFIG_CMDLINE is not supported for DT?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/19624c67/attachment-0001.sig>
