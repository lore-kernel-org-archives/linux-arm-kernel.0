From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 16 Oct 2012 14:47:56 -0500
Subject: [PATCH 1/5] ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode
In-Reply-To: <41d66042625157d089e9c9532030a6831e79c641.1350327324.git.richardcochran@gmail.com>
References: <cover.1350327320.git.richardcochran@gmail.com>
 <41d66042625157d089e9c9532030a6831e79c641.1350327324.git.richardcochran@gmail.com>
Message-ID: <507DB9EC.9060407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/15/2012 02:16 PM, Richard Cochran wrote:
> From: hvaibhav at ti.com <hvaibhav@ti.com>
> 
> With recent changes in omap gpmc driver code, in case of DT
> boot mode, where bootloader does not configure gpmc cs space
> will result into kernel BUG() inside gpmc_mem_init() function,
> as gpmc cs0 gpmc_config7[0].csvalid bit is set to '1' and
> gpmc_config7[0].baseaddress is set to '0' on reset.

I am not sure I completely follow the logic here.

Won't this problem occur if the bootloader does not configure the gpmc
cs space AND we are not using DT?

Is the csvalid bit set because we are booting from the internal ROM?

I guess I don't see why csvalid bit being set and a base-address of 0x0
should not be allowed. That should be a valid combination.

One problem I see with gpmc_mem_init() is that it assumes that
BOOT_ROM_SPACE is 1MB for all devices starting at 0x0 apart from the
apollon board. For newer devices such as OMAP4, there is only 48KB of
internal ROM and only mapped to 0x0 when booting from internal ROM. So
this needs to be fixed.

How much internal ROM does the AM335x have and where is it mapped?

> This use-case is applicable for any board/EVM which doesn't have
> any peripheral connected to gpmc cs0, for example BeagleXM and
> BeagleBone, so DT boot mode fails.
> 
> This patch adds of_have_populated_dt() check before creating
> device, so that for DT boot mode, gpmc probe will not be called
> which is expected behavior, as gpmc is not supported yet from DT.

Yes, but we do actually still allow some platform devices to be probed
(such as dmtimers) when booting with DT that don't support DT yet. So
this change prevents us from using the gpmc on boards when booting with DT.

I am not convinced that this is addressing the underlying problem with
gpmc_mem_init().

Cheers
Jon
