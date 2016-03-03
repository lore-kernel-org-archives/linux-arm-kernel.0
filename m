From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 3 Mar 2016 15:23:42 +0100
Subject: [PATCH 04/14] power: pm2301-charger: use __maybe_unused to hide
 pm functions
In-Reply-To: <1456934350-1389172-5-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-5-git-send-email-arnd@arndb.de>
Message-ID: <20160303142342.GG29689@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 02, 2016 at 04:58:56PM +0100, Arnd Bergmann wrote:
> The pm2301 charger driver uses nested #ifdefs to check for both
> CONFIG_PM and CONFIG_PM_SLEEP in an attempt to hide its
> suspend and runtime-pm operations when they are unused, but
> it does not hide the clear_lpn_pin() function in the same
> way, so we get a build warning when everything is
> disabled:
> 
> drivers/power/pm2301_charger.c:123:13: error: 'clear_lpn_pin' defined but not used [-Werror=unused-function]
> 
> This removes all the #ifdef and instead uses __maybe_unused
> annotations to let the compiler know it can silently drop
> the function definition.
> 
> For the PM2XXX_PM_OPS, we can use an IS_ENABLED() check
> to avoid defining the structure when CONFIG_PM is not set without
> the #ifdef.

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160303/2fc7c7a5/attachment.sig>
