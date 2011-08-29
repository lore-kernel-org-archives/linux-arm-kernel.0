From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 29 Aug 2011 13:02:16 +0200
Subject: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <CAMPhdO8k-boE0p0J_60VrS3LBdNaJRfJ6z_HCHLiRbQtESOJFw@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829083649.GB24524@pengutronix.de>
	<CAMPhdO-vuExLKVSmsr_kR1HnHfEBPp_Ae7pgs=XaVYiKGFRo-A@mail.gmail.com>
	<20110829093746.GE24524@pengutronix.de>
	<CAMPhdO8k-boE0p0J_60VrS3LBdNaJRfJ6z_HCHLiRbQtESOJFw@mail.gmail.com>
Message-ID: <20110829110216.GI24524@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 05:54:23PM +0800, Eric Miao wrote:
> On Mon, Aug 29, 2011 at 5:37 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > On Mon, Aug 29, 2011 at 04:51:46PM +0800, Eric Miao wrote:
> >> On Mon, Aug 29, 2011 at 4:36 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> >> > On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> >> >> On imx53 AHCI, soft reset fails with IPMS set when PMP
> >> >> is enabled but SATA HDD/ODD is connected to SATA port,
> >> >> do soft reset again to port 0.
> >> >> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> >> >> ahci is present.
> >> >>
> >> >> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> >> >> ---
> >> >> ?drivers/ata/ahci_platform.c | ? 44 +++++++++++++++++++++++++++++++++++++-----
> >> >> ?1 files changed, 38 insertions(+), 6 deletions(-)
> >> >>
> >> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >> >> index 6fef1fa..f32c91e 100644
> >> >> --- a/drivers/ata/ahci_platform.c
> >> >> +++ b/drivers/ata/ahci_platform.c
> >> >> @@ -23,6 +23,41 @@
> >> >> ?#include <linux/ahci_platform.h>
> >> >> ?#include "ahci.h"
> >> >>
> >> >> +enum ahci_type {
> >> >> + ? ? AHCI, ? ? ? ? ? /* standard platform ahci */
> >> >> + ? ? IMX53_AHCI, ? ? /* ahci on i.mx53 */
> >> >
> >> > How about making all the IMX*-naming more generic because other SoC might need
> >> > this somewhen, too?
> >>
> >> From a practical point of view, we can start with what we know already.
> >> As the SATA controller on "other SoC" so far, we don't know yet if they
> >> show the same issue (which we have to use ahci_pmp_retry_srst_ops).
> >>
> >> So Wolfram, how about we consider a generic one once more controllers
> >> are being added?
> >
> > If we do so later, and we then also change the platform_device_id to something
> > generic, we then also have to change all users, too. Is it so bad to change
> > IMX53_AHCI (and imx53-ahci and alike) to something like "ahci-pmp-retry-srst"
> > (or similar) now?
> 
> There are other fields in ata_port_info which might be different between
> boards. Using a SoC specific name as an index to an array of ata_port_info
> will be more flexible, as is adopted in drivers/ata/ahci.c - the PCI driver.

Well, that file also has generic fixups:

       [board_ahci_ign_iferr] =
...

which is what I had in mind thinking that the flaw was not too imx53 specific.
If you think I am wrong, then be it. I mainly wanted to avoid the fixups which
might be needed later.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110829/a13976b0/attachment.sig>
