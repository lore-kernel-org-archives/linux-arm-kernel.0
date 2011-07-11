From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Mon, 11 Jul 2011 17:23:18 +0100
Subject: [PATCH] ARM:SAMSUNG: DMA Cleanup as per sparse [re-submit]
Message-ID: <1310401398-21104-1-git-send-email-sangwook.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function declaration differs between file: dma.c and file:dma.h
and SPARSE (Documentation/sparse.txt) gives error messages

All dma channels are members of 'enum dma_ch' and not 'unsigned int'
Please have a look at channel definitions in:
arch/arm/mach-s3c64xx/include/mach/dma.h
arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
arch/arm/mach-s3c2410/include/mach/dma.h
So all arguments should be of type 'enum dma_ch'

Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
---
 arch/arm/mach-s3c64xx/dma.c              |   14 +++++++-------
 arch/arm/plat-s3c24xx/dma.c              |   12 ++++++------
 arch/arm/plat-samsung/dma.c              |    6 +++---
 arch/arm/plat-samsung/include/plat/dma.h |   21 +++++++++++----------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index b197171..204bfaf 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -113,7 +113,7 @@ found:
 	return chan;
 }
 
-int s3c2410_dma_config(unsigned int channel, int xferunit)
+int s3c2410_dma_config(enum dma_ch channel, int xferunit)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
@@ -297,7 +297,7 @@ static int s3c64xx_dma_flush(struct s3c2410_dma_chan *chan)
 	return 0;
 }
 
-int s3c2410_dma_ctrl(unsigned int channel, enum s3c2410_chan_op op)
+int s3c2410_dma_ctrl(enum dma_ch channel, enum s3c2410_chan_op op)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
@@ -331,7 +331,7 @@ EXPORT_SYMBOL(s3c2410_dma_ctrl);
  *
  */
 
