From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Jul 2014 15:12:34 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <6373493.kzO00ziuYq@wuerfel>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <111661024.qGiugVUugr@wuerfel> <20140717110652.GA18383@ulmo>
 <6373493.kzO00ziuYq@wuerfel>
Message-ID: <20140721131233.GG15238@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 02:06:10PM +0200, Arnd Bergmann wrote:
> On Thursday 17 July 2014 13:06:53 Thierry Reding wrote:
> > 
> > We could go all the way and make it include/soc/tegra/*.h for better
> > namespacing. I guess either way would be fine, really, since the number
> > of files in those directories should be small by definition, so we
> > should be able to do without the extra SoC directory, too. I have a
> > slight preference for a separate SoC directory, do you have any
> > objections?
> 
> I'm fine with it either way. I just noticed that you have now
> moved the file, which resulted in a build error:
> 
> ../drivers/ata/ahci_tegra.c:27:35: fatal error: linux/tegra-powergate.h: No such file or directory
>  #include <linux/tegra-powergate.h>
>                                    ^
> compilation terminated.
> make[4]: *** [drivers/ata/ahci_tegra.o] Error 1
> 
> so somebody needs to pick up this patch:
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index d30bb21afd67..d7c6b1f550cd 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -24,8 +24,8 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> -#include <linux/tegra-powergate.h>
>  #include <linux/regulator/consumer.h>
> +#include <soc/tegra/pmc.h>
>  #include "ahci.h"
>  
>  #define SATA_CONFIGURATION_0				0x180
> 
> 
> I haven't checked which trees are affected of if you have already posted
> a patch to do this.
> 
> 	Arnd

Adding Tejun, since he took this into his tree on Friday I think, just a
few hours after I sent out pull requests for this.

I hadn't considered this build dependency. We could resolve this in two
ways I think:

	- merge the for-3.17/fuse-move branch from the Tegra tree into
	  the libata tree and apply Arnd's patch to the libata tree

	- provide a dummy include/linux/tegra-powergate.h header that
	  includes soc/tegra/powergate.h

In the latter case the dummy could possibly be removed right after
v3.17-rc1 along with a patch to convert the AHCI driver to use the new
header file. Or we could keep the compatibility header until the v3.18
merge window. I have a slight preference for this, even though it's a
wee bit of churn.

The problem is that we can't simply apply the patch that Arnd provided
because it would break the standalone libata tree if somebody were to
build Tegra with the new driver enabled.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/90b6b262/attachment-0001.sig>
