From: drinkcat@chromium.org (Nicolas Boichat)
Date: Tue,  4 Aug 2015 14:09:56 +0800
Subject: [PATCH 1/3] spi: bitbang: Replace spinlock by mutex when calling
 chipselect
Message-ID: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling CONFIG_DEBUG_ATOMIC_SLEEP in kernel configuration, we get
this warning in spi_gpio_setup:
[    1.177747] BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:1431
[    1.190182] in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
[    1.196922] 3 locks held by swapper/0/1:
[    1.200812]  #0:  (&dev->mutex){......}, at: [<ffffffc00051db78>] __driver_attach+0x58/0x98
[    1.209147]  #1:  (spi_add_lock){+.+.+.}, at: [<ffffffc000578164>] spi_add_device+0x80/0x14c
[    1.217564]  #2:  (&(&bitbang->lock)->rlock){......}, at: [<ffffffc00057b054>] spi_bitbang_setup+0x84/0xc4
[    1.227185] irq event stamp: 279856
[    1.230645] hardirqs last  enabled at (279855): [<ffffffc0007cce70>] __mutex_unlock_slowpath+0x158/0x16c
[    1.240070] hardirqs last disabled at (279856): [<ffffffc0007cead0>] _raw_spin_lock_irqsave+0x20/0x6c
[    1.249233] softirqs last  enabled at (262072): [<ffffffc0002f0954>] bdi_register+0x124/0x1d0
[    1.257707] softirqs last disabled at (262070): [<ffffffc0002f0930>] bdi_register+0x100/0x1d0
[    1.266185] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 3.18.0 #608
[    1.277419] Call trace:
[    1.279848] [<ffffffc000208754>] dump_backtrace+0x0/0x12c
[    1.285209] [<ffffffc000208890>] show_stack+0x10/0x1c
[    1.290223] [<ffffffc0007c897c>] dump_stack+0x80/0xb4
[    1.295238] [<ffffffc000244248>] __might_sleep+0x110/0x11c
[    1.300687] [<ffffffc0004722d4>] gpiod_set_raw_value_cansleep+0x24/0x4c
[    1.307255] [<ffffffc00057b464>] spi_gpio_chipselect+0x74/0x88
[    1.313045] [<ffffffc00057b068>] spi_bitbang_setup+0x98/0xc4
[    1.318664] [<ffffffc00057bb44>] spi_gpio_setup+0x50/0xc8
[    1.324022] [<ffffffc0005780d0>] spi_setup+0xe4/0xf8
[    1.328950] [<ffffffc0005781b4>] spi_add_device+0xd0/0x14c
[    1.334396] [<ffffffc000579ba8>] spi_register_master+0x6a8/0x718
[    1.340359] [<ffffffc00057b358>] spi_bitbang_start+0xe8/0x108
[    1.346064] [<ffffffc00057bf70>] spi_gpio_probe+0x3b4/0x448
[    1.351595] [<ffffffc00051f65c>] platform_drv_probe+0x4c/0x9c
[    1.357301] [<ffffffc00051d930>] driver_probe_device+0xd4/0x23c
[    1.363180] [<ffffffc00051db88>] __driver_attach+0x68/0x98
[    1.368627] [<ffffffc00051ca30>] bus_for_each_dev+0x7c/0xb0
[    1.374160] [<ffffffc00051d4bc>] driver_attach+0x1c/0x28
[    1.379434] [<ffffffc00051d07c>] bus_add_driver+0xd8/0x1e0
[    1.384881] [<ffffffc00051e654>] driver_register+0xbc/0x10c
[    1.390412] [<ffffffc00051f58c>] __platform_driver_register+0x5c/0x68
[    1.396808] [<ffffffc000c28584>] spi_gpio_driver_init+0x14/0x20
[    1.402685] [<ffffffc000200a04>] do_one_initcall+0x18c/0x1ac
[    1.408306] [<ffffffc000c00c64>] kernel_init_freeable+0x228/0x2e0
[    1.414356] [<ffffffc0007c5f60>] kernel_init+0x10/0xd8

chipselect (in this case, spi_gpio_chipselect, which calls
gpiod_set_raw_value_cansleep), can sleep, so we should not hold
a spinlock while calling it.

This issue was introduced by this commit, which converted spi-gpio
to cansleep variants:
d9dda5a191 "spi: spi-gpio: Use 'cansleep' variants to access GPIO"

