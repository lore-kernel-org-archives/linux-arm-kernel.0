From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 21:14:59 +0200
Subject: OMAP baseline test results for v3.8-rc3
In-Reply-To: <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
Message-ID: <20130114191459.GA9402@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 14, 2013 at 08:40:18PM +0200, Aaro Koskinen wrote:
> On Mon, Jan 14, 2013 at 05:59:12PM +0000, Paul Walmsley wrote:
> > Here are some basic OMAP test results for Linux v3.8-rc3.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc3/20130109222058/
> > 
> > 
> > Test summary
> > ------------
> > 
> > Boot to userspace:
> >     Pass ( 9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
> >   	   	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
> > 		  4460pandaes
> >     FAIL ( 2/11): am335xbone, cmt3517 
> 
> N900 boot is unstable again, I2C issues are back.

damn!

> Boot succeeds and fails randomly. Let's see if this can be bisected.
> The same kernel works on N950.

fair enough, it might be something related to some errata fix which
might have been missed. Can you apply this small patch just so I know if
there is something pending in CNT reg ?

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 20d41bf..173e883 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -462,6 +462,10 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
 		if (time_after(jiffies, timeout)) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
+			dev_warn(dev->dev, "SA %04x CON %04x CNT %04x\n",
+					omap_i2c_read_reg(dev, OMAP_I2C_SA_REG),
+					omap_i2c_read_reg(dev, OMAP_I2C_CON_REG),
+					omap_i2c_read_reg(dev, OMAP_I2C_CNT_REG));
 			return -ETIMEDOUT;
 		}
 		msleep(1);


you might also want to try merging my latest i2c patches, which missed
the merge window, as they might help with this issue too.

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-deferred-STP

for you to fetch changes up to a7b1b41b270be84f6bf6e7d3654d74c873b3daf8:

  i2c: omap: get rid of b_hw flag (2013-01-14 21:04:16 +0200)

----------------------------------------------------------------
Felipe Balbi (6):
      i2c: omap: no need to access platform_device
      i2c: omap: also complete() when stat becomes zero
      i2c: omap: improve 'rev' a little bit
      i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to IRQSTATUS
      i2c: omap: wait for transfer completion before sending STP bit
      i2c: omap: get rid of b_hw flag

 drivers/i2c/busses/i2c-omap.c | 184 +++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 91 deletions(-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/0686f1db/attachment.sig>