-int s3c2410_dma_enqueue(unsigned int channel, void *id,
+int s3c2410_dma_enqueue(enum dma_ch channel, void *id,
 			dma_addr_t data, int size)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
@@ -415,7 +415,7 @@ err_buff:
 EXPORT_SYMBOL(s3c2410_dma_enqueue);
 
 
-int s3c2410_dma_devconfig(unsigned int channel,
+int s3c2410_dma_devconfig(enum dma_ch channel,
 			  enum s3c2410_dmasrc source,
 			  unsigned long devaddr)
 {
@@ -463,7 +463,7 @@ int s3c2410_dma_devconfig(unsigned int channel,
 EXPORT_SYMBOL(s3c2410_dma_devconfig);
 
 
-int s3c2410_dma_getposition(unsigned int channel,
+int s3c2410_dma_getposition(enum dma_ch channel,
 			    dma_addr_t *src, dma_addr_t *dst)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
@@ -487,7 +487,7 @@ EXPORT_SYMBOL(s3c2410_dma_getposition);
  * get control of an dma channel
 */
 
-int s3c2410_dma_request(unsigned int channel,
+int s3c2410_dma_request(enum dma_ch channel,
 			struct s3c2410_dma_client *client,
 			void *dev)
 {
@@ -533,7 +533,7 @@ EXPORT_SYMBOL(s3c2410_dma_request);
  * allowed to go through.
 */
 
-int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
+int s3c2410_dma_free(enum dma_ch channel, struct s3c2410_dma_client *client)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 	unsigned long flags;
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 2abf966..623fba5 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -712,7 +712,7 @@ static struct s3c2410_dma_chan *s3c2410_dma_map_channel(int channel);
  * get control of an dma channel
 */
 
-int s3c2410_dma_request(unsigned int channel,
+int s3c2410_dma_request(enum dma_ch channel,
 			struct s3c2410_dma_client *client,
 			void *dev)
 {
@@ -783,7 +783,7 @@ EXPORT_SYMBOL(s3c2410_dma_request);
  * allowed to go through.
 */
 
-int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
+int s3c2410_dma_free(enum dma_ch channel, struct s3c2410_dma_client *client)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 	unsigned long flags;
@@ -974,7 +974,7 @@ static int s3c2410_dma_started(struct s3c2410_dma_chan *chan)
 }
 
 int
-s3c2410_dma_ctrl(unsigned int channel, enum s3c2410_chan_op op)
+s3c2410_dma_ctrl(enum dma_ch channel, enum s3c2410_chan_op op)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
@@ -1021,7 +1021,7 @@ EXPORT_SYMBOL(s3c2410_dma_ctrl);
  * xfersize:     size of unit in bytes (1,2,4)
 */
 
-int s3c2410_dma_config(unsigned int channel,
+int s3c2410_dma_config(enum dma_ch channel,
 		       int xferunit)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
@@ -1104,7 +1104,7 @@ EXPORT_SYMBOL(s3c2410_dma_config);
  * devaddr:   physical address of the source
 */
 
-int s3c2410_dma_devconfig(unsigned int channel,
+int s3c2410_dma_devconfig(enum dma_ch channel,
 			  enum s3c2410_dmasrc source,
 			  unsigned long devaddr)
 {
@@ -1177,7 +1177,7 @@ EXPORT_SYMBOL(s3c2410_dma_devconfig);
  * returns the current transfer points for the dma source and destination
 */
 
-int s3c2410_dma_getposition(unsigned int channel, dma_addr_t *src, dma_addr_t *dst)
+int s3c2410_dma_getposition(enum dma_ch channel, dma_addr_t *src, dma_addr_t *dst)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
diff --git a/arch/arm/plat-samsung/dma.c b/arch/arm/plat-samsung/dma.c
index cb459dd..6143aa1 100644
--- a/arch/arm/plat-samsung/dma.c
+++ b/arch/arm/plat-samsung/dma.c
@@ -41,7 +41,7 @@ struct s3c2410_dma_chan *s3c_dma_lookup_channel(unsigned int channel)
  * irq?
 */
 
-int s3c2410_dma_set_opfn(unsigned int channel, s3c2410_dma_opfn_t rtn)
+int s3c2410_dma_set_opfn(enum dma_ch channel, s3c2410_dma_opfn_t rtn)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
@@ -56,7 +56,7 @@ int s3c2410_dma_set_opfn(unsigned int channel, s3c2410_dma_opfn_t rtn)
 }
 EXPORT_SYMBOL(s3c2410_dma_set_opfn);
 
-int s3c2410_dma_set_buffdone_fn(unsigned int channel, s3c2410_dma_cbfn_t rtn)
+int s3c2410_dma_set_buffdone_fn(enum dma_ch channel, s3c2410_dma_cbfn_t rtn)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
@@ -71,7 +71,7 @@ int s3c2410_dma_set_buffdone_fn(unsigned int channel, s3c2410_dma_cbfn_t rtn)
 }
 EXPORT_SYMBOL(s3c2410_dma_set_buffdone_fn);
 
-int s3c2410_dma_setflags(unsigned int channel, unsigned int flags)
+int s3c2410_dma_setflags(enum dma_ch channel, unsigned int flags)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 
diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
index 2e8f8c6..8c273b7 100644
--- a/arch/arm/plat-samsung/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -42,6 +42,7 @@ struct s3c2410_dma_client {
 };
 
 struct s3c2410_dma_chan;
+enum dma_ch;
 
 /* s3c2410_dma_cbfn_t
  *
@@ -62,7 +63,7 @@ typedef int  (*s3c2410_dma_opfn_t)(struct s3c2410_dma_chan *,
  * request a dma channel exclusivley
 */
 
-extern int s3c2410_dma_request(unsigned int channel,
+extern int s3c2410_dma_request(enum dma_ch channel,
 			       struct s3c2410_dma_client *, void *dev);
 
 
@@ -71,14 +72,14 @@ extern int s3c2410_dma_request(unsigned int channel,
  * change the state of the dma channel
 */
 
-extern int s3c2410_dma_ctrl(unsigned int channel, enum s3c2410_chan_op op);
+extern int s3c2410_dma_ctrl(enum dma_ch channel, enum s3c2410_chan_op op);
 
 /* s3c2410_dma_setflags
  *
  * set the channel's flags to a given state
 */
 
-extern int s3c2410_dma_setflags(unsigned int channel,
+extern int s3c2410_dma_setflags(enum dma_ch channel,
 				unsigned int flags);
 
 /* s3c2410_dma_free
@@ -86,7 +87,7 @@ extern int s3c2410_dma_setflags(unsigned int channel,
  * free the dma channel (will also abort any outstanding operations)
 */
 
-extern int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *);
+extern int s3c2410_dma_free(enum dma_ch channel, struct s3c2410_dma_client *);
 
 /* s3c2410_dma_enqueue
  *
@@ -95,7 +96,7 @@ extern int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *);
  * drained before the buffer is given to the DMA system.
 */
 
-extern int s3c2410_dma_enqueue(unsigned int channel, void *id,
+extern int s3c2410_dma_enqueue(enum dma_ch channel, void *id,
 			       dma_addr_t data, int size);
 
 /* s3c2410_dma_config
@@ -103,14 +104,14 @@ extern int s3c2410_dma_enqueue(unsigned int channel, void *id,
  * configure the dma channel
 */
 
-extern int s3c2410_dma_config(unsigned int channel, int xferunit);
+extern int s3c2410_dma_config(enum dma_ch channel, int xferunit);
 
 /* s3c2410_dma_devconfig
  *
  * configure the device we're talking to
 */
 
-extern int s3c2410_dma_devconfig(unsigned int channel,
+extern int s3c2410_dma_devconfig(enum dma_ch channel,
 		enum s3c2410_dmasrc source, unsigned long devaddr);
 
 /* s3c2410_dma_getposition
@@ -118,10 +119,10 @@ extern int s3c2410_dma_devconfig(unsigned int channel,
  * get the position that the dma transfer is currently at
 */
 
-extern int s3c2410_dma_getposition(unsigned int channel,
+extern int s3c2410_dma_getposition(enum dma_ch channel,
 				   dma_addr_t *src, dma_addr_t *dest);
 
-extern int s3c2410_dma_set_opfn(unsigned int, s3c2410_dma_opfn_t rtn);
-extern int s3c2410_dma_set_buffdone_fn(unsigned int, s3c2410_dma_cbfn_t rtn);
+extern int s3c2410_dma_set_opfn(enum dma_ch, s3c2410_dma_opfn_t rtn);
+extern int s3c2410_dma_set_buffdone_fn(enum dma_ch, s3c2410_dma_cbfn_t rtn);
 
 
-- 
1.7.4.1