Replace spinlock + busy variable by a mutex, and get rid of
spi_bitbang_prepare_hardware and spi_bitbang_unprepare_hardware,
which are not useful anymore.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Actually, I'm not sure if I understand the existing code: why are we not
waiting for busy to go down to 0, then call chipselect, instead of not calling
it at all if the bus happens to be busy when we setup the device? With the
current approach, it would be easy to just use an unconditional mutex_lock.

Also, is it harmful to deactivate the newly setup device in spi_bitbang_setup,
even if the bus is busy with another device? chipselect should be independent
for each device (or is it not?). So I'm not clear why we need any locking at
all...

Hopefully someone can shine some light on this...

Anyway, this patch series does not change the existing behaviour, applies on
top of broonie-sound/for-next, and, along with the 2 follow-up patches, was
compile-tested on x86-64/arm (allyesconfig) and ppc44x (defconfig+SPI driver),
and runtime-tested on an arm platform.

 drivers/spi/spi-bitbang.c       | 42 +++++++----------------------------------
 include/linux/spi/spi_bitbang.h |  3 +--
 2 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 840a498..931c37e 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -180,7 +180,6 @@ int spi_bitbang_setup(struct spi_device *spi)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	struct spi_bitbang	*bitbang;
-	unsigned long		flags;
 
 	bitbang = spi_master_get_devdata(spi->master);
 
@@ -210,12 +209,11 @@ int spi_bitbang_setup(struct spi_device *spi)
 	 */
 
 	/* deselect chip (low or high) */
-	spin_lock_irqsave(&bitbang->lock, flags);
-	if (!bitbang->busy) {
+	if (mutex_trylock(&bitbang->lock)) {
 		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
 		ndelay(cs->nsecs);
+		mutex_unlock(&bitbang->lock);
 	}
-	spin_unlock_irqrestore(&bitbang->lock, flags);
 
 	return 0;
 }
@@ -252,20 +250,6 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
  * transfer-at-a-time ones to leverage dma or fifo hardware.
  */
 
-static int spi_bitbang_prepare_hardware(struct spi_master *spi)
-{
-	struct spi_bitbang	*bitbang;
-	unsigned long		flags;
-
-	bitbang = spi_master_get_devdata(spi);
-
-	spin_lock_irqsave(&bitbang->lock, flags);
-	bitbang->busy = 1;
-	spin_unlock_irqrestore(&bitbang->lock, flags);
-
-	return 0;
-}
-
 static int spi_bitbang_transfer_one(struct spi_master *master,
 				    struct spi_message *m)
 {
@@ -279,6 +263,8 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 
 	bitbang = spi_master_get_devdata(master);
 
+	mutex_lock(&bitbang->lock);
+
 	/* FIXME this is made-up ... the correct value is known to
 	 * word-at-a-time bitbang code, and presumably chipselect()
 	 * should enforce these requirements too?
@@ -372,21 +358,9 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 
 	spi_finalize_current_message(master);
 
-	return status;
-}
-
-static int spi_bitbang_unprepare_hardware(struct spi_master *spi)
-{
-	struct spi_bitbang	*bitbang;
-	unsigned long		flags;
+	mutex_unlock(&bitbang->lock);
 
-	bitbang = spi_master_get_devdata(spi);
-
-	spin_lock_irqsave(&bitbang->lock, flags);
-	bitbang->busy = 0;
-	spin_unlock_irqrestore(&bitbang->lock, flags);
-
-	return 0;
+	return status;
 }
 
 /*----------------------------------------------------------------------*/
@@ -427,7 +401,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	if (!master || !bitbang->chipselect)
 		return -EINVAL;
 
-	spin_lock_init(&bitbang->lock);
+	mutex_init(&bitbang->lock);
 
 	if (!master->mode_bits)
 		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
@@ -435,8 +409,6 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	if (master->transfer || master->transfer_one_message)
 		return -EINVAL;
 
-	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
-	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
 	master->transfer_one_message = spi_bitbang_transfer_one;
 
 	if (!bitbang->txrx_bufs) {
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 85578d4..1329053 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -4,8 +4,7 @@
 #include <linux/workqueue.h>
 
 struct spi_bitbang {
-	spinlock_t		lock;
-	u8			busy;
+	struct mutex		lock;
 	u8			use_dma;
 	u8			flags;		/* extra spi->mode support */
 
-- 
2.5.0.rc2.392.g76e840b
