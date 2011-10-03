From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson XK)
Date: Mon, 3 Oct 2011 09:31:14 +0200
Subject: [PATCH 4/4] mmc: mmci: Fix incorrect handling of HW flow control
	for SDIO
In-Reply-To: <20111001161248.GG11710@n2100.arm.linux.org.uk>
References: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001161248.GG11710@n2100.arm.linux.org.uk>
Message-ID: <4E8964C2.5000300@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On 10/01/2011 06:12 PM, Russell King - ARM Linux wrote:
> Shouldn't this also re-enable the ST hardware flow control for non-SDIO
> cards?

I do not think that is needed. Hardware flow control is turned on per 
default for all cards thanks to the .clkreg member of the variant struct:

	mmci_set_clkreg():
		clk |= variant->clkreg_enable;
where
	static struct variant_data variant_ux500v2 = {
		.clkreg_enable          = MCI_ST_UX500_HWFCEN,

This means that HWFC will be on for all cards. This patch only disables 
it for SDIO cards (thanks to the mmc_card_sdio()-check) during 
problematic transfers (HW peculiarity), and then re-enables it again for 
SDIO cards during "normal" transfers. So the HWFC state for non-SDIO 
cards should not be touched I think.

Best Regards

Stefan Nilsson
