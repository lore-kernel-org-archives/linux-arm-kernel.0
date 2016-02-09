From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 15:54:26 +0100
Subject: [PATCH] Kbuild: provide a __UNIQUE_ID for clang
In-Reply-To: <20160208181326.GA3784@pobox.suse.cz>
References: <1454942318-2782493-1-git-send-email-arnd@arndb.de>
 <20160208181326.GA3784@pobox.suse.cz>
Message-ID: <2393216.K0HRYm6hPv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 19:13:26 Michal Marek wrote:
> On Mon, Feb 08, 2016 at 03:38:32PM +0100, Arnd Bergmann wrote:
> > The default __UNIQUE_ID macro in compiler.h fails to work for some drivers:
> > 
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:615:1: error: redefinition of
> >       '__UNIQUE_ID_firmware615'
> > BRCMF_FW_NVRAM_DEF(4354, "brcmfmac4354-sdio.bin", "brcmfmac4354-sdio.txt");
> 
> I applied the patch to kbuild.git#kbuild, but can you tell me with which
> commit and config you get such failure. I only see a single
> MODULE_FIRMWARE() call in the expansion of BRCMF_FW_NVRAM_DEF(), which
> should work with line numbers as well. And I can't reproduce it with
> today's linux-next. If there is some issue with code not yet in
> linux-next, it needs to be worked around, because older GCCs did not
> have __COUNTER__.

I wrote this patch in early January before Arend van Spriel changed the
code with the patch below. I wasn't aware of his change, but that explains
why you don't see the problem any more.

	Arnd

commit 23195ec00503c6c29daea5b6c780787c0b5f1bf3
Author: Arend van Spriel <aspriel@gmail.com>
Date:   Sat Jan 16 16:39:13 2016 +0100

    brcmfmac: fix BRCMF_FW_NVRAM_DEF macro for older gcc compilers
    
    With gcc < 4.3 __UNIQUE_ID does not create unique ids with the macro
    BRCMF_FW_NVRAM_DEF. Fix this by removing the MODULE_FIRMWARE instance
    for the nvram file. This file is not in linux-firmware repo so it may
    not be needed anyway. Otherwise consider this as a temporary fix.
    
    Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Arend van Spriel <aspriel@gmail.com>
    Acked-by: Kalle Valo <kvalo@codeaurora.org>
    Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
index ef06f57a7a0e..d3c9f0d52ae3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
@@ -47,8 +47,7 @@ static const char BRCM_ ## fw_nvram_name ## _FIRMWARE_NAME[] = \
 	BRCMF_FW_DEFAULT_PATH fw; \
 static const char BRCM_ ## fw_nvram_name ## _NVRAM_NAME[] = \
 	BRCMF_FW_DEFAULT_PATH nvram; \
-MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH fw); \
-MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH nvram)
+MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH fw);
 
 #define BRCMF_FW_DEF(fw_name, fw) \
 static const char BRCM_ ## fw_name ## _FIRMWARE_NAME[] = \
