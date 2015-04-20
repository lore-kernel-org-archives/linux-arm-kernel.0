From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 20 Apr 2015 14:41:04 +0100
Subject: [PATCH v2] ata: ahci_st: fixup layering violations / drvdata errors
Message-ID: <1429537265-22367-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun / Brian,

I tested the initial version of this patch (see http://patchwork.ozlabs.org/patch/459422/)
on stih410 hardware, however it introduced a NULL ptr dereference, as plat_data
isn't set until ahci_platform_init_host() but plat_data was being used before
this in the st_ahci_probe_resets and st_ahci_deassert_resets() functions.

Also the original patch had a conflict with a patch which Tejun has already
taken of mine 
(see here http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/326900.html).

So this V2 fixes the conflict, and re-works st_ahci_probe_resets and 
st_ahci_deassert_resets functions to take struct ahci_host_priv *hpriv as
a parameter.

Brian - I'm not sure of the correct patch etiquette here. Currently I have
taken authorship of the patch and added a "Suggested-by" tag on the V2.
Maybe I should have also kept your "Signed-off-by" or done something else?
Please let me know if this is OK or if you would like something changed.

regards,

Peter. 

Changes since v1:
 - Rework st_ahci_deassert_resets and st_ahci_probe_resets
 - Fix conflict with "st_configure_oob must be called after IP is clocked." patch

Peter Griffin (1):
  ata: ahci_st: fixup layering violations / drvdata errors

 drivers/ata/ahci_st.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

-- 
1.9.1
