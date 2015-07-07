From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jul 2015 12:32:13 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
Message-ID: <20150707113213.GC7576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 10:26:13PM +0200, Pali Roh?r wrote:
> Legacy bootloaders can pass additional information for kernel or legacy
> userspace applications. When booting DT kernel then ATAGs structure is not
> more visible after running kernel uncompress code. This patch stores full
> ATAGs structure into DT "/chosen/linux,atags" entry, so kernel can later
> reuse it and export via /proc/atags to userspace.

I think you need to go through your commit messages and improve them,
especially the ones with "TODO" in them.  As long as there's still things
to be done, they're obviously not ready for merging.

Moreover, exporting the ATAGS is questionable, even _if_ there are non-
kexec programs making use of this.  The ATAGs have _never_ been exported
to userspace when kexec disabled is the kernel - it was introduced for
kexec, and has always had this:

config ATAGS_PROC
        bool "Export atags in procfs"
        depends on ATAGS && KEXEC
        default y

Now, the fact that someone decided to start using it is pretty sad,
because it means that if you disable KEXEC, userspace breaks.  That's
not a kernel regression in any shape or form, because /proc/atags has
never been there without KEXEC enabled.  That's a userspace bug, plain
and simple.

Given that, I'm in two minds about whether to accept the last two
patches which make this more than just "for KEXEC use to enable a KEXEC
kernel to be booted."

Had it been provided without the KEXEC conditional, then I don't have
a problem with these two patches.

It also sets a precedent: by adding this into DT, it is creating a new
DT ABI as well, and we'll end up seeing dts files with an ATAG block
patched into them.

Are the ATAGs at a fixed address on the N900?  Can that be handled in
some kind of legacy file for the N900 which calls save_atags() on it, so
we don't end up introducing yet more stuff that we have to maintain into
the distant future?  If not, what about copying a known working atag
structure into a legacy file for the N900?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
