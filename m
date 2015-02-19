From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Feb 2015 08:40:39 +0000
Subject: [PATCH 1/2] regmap: Add range check in _regmap_raw_read()
In-Reply-To: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_bulk_read() ends up using the path that invokes _regmap_raw_read(),
however _regmap_raw_read() never checks if the registers that are accessed
are actually readable or within the accessible range. This results in
kernel crashes when trying to access registers beyond max_registers.

Without this patch I hit below kernel crash:
Unable to handle kernel paging request at virtual address f0167000
pgd = ecea0000
[f0167000] *pgd=ad822811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 739 Comm: cat Tainted: G             L 3.19.0-00008-g1efb3d7-dirty #915
Hardware name: Qualcomm (Flattened Device Tree)
task: ecbbd0c0 ti: ec9fc000 task.ti: ec9fc000
PC is at regmap_mmio_read+0xf8/0x138
LR is at irq_work_queue+0x14/0x98
pc : [<c068ab14>]    lr : [<c02ed970>]    psr: 600f0093
sp : ec9fdd90  ip : 00000001  fp : ec9fddb4
r10: 00001000  r9 : c115a2a8  r8 : edae3940
r7 : edae38c0  r6 : ed9d5000  r5 : 00001000  r4 : 00001000
r3 : f0166000  r2 : 00000007  r1 : 00000000  r0 : 00000019
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5787d  Table: acea006a  DAC: 00000015
Process cat (pid: 739, stack limit = 0xec9fc248)
Stack: (0xec9fdd90 to 0xec9fe000)
dd80:                                     ed9d5000 edacc400 00000000 eda0a210
dda0: 00001000 00001000 ec9fddfc ec9fddb8 c06854d4 c068aa28 00001000 c109f26c
ddc0: c1160148 600f0013 ed9d5000 00001000 ec9fde3c edacc400 00002000 00001000
dde0: 00000001 00001000 00001002 00001000 ec9fde3c ec9fde00 c0685714 c068541c
de00: 00000000 ed9d5000 00000000 00000000 ec9fde3c 00001000 edacc400 00000001
de20: ed9d5000 00001000 00000001 00001000 ec9fde7c ec9fde40 c06858b4 c06855ec
de40: c0e12d3c ec9fde74 ec9fde6c ec9fde58 c0ade1a8 edacc608 00001000 ed9d5000
de60: 00001000 edacc400 00000000 ed9d6000 ec9fdeb4 ec9fde80 c0900ec8 c0685744
de80: 00001000 00000000 ed9d6000 ed9d5000 00000000 00000000 00001000 00000000
dea0: 00001000 00001000 ec9fdef4 ec9fdeb8 c03a9b60 c0900e58 00001000 00000000
dec0: 00001000 0000a46f ec9fdf44 edfb1900 ec9fdf78 ed9d6000 0001c000 00001000
dee0: 00000000 edfb190c ec9fdf2c ec9fdef8 c03a92c0 c03a9b04 00001000 00000000
df00: 00000000 c0b00d70 0001c000 00010000 ec9fdf78 00010000 ec9fc000 0001c000
df20: ec9fdf44 ec9fdf30 c0347024 c03a9230 ec9fdf78 ec823c00 ec9fdf74 ec9fdf48
df40: c03470e4 c0347008 c03624fc c036246c 00001000 00000000 ec823c00 ec823c00
df60: 00010000 0001c000 ec9fdfa4 ec9fdf78 c03471b4 c0347064 00001000 00000000
df80: 00010000 00001000 0001c000 00000003 c020f2e4 00000000 00000000 ec9fdfa8
dfa0: c020f140 c0347174 00010000 00001000 00000003 0001c000 00010000 0001c000
dfc0: 00010000 00001000 0001c000 00000003 7fffe000 00000001 00000000 00000000
dfe0: 00000000 bef1e5bc 0000b649 b6f29916 600f0030 00000003 00000000 00000000
[<c068ab14>] (regmap_mmio_read) from [<c06854d4>] (_regmap_raw_read+0xc4/0x1d0)
[<c06854d4>] (_regmap_raw_read) from [<c0685714>] (regmap_raw_read+0x134/0x158)
[<c0685714>] (regmap_raw_read) from [<c06858b4>] (regmap_bulk_read+0x17c/0x1c4)
[<c06858b4>] (regmap_bulk_read) from [<c0900ec8>] (bin_attr_eeprom_read+0x7c/0xb4)
[<c0900ec8>] (bin_attr_eeprom_read) from [<c03a9b60>] (sysfs_kf_bin_read+0x68/0xa0)
[<c03a9b60>] (sysfs_kf_bin_read) from [<c03a92c0>] (kernfs_fop_read+0x9c/0x16c)
[<c03a92c0>] (kernfs_fop_read) from [<c0347024>] (__vfs_read+0x28/0x5c)
[<c0347024>] (__vfs_read) from [<c03470e4>] (vfs_read+0x8c/0x110)
[<c03470e4>] (vfs_read) from [<c03471b4>] (SyS_read+0x4c/0x98)
[<c03471b4>] (SyS_read) from [<c020f140>] (ret_fast_syscall+0x0/0x34)
Code: eb091d03 e3a00000 e89da9f8 e5973000 (e7d32004)

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d2f8a81..d480e49 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2036,10 +2036,15 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 {
 	struct regmap_range_node *range;
 	u8 *u8 = map->work_buf;
-	int ret;
+	int ret, i, count = val_len/map->format.val_bytes;
 
 	WARN_ON(!map->bus);
 
+	/* Check for readable registers before we start */
+	for (i = 0; i < count; i++)
+		if (!regmap_readable(map, reg + (i * map->reg_stride)))
+			return -EINVAL;
+
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
 		ret = _regmap_select_page(map, &reg, range,
-- 
1.9.1
