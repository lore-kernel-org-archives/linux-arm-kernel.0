From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 1 Oct 2015 20:08:00 -0700
Subject: [RESEND PATCH v2] mtd: nand: pass page number to
 ecc->write_xxx() methods
In-Reply-To: <1443728091-13859-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443728091-13859-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151002030800.GE107187@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 09:34:51PM +0200, Boris Brezillon wrote:
> The ->read_xxx() methods are all passed the page number the NAND controller
> is supposed to read, but ->write_xxx() do not have such a parameter.
> 
> This is a problem if we want to properly implement data
> scrambling/randomization in order to mitigate MLC sensibility to repeated
> pattern: to prevent bitflips in adjacent pages in the same block we need
> to avoid repeating the same pattern at the same offset in those pages,
> hence the randomizer/scrambler engine need to be passed the page value
> in order to adapt its seed accordingly.
> 
> Moreover, adding the page parameter to the ->write_xxx() methods add some
> consistency to the current API.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> CC: Josh Wu <josh.wu@atmel.com>
> CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Huang Shijie <shijie.huang@intel.com>
> CC: Bryan Wu <bryan.wu@analog.com>
> CC: Stefan Agner <stefan@agner.ch>
> CC: devel at driverdev.osuosl.org
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> ---
> Sorry for the noise, I didn't send the correct patch version (the one
> fixing the compilation error in the doc4g driver).
> 
> Changes since v1:
> - rebased on l2-mtd/master
> - fixed compilation error in the doc4g driver

Didn't really look at the patch yet, but my build tests say:

drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function ?gpmi_ecc_write_oob_raw?:
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1536:2: error: too few arguments to function ?gpmi_ecc_write_page_raw?
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1446:12: note: declared here

Brian
