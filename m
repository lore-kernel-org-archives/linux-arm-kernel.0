From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 20 Oct 2009 13:34:24 +0800
Subject: Ext3 is supported not well at 2.6.28 for external SD card	removal
In-Reply-To: <20091019150321.GE13614@n2100.arm.linux.org.uk>
References: <200910190759.11591.marek.vasut@gmail.com>	<4ADBFB5B.9030200@gmail.com>	<28376653.255741255932756974.JavaMail.coremail@bj126app18.126.com>
	<20091019150321.GE13614@n2100.arm.linux.org.uk>
Message-ID: <4ADD4BE0.7050806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Oct 19, 2009 at 02:12:36PM +0800, tommy.hong wrote:
>> hi,you can try EXT4!ext3 is not stable in arm,one of my friends need
>> some ext3 bug in 2.6.25,can cause system halt!
> 
> ext3 works fine - it's been used on the old mailing list server for its
> filesystems for hundreds of days (on that exact kernel version) without
> issue.
> 
> It's also being used on the web server and older web server both without
> any incident.
> 
> All aforementioned machines are ARM based.  I can only assume that you
> have local (unreported) issues with ext3 on ARM.
> 
The problem I found was removing SD card with ext3 without unmount, It 
is ok at 2.6.27 and 2.6.23, but bad at 2.6.28 ( or later, I am not sure).

The problems with ext3 partitioned are:
1. We remove the SD card after the system go to suspend, then, after the 
system resume. The system is go to deadlock at __fsync_super: the call
stack like below:
mmc_remove_card-->device_del-->mmc_blk_remove-->del_gendisk

2. When removing SD card without unmount during the system is running, 
there are below errors:
mmc1: card d555 removed
mmcblk2: error -110 sending read/write command
mmcblk2: error -110 requesting status
end_request: I/O error, dev mmcblk2, sector 1576855
Buffer I/O error on device mmcblk2p1, logical block 197099
lost page write due to I/O error on mmcblk2p1
mmcblk2: error -110 sending read/write command
mmcblk2: error -110 requesting status
end_request: I/O error, dev mmcblk2, sector 1576863
Buffer I/O error on device mmcblk2p1, logical block 197100
lost page write due to I/O error on mmcblk2p1
Aborting journal on device mmcblk2p1.
------------[ cut here ]------------
WARNING: at 
/home/nchen/work/L28EVB/Dev/sirfa5cb_l28_alpha/kernel/fs/buffer.c:1195 
mark_buffer_dirty+0x9c/0xb8()
Modules linked in: sirfsoc_wdt sirfsoc_uspserial g_ether g_usbdrv 
ehci_hcd usbcore snd_soc_cb_modac_ts snd_soc_modac snd_soc_sirfsoc_i2s snd_s
oc_ts_stream_mode snd_soc_sirfsoc snd_soc_core snd_pcm snd_timer snd 
soundcore snd_page_alloc sirfsoc_bl sirfsoc_fb cfbcopyarea cfbimgblt cfbf
illrect
[<c008a8d8>] (dump_stack+0x0/0x14) from [<c009edfc>] 
(warn_on_slowpath+0x4c/0x68)
[<c009edb0>] (warn_on_slowpath+0x0/0x68) from [<c011c1b0>] 
(mark_buffer_dirty+0x9c/0xb8)
  r6:c0ad1000 r5:c0340970 r4:c349b7f0
[<c011c114>] (mark_buffer_dirty+0x0/0xb8) from [<c015b84c>] 
(journal_update_superblock+0xcc/0x14c)
  r5:c3a319c0 r4:c38da000
[<c015b780>] (journal_update_superblock+0x0/0x14c) from [<c015ba84>] 
(__journal_abort_soft+0xc8/0xd8)
  r7:c38da000 r6:fffffffb r5:c3a319c0 r4:c38da000
[<c015b9bc>] (__journal_abort_soft+0x0/0xd8) from [<c015baa4>] 
(journal_abort+0x10/0x14)
  r6:c3493860 r5:fffffffb r4:c349b748
[<c015ba94>] (journal_abort+0x0/0x14) from [<c0158324>] 
(journal_commit_transaction+0xa64/0x14a0)
[<c01578c0>] (journal_commit_transaction+0x0/0x14a0) from [<c015c6d8>] 
(kjournald+0xc4/0x29c)
[<c015c614>] (kjournald+0x0/0x29c) from [<c00b5818>] (kthread+0x54/0x80)
[<c00b57c4>] (kthread+0x0/0x80) from [<c00a1ec8>] (do_exit+0x0/0x818)
  r5:00000000 r4:00000000
---[ end trace 494b15a74f793f7d ]---
mmcblk2: error -110 sending read/write command
mmcblk2: error -110 requesting status
end_request: I/O error, dev mmcblk2, sector 1576855
Buffer I/O error on device mmcblk2p1, logical block 197099
lost page write due to I/O error on mmcblk2p1
journal commit I/O error
ext3_abort called.
EXT3-fs error (device mmcblk2p1): ext3_put_super: Couldn't clean up the 
journal
Remounting filesystem read-only

The above two problems weren't happened at 2.6.27/23 kernel, and with 
vfat partition.

I wonder such two operations are forbidden for ext3 , especially after 
2.6.27 or there is something wrong with our code?

Thank you!

_______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Best regards,
Peter Chen
