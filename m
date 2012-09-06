From: peter@turczak.de (Peter Turczak)
Date: Thu, 6 Sep 2012 15:34:30 +0200
Subject: mxs: mmc: Problems resetting first SSP/MMC module upon boot
Message-ID: <FDB97EE7-CE8F-4B83-A384-2E256DADCEDA@turczak.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

while porting kernel 3.5 (pulled from the arm-soc git tree) to a new board based upon an MXS processor (ARM926EJ-S) I encountered a strange problem initializing the two ssp/mmc.

Given situation:
- The device has two mmc devices on board, connected to SSP0 and SSP2.
- When booting from the MMC both mmc are properly detected.
- When booting from usb, ethernet or NAND flash first mmc to be initialized in the machine init function fails. So when doing (example given is nearly literally from the code, the board name is not yet allocated with the registry):
        mx28_add_mxs_mmc(2, &board_mmc_pdata[2]);
        mx28_add_mxs_mmc(0, &board_mmc_pdata[0]);
   mmc0 works, mmc2 does not. When initializing mmc0 first mmc0 works.
- The init fails when trying to reset the respective ssp block in stmp_reset_block() from lib/stmp_device.c due to a timeout waiting for CLKGATE to become set again after setting the SFTRST   bit.

Things I tried:
- Check code of lib/stmp_device.c against reference manual of processor (i.MX28 Applications Processor Reference Manual, Rev. 1, 2010) says in section 39.5.10 (Correct Way to Soft Reset a Block): Seems ok, as it successfully resets some other blocks.
- Added a routine to also wait for (de-) assertion of the reset/clock gating bits as advised by the reference manual. No success here.
- Checked the pin muxing, just to be sure. Not expecting anything and as expected gained nothing.

Ideas: 
- Maybe it the clock derivation is not set up properly before resetting as at least two ssp-modules seem to derive the clock from the same clock source. But I have no idea how to test or debug this.

Therefore help is very much appreciated, maybe I'm missing something here.

Thank you in advance,
  Peter Turczak
