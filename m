From: stefan@agner.ch (Stefan Agner)
Date: Sun, 01 Mar 2015 01:38:15 +0100
Subject: [RFC 2/5] =?UTF-8?Q?mtd=3Afsl=5Fnfc=3A=20Add=20hardware=20=34?=
 =?UTF-8?Q?=35=20byte=20BHC-ECC=20support=20for=20=32=34=20bit=20correctio?=
 =?UTF-8?Q?ns=2E?=
In-Reply-To: <8761dit9u9.fsf@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch> <87r3zaxgtr.fsf@nbsps.com>
 <c444059de888a661fadf3d6be598a98d@agner.ch> <87lhphyjkg.fsf@nbsps.com>
 <0bc8cec13bcf5b9cbea9cd3345815e4a@agner.ch> <8761dit9u9.fsf@nbsps.com>
Message-ID: <f3bc6eda0c826601e136f3dad91d9674@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-11 17:44, Bill Pringlemeir wrote:
>>>>> On 17 Sep 2014, stefan at agner.ch wrote:
> 
>>>> Yes, we are using Macronix SLC NAND.
> 
>>>>> On 17 Sep 2014, stefan at agner.ch wrote:
> 
>>>> This is a new device, but its one out of several dozens. The device
>>>> had two factory marked bad page. This four page would then be 6 bad
>>>> pages. I would say that your guess is probably the case at hand
>>>> (should be considered bad, but were marked by factory).
> 
> On 10 Dec 2014, stefan at agner.ch wrote:
> 
>> What I currently did, is just accept strength / 2 bits. This is not a
>> clean solution since it will also count the ECC bits, but it works for
>> now:
>> --- a/drivers/mtd/nand/fsl_nfc.c
>> +++ b/drivers/mtd/nand/fsl_nfc.c
>> @@ -524,7 +524,7 @@ static int nfc_correct_data(struct mtd_info *mtd,
>> u_char *dat,
>> flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
>>
>> /* ECC failed. */
>> -       if (flip > ecc_count)
>> +       if (flip > ecc_count && flip > (nfc->chip.ecc.strength / 2))
>> return -1;
>>
>> /* Erased page. */
> 
>> I think we are facing multiple issues here. One might contain general
>> software/hardware issues (non bit-flip related). I had this issue
>> again on a different module with 3.18-rc5 (without the "fix"
>> above). The kernel output looks like this:
> 
> [snip]
> 
>> Interesting is that this error happens every second PEB (every 128
>> page, but erase block size is 64) and it is always the second page. On
>> that device, this is completely reproduceable, e.g. I can erase
>> everything and flash it again, the same happens.
> 
>> I dumped the block in question:
> 
>> Page 00240800 dump:
>> ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> ....
>> ff ff ff ff ff ff ff ff  f7 ff ff ff ff ff ff ff
>> ....
>> ff ff ff ff ff ff ff ff  ff ff fb ff ff ff ff ff
>> ....
>> ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff f7
>> ....
> 
>> I also printed flip count and ecc_count the values for all those pages
>> are: flip 3, ecc_count 2
> 
>> Now the interesting part: When I erase the block, and dump that page
>> again, it is completely empty! No flips, no ecc_count anymore! UBI
>> attach writes something into the first page, hence it looks like this
>> write into the first page influences the values of the second
>> page... I verified this behavior this using U-Boot and the Linux
>> kernel.
> 
>> I digged a bit deeper, and wrote just zeros into the first page. In
>> the second page some bits are flipped. However, writing into the
>> second page does not influence the third page. But a bit in the first
>> page is flipped. And the third page influences the forth page. It
>> looks like the pages behave in pairs.... Any idea what kind of issue
>> we are facing here?
> 
> Hmm.  It sounds like MLC flash, but you say you have SLC.  It could be
> that some bus signalling is marginal?  Could you reduce the clocks a bit
> on this device and see if the behaviour changes?  I am pretty sure that
> stuck-at-zero errors will stay that way.
> 
> I would love to get back to this controller code to fix some issues you
> noted and bring in the changes to the u-boot review.  Unfortunately, I
> keep getting stuck with legacy hw issues.
> 
> fwiw,
> Bill.

Hi Bill,

The flash chip mentioned above requires 8-bit error correction per 512
byte block, hence I increased the ECC to the maximum available level
(60-byte ECC, see page below). One thing which is not very nice, in
order to fit the 60-byte ECC into the 64-byte OOB, I had to shorten the
BBT pattern and set it at the very beginning of the page. This works
fine, however this basically sets the page also to factory bad, I'm not
sure if this is ok? Otherwise, we also could use a BBT pattern of length
1 (used by cafe_nand.c too).

What do you think? I would like to respin the NFC patch, with my U-Boot
changes and this change included...

--
Stefan

diff --git a/drivers/mtd/nand/fsl_nfc.c b/drivers/mtd/nand/fsl_nfc.c
index bfc7b7b..3d6da80 100644
--- a/drivers/mtd/nand/fsl_nfc.c
+++ b/drivers/mtd/nand/fsl_nfc.c
@@ -70,6 +70,7 @@
 /* NFC ECC mode define */
 #define ECC_BYPASS                     0
 #define ECC_45_BYTE                    6
+#define ECC_60_BYTE                    7
 
 /*** Register Mask and bit definitions */
 
@@ -155,15 +156,15 @@ struct fsl_nfc {
 };
 #define mtd_to_nfc(_mtd) container_of(_mtd, struct fsl_nfc, mtd)
 
-static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
-static u8 mirror_pattern[] = {'1', 't', 'b', 'B' };
+static u8 bbt_pattern[] = {'B', 'b', 't' };
+static u8 mirror_pattern[] = {'t', 'b', 'B' };
 
 static struct nand_bbt_descr bbt_main_descr = {
        .options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
|
                   NAND_BBT_2BIT | NAND_BBT_VERSION,
-       .offs = 11,
-       .len = 4,
-       .veroffs = 15,
+       .offs = 0,
+       .len = 3,
+       .veroffs = 3,
        .maxblocks = 4,
        .pattern = bbt_pattern,
 };
@@ -171,9 +172,9 @@ static struct nand_bbt_descr bbt_main_descr = {
 static struct nand_bbt_descr bbt_mirror_descr = {
        .options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
|
                   NAND_BBT_2BIT | NAND_BBT_VERSION,
-       .offs = 11,
-       .len = 4,
-       .veroffs = 15,
+       .offs = 0,
+       .len = 3,
+       .veroffs = 3,
        .maxblocks = 4,
        .pattern = mirror_pattern,
 };
@@ -191,6 +192,21 @@ static struct nand_ecclayout nfc_ecc45 = {
                 .length = 11} }
 };
 
