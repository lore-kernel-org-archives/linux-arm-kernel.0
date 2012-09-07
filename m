From: peter@turczak.de (Peter Turczak)
Date: Fri, 7 Sep 2012 05:35:18 +0200
Subject: mxs: mmc: Problems resetting first SSP/MMC module upon boot
In-Reply-To: <20120907010143.GD26709@S2101-09.ap.freescale.net>
References: <FDB97EE7-CE8F-4B83-A384-2E256DADCEDA@turczak.de>
 <20120907010143.GD26709@S2101-09.ap.freescale.net>
Message-ID: <EE31261C-7324-4E13-9EE0-D3BFB4C92B99@turczak.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sep 7, 2012, at 3:01 AM, Shawn Guo wrote
>> - When booting from usb, ethernet or NAND flash first mmc to be initialized in the machine init function fails. So when doing (example given is nearly literally from the code, the board name is not yet allocated with the registry):
>>        mx28_add_mxs_mmc(2, &board_mmc_pdata[2]);
>>        mx28_add_mxs_mmc(0, &board_mmc_pdata[0]);
>>   mmc0 works, mmc2 does not. When initializing mmc0 first mmc0 works.
> 
> When initializing mmc0 first, you meant mmc0 works or does not work?
Exactly. Now after some testing I found out, any mmc[012] initialized first does not work. Everytime it's stmp_reset_block() fails for the respective block, which is strange.

When the bootloader (both ROM and u-boot from NAND) have initialized the slot before, smtp_reset_block() works and all mmc are available and working reliably.

One more thing: A kernel 2.6.35 patched with the files provided by Freescale always successfully initializes all mmc on the board.
>> Ideas: 
>> - Maybe it the clock derivation is not set up properly before resetting as at least two ssp-modules seem to derive the clock from the same clock source. But I have no idea how to test or debug this.
>> 
> ssp0 and ssp1 share one clock source, while ssp2 and ssp3 share
> another one.  I'm not sure if it's the cause, but 3.5 kernel did miss
> one bug fix below.
> 
>  64e2bc4 clk: mxs: imx28: decrease the frequency of ref_io1 for SSP2 and SSP3
> 
> You can get it from 3.6-rc1 kernel.
Thank you, I will give it a try and report back.
> 
> -- 
> Regards,
> Shawn
Best Regards,
  Peter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
