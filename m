From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 May 2012 10:40:48 +0300
Subject: Regression for non-eMMC cards with commit fa550189?
In-Reply-To: <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
Message-ID: <20120529074047.GE16340@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 29, 2012 at 02:52:34PM +0800, Ulf Hansson wrote:
> Hi Tony,
> 
> This patch changes the sequence of how the host drivers set_ios
> function gets called during probe.
> 
> Before:
> 1. mmc_power_off
> 2. mmc_power_up
> 
> Now:
> 1. mmc_power_up
> 
> My guess is then; the omap driver set_ios function requires that
> mmc_power_off is called before a mmc_power_up.
> Hopefully this requirement can be removed and fixed in the host driver somehow.
> 
> Please get back to me if you need some more assistance around this matter.
> 
> Kind regards
> Ulf Hansson
> 
> 
> On 28 May 2012 21:21, Tony Lindgren <tony@atomide.com> wrote:
> > Hi Ulf & Chris,
> >
> > Looks like commit fa550189 (mmc: core: Prevent eMMC VCC supply to be
> > cut from late init) causes MMC card to stop working at least with
> > n8x0 using drivers/mmc/host/omap.c. The card(s) on it are not eMMC.
> >
> > Reverting fa550189 makes things work again. Any ideas what could
> > be causing this?
> >
> > No debug output from MMC_DEBUG, looks like commands won't even
> > get started?

Can you enable debugging on menelaus so we see what the driver is doing ?

I believe that to change the VMMC's supply voltage you need to turn off
the regulator, meaning LDO_CTRL7[1:0] = 0b00.

That could be one thing. It would be cool what menelaus is writing to
the registers on working and failing case. Also what are the contents of
LDO_CTRL1 and LDO_CTRL7 before any operation. Something like this will
help:

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index cb4910a..8cab234 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -31,6 +31,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#define DEBUG
+
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -469,6 +471,10 @@ static int menelaus_set_voltage(const struct menelaus_vtg *vtg, int mV,
 	if (vtg == 0)
 		goto set_voltage;
 
+	dev_dbg(&c->dev, "VTG_REG %02x MODE_REG %02x\n",
+			menelaus_read_reg(vtg->vtg_reg),
+			menelaus_read_reg(mode_reg));
+
 	ret = menelaus_read_reg(vtg->vtg_reg);
 	if (ret < 0)
 		goto out;

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120529/cd8579c6/attachment.sig>