+static struct nand_ecclayout nfc_ecc60 = {
+       .eccbytes = 60,
+       .eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
+                  12, 13, 14, 15, 16, 17, 18, 19,
+                  20, 21, 22, 23, 24, 25, 26, 27,
+                  28, 29, 30, 31, 32, 33, 34, 35,
+                  36, 37, 38, 39, 40, 41, 42, 43,
+                  44, 45, 46, 47, 48, 49, 50, 51,
diff --git a/drivers/mtd/nand/fsl_nfc.c b/drivers/mtd/nand/fsl_nfc.c
index bfc7b7b..3d6da80 100644
--- a/drivers/mtd/nand/fsl_nfc.c
+++ b/drivers/mtd/nand/fsl_nfc.c
@@ -70,6 +70,7 @@
 /* NFC ECC mode define */
 #define ECC_BYPASS                     0
 #define ECC_45_BYTE                    6
+#define ECC_60_BYTE                    7
 
 /*** Register Mask and bit definitions */
 
@@ -155,15 +156,15 @@ struct fsl_nfc {
 };
 #define mtd_to_nfc(_mtd) container_of(_mtd, struct fsl_nfc, mtd)
 
-static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
-static u8 mirror_pattern[] = {'1', 't', 'b', 'B' };
+static u8 bbt_pattern[] = {'B', 'b', 't' };
+static u8 mirror_pattern[] = {'t', 'b', 'B' };
 
 static struct nand_bbt_descr bbt_main_descr = {
        .options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
|
                   NAND_BBT_2BIT | NAND_BBT_VERSION,
-       .offs = 11,
-       .len = 4,
-       .veroffs = 15,
+       .offs = 0,
+       .len = 3,
+       .veroffs = 3,
        .maxblocks = 4,
        .pattern = bbt_pattern,
 };
@@ -171,9 +172,9 @@ static struct nand_bbt_descr bbt_main_descr = {
 static struct nand_bbt_descr bbt_mirror_descr = {
        .options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
|
                   NAND_BBT_2BIT | NAND_BBT_VERSION,
-       .offs = 11,
-       .len = 4,
-       .veroffs = 15,
+       .offs = 0,
+       .len = 3,
+       .veroffs = 3,
        .maxblocks = 4,
        .pattern = mirror_pattern,
 };
@@ -191,6 +192,21 @@ static struct nand_ecclayout nfc_ecc45 = {
                 .length = 11} }
 };
 
