From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 27 Nov 2014 00:25:53 +0100
Subject: n900: kernel cmdline from bootloader in DT mode
In-Reply-To: <20141126152159.GA26123@amd>
References: <201411261354.33652@pali> <201411261436.42166@pali>
 <20141126152159.GA26123@amd>
Message-ID: <201411270025.53559@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 16:22:00 Pavel Machek wrote:
> On Wed 2014-11-26 14:36:42, Pali Roh?r wrote:
> > On Wednesday 26 November 2014 14:28:01 Pavel Machek wrote:
> > > Hi!
> > > 
> > > > for some unknown reasons when I compile kernel for n900
> > > > in DT mode it ignore cmdline passed by bootloader. When
> > > > I comment
> > > > 
> > > > CONFIG_ARM_APPENDED_DTB=y
> > > > 
> > > > then it boots into legacy board mode and cmdline is used
> > > > from bootloader.
> > > > 
> > > > When is problem?
> > > 
> > > It seems to work for me, I'm booting using 0xffff, with
> > > attached config.
> > > 
> > > 									Pavel
> > 
> > Can you try to set some "root=something" into CONFIG_CMDLINE
> > and then add real "root=" param via 0xffff?
> > 
> > My problem is that I have specified ubifs mtd root in
> > CONFIG_CMDLINE and when I set correct root via bootloader
> > (from 0xffff or flasher-3.5) it is ignored and used only
> > what is specified in CONFIG_CMDLINE.
> 
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> # CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> CONFIG_CMDLINE="console=ttyO2,115200 console=tty"
> 
> Um.. Internal commandline should be completely ignored for me.
> 
> Do you have
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER?
> 
> 									Pavel

Can you try to set:

CONFIG_USE_OF=y
CONFIG_ATAGS=y
# CONFIG_DEPRECATED_PARAM_STRUCT is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs 
rootflags=bulk_read,no_chk_data_crc rw mtdoops.mtddev=log console=tty0 console=ttyO2 omapfb_vram=7M 
omapfb.mode=lcd:848x480-16 nokia-modem.pm=0"
CONFIG_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_CMDLINE_EXTEND is not set
# CONFIG_CMDLINE_FORCE is not set
CONFIG_KEXEC=y
CONFIG_ATAGS_PROC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=y

and then boot kernel 3.18-rc6 with cmdline specified in bootloader?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/e43e8630/attachment.sig>
