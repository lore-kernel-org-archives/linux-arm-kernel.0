From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 14 Oct 2009 13:05:05 -0400
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
In-Reply-To: <1255509739.32489.123.camel@localhost>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
	<1255260621.16942.38.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7E59@mi8nycmail19.Mi8.com>
	<1255509739.32489.123.camel@localhost>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB8132@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 14, 2009 1:42 AM, Artem Bityutskiy wrote:
> On Sun, 2009-10-11 at 17:19 -0400, H Hartley Sweeten wrote:
>> Update the ts72xx platform's nand driver support.
>>  
>> This changes the ts72xx platform from using a custom nand driver
>> (ts7250.c) to the generic platform nand driver (plat_nand.c).
>>  
>> Tested on TS-7250 with 32MB NAND.
>>  
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Tested-by: Matthieu Crapet <mcrapet@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Artem Bityutskiy <dedekind1@gmail.com>
>> Cc: <linux-arm-kernel@lists.infradead.org>
>> Cc: <linux-mtd@lists.infradead.org>
>> 
>> ---
>> 
>> V2 - rebased to current mtd tree (Artem Bityutskiy)
>> 
>>  arch/arm/mach-ep93xx/ts72xx.c |  177 +++++++++++++++++++++++++++++------------
>>  1 files changed, 125 insertions(+), 52 deletions(-)
>
> Ok, I've tried this patch on both mtd-2.6 and linux-2.6 git trees, and
> it does not apply cleanly.

[snip]

I'm really confused why this does not apply.

My mtd-2.6.git tree is at the same place as yours.

bigguiness at etch:~/src/git/mtd-2.6$ git show
commit 8032747e7680a31cdde293421af62d2e1904c528
Author: David Woodhouse <David.Woodhouse@intel.com>
Date:   Mon Oct 5 08:30:04 2009 +0100

    mtd: make onenand_base.c compile again
    
    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 8935e63..6e250f3 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1051,7 +1051,7 @@ static int onenand_mlc_read_ops_nolock(struct mtd_info *mtd, loff_t from,
        int writesize = this->writesize;
 
        DEBUG(MTD_DEBUG_LEVEL3, "%s: from = 0x%08x, len = %i\n",
-               (unsigned int) from, (int) len);
+             __func__, (unsigned int) from, (int) len);
 
        if (ops->mode == MTD_OOB_AUTO)
                oobsize = this->ecclayout->oobavail;
@@ -2022,8 +2022,8 @@ static int onenand_write_oob_nolock(struct mtd_info *mtd, loff_t to,
        if (unlikely(to >= mtd->size ||
                     column + len > ((mtd->size >> this->page_shift) -
                                     (to >> this->page_shift)) * oobsize)) {
-               printk(KERN_ERR "%s: Attempted to write past end of device\n"
-                       __func__);
+               printk(KERN_ERR "%s: Attempted to write past end of device\n",
+                      __func__);
                return -EINVAL;
        }

If I apply the two patches I get.

bigguiness at etch:~/src/git/mtd-2.6$ patch -p1 < /mnt/hgfs/share/ts72xx_plat_nand_v2.patch 
patching file arch/arm/mach-ep93xx/ts72xx.c
bigguiness@etch:~/src/git/mtd-2.6$ patch -p1 < /mnt/hgfs/share/ts7250_remove_v2.patch 
patching file arch/arm/mach-ep93xx/include/mach/ts72xx.h
patching file drivers/mtd/nand/Kconfig
patching file drivers/mtd/nand/Makefile
patching file drivers/mtd/nand/ts7250.c

I have attached the two patches just in case it's an email issue.

Regards,
Hartley
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ts7250_remove_v2.patch
Type: application/octet-stream
Size: 7973 bytes
Desc: ts7250_remove_v2.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091014/5bf168b2/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ts72xx_plat_nand_v2.patch
Type: application/octet-stream
Size: 6733 bytes
Desc: ts72xx_plat_nand_v2.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091014/5bf168b2/attachment-0003.obj>