+static struct nand_ecclayout nfc_ecc60 = {
+       .eccbytes = 60,
+       .eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
+                  12, 13, 14, 15, 16, 17, 18, 19,
+                  20, 21, 22, 23, 24, 25, 26, 27,
+                  28, 29, 30, 31, 32, 33, 34, 35,
+                  36, 37, 38, 39, 40, 41, 42, 43,
+                  44, 45, 46, 47, 48, 49, 50, 51,
+                  52, 53, 54, 55, 56, 57, 58, 59,
+                  60, 61, 62, 63 },
+       .oobfree = {
+               {.offset = 2,
+                .length = 2} }
+};
+
 static u32 nfc_read(struct mtd_info *mtd, uint reg)
 {
        struct fsl_nfc *nfc = mtd_to_nfc(mtd);
@@ -608,10 +624,10 @@ static int nfc_init_controller(struct mtd_info
*mtd, struct nfc_config *cfg, int
        nfc_write(mtd, NFC_SECTOR_SIZE, page_sz);
 
        if (cfg->hardware_ecc) {
-               /* set ECC mode to 45 bytes OOB with 24 bits correction
*/
+               /* set ECC mode to 60 bytes OOB with 32 bits correction
*/
                nfc_set_field(mtd, NFC_FLASH_CONFIG,
                                CONFIG_ECC_MODE_MASK,
-                               CONFIG_ECC_MODE_SHIFT, ECC_45_BYTE);
+                               CONFIG_ECC_MODE_SHIFT, ECC_60_BYTE);
 
                /* Enable ECC_STATUS */
                nfc_set(mtd, NFC_FLASH_CONFIG, CONFIG_ECC_SRAM_REQ_BIT);
@@ -742,7 +758,7 @@ static int nfc_probe(struct platform_device *pdev)
                        goto error;
                }
 
-               chip->ecc.layout = &nfc_ecc45;
+               chip->ecc.layout = &nfc_ecc60;
 
                /* propagate ecc.layout to mtd_info */
                mtd->ecclayout = chip->ecc.layout;
@@ -751,14 +767,14 @@ static int nfc_probe(struct platform_device *pdev)
                chip->ecc.correct = nfc_correct_data;
                chip->ecc.mode = NAND_ECC_HW;
 
-               chip->ecc.bytes = 45;
+               chip->ecc.bytes = 60;
                chip->ecc.size = PAGE_2K;
-               chip->ecc.strength = 24;
+               chip->ecc.strength = 32;
 
-               /* set ECC mode to 45 bytes OOB with 24 bits correction
*/
+               /* set ECC mode to 60 bytes OOB with 32 bits correction
*/
                nfc_set_field(mtd, NFC_FLASH_CONFIG,
                                CONFIG_ECC_MODE_MASK,
-                               CONFIG_ECC_MODE_SHIFT, ECC_45_BYTE);
+                               CONFIG_ECC_MODE_SHIFT, ECC_60_BYTE);
        }
 
        /* second phase scan */
