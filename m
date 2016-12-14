From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Dec 2016 23:52:24 +0000
Subject: [PATCH] arm: dt: Initialize boot_command_line from
 CONFIG_CMDLINE in case DT does not provide /chosen/bootargs
In-Reply-To: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20161214235224.GH14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 10:12:43PM +0100, Pali Roh?r wrote:
> Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage") broke
> support for setting cmdline on Nokia N900 via CONFIG_CMDLINE.
> 
> It is because arm code booted in DT mode parse cmdline only via function
> early_init_dt_scan_chosen() and that function does not fill variable
> boot_command_line when DTB does not contain /chosen entry. It is called
> from function early_init_dt_scan_nodes() in setup_machine_fdt().
> 
> This patch fixes it by explicitly filling boot_command_line in function
> setup_machine_fdt() after calling early_init_dt_scan_nodes() in case
> boot_command_line still remains empty.

This looks like a hack.

First, the matter of the ATAGs compatibility.  The decompressor relies on
there being a pre-existing /chosen node to insert the command line and
other parameters into.  If we've dropped it (by dropping skeleton.dtsi)
then we've just regressed more than just N900 - the decompressor won't
be able to merge the ATAGs into the concatenated FDT.

Second, CONFIG_CMDLINE has never been in place on DT systems - it's
something atags_parse.c has been dealing with which isn't involved on
DT.  For DT, we expect the command line to be passed in.

Now, given that, I find your commit message rather fishy.  You seem to
be claiming that CONFIG_CMDLINE used to work, but the fact is, we've
never had it working on device tree systems.

Instead, what I think was going on is that the bug you're seeing is
that the removal of skeleton.dtsi results in the /chosen node being
absent, which in turn prevents the decompressor picking the various
parameters out of the ATAGs and dropping them into the DT blob.

That, to me, sounds like a regression, and the fix is not to hack
support for an unrelated feature, but to fix the original problem -
and I think in this case, it's reasonable to ask for the offending
commit to be reverted.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
