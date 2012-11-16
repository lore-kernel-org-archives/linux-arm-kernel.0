From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Nov 2012 15:51:55 +0200
Subject: [PATCH] OMAP: board-files: fix i2c_bus for tfp410
In-Reply-To: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20121116135155.GE18527@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 16, 2012 at 02:22:33PM +0200, Tomi Valkeinen wrote:
> The i2c handling in tfp410 driver, which handles converting parallel RGB
> to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af. The

commit summary should be added in () after commit hash. This would look
like:

'was changed in 958f271 (OMAPDSS: TFP410: pdata rewrite).'

> patch changed what value the driver considers as invalid/undefined.
> Before the patch 0 was the invalid value, but as 0 is a valid bus
                  ^
		  missing comma (,) character here.

> number, the patch changed this to -1.
> 
> However, the fact was missed that many board files do not define the bus
> number at all, thus it's left to 0. This causes the driver to fail to
> get the i2c bus, exiting from the driver's probe with an error, meaning
> that the DVI output does not work for those boards.
> 
> This patch fixes the issue by changing the i2c_bus number field in the
> driver's platform data from u16 to int, and setting the bus number to -1
> in the board files for the boards that did not define the bus. The
> exception is devkit8000, for which the bus is set to 1, which is the
> correct bus for that board.
> 
> The bug exists in v3.5+ kernels.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Thomas Weber <thomas@tomweber.eu>
> [for v3.5, v3.6 stable kernels]
> Cc: stable at vger.kernel.org

This format is peculiar. Usually people use:

Cc: stable at vger.kernel.org # v3.5 v3.6

To be fair, the whole i2c_bus_num looks like a big hackery introduced by
the way panel drivers are written for OMAP DSS.

TFP410 is an I2C client, not an OMAPDSS client. After a quick look at
the driver, there's is no such thing as a DSS bus, so looks like you
should have an I2C driver for TFP410 and the whole DSS stuff should be
just a list of clients, but not a struct bus at all.

The fact that you have to pass the I2C bus number down to the panel
driver is already a big indication of how wrong this is, IMHO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/547da487/attachment.sig>
