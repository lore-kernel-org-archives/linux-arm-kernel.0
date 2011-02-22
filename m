From: wg@grandegger.com (Wolfgang Grandegger)
Date: Tue, 22 Feb 2011 17:27:51 +0100
Subject: [PATCH v2 01/13] mfd: pruss mfd driver.
In-Reply-To: <C73EA0C998A34C709A8130A50A1C443F@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-2-git-send-email-subhasish@mistralsolutions.com>
	<20110221163027.GF10686@sortiz-mobl>
	<37B3755C4AE64BAA805DFBAEBDC3D9E4@subhasishg>
	<20110222103127.GC30279@sortiz-mobl>
	<4D639493.1060601@grandegger.com>
	<20110222113310.GD30279@sortiz-mobl>
	<C73EA0C998A34C709A8130A50A1C443F@subhasishg>
Message-ID: <4D63E407.3010801@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2011 01:49 PM, Subhasish Ghosh wrote:
> I am not sure if I understood you correctly, but the current sizeof the
> structure da8xx_prusscore_regs  is 0x500.
> 
> Here is a link to the PRUSS memory map:
> http://processors.wiki.ti.com/index.php/PRUSS_Memory_Map
> 
> The offset 0x00007000 is the PRU0 reg offset and 0x00007800 is the PRU1
> reg offset.
> We cannot have a register file larger than this, but lot of space is
> left out, possibly for future development.

What do you mean with "larger than this"? You ioremap the whole space
and unsued space could be filled with padding bytes:

struct pruss_regs {
	u8 ram0[0x0200];
	u8 res0[0x1e00];
	u8 ram1[0x0200];
	u8 res1[0x1e00];
	struct pruss_intc_regs intc;
	struct pruss_core_regs core[2];
};

Then:

  pruss_dev->regs = ioremap(pruss_dev->res->start,
	   	    resource_size(pruss_dev->res));

  __raw_writel(DA8XX_PRUCORE_CONTROL_RESETVAL,
               &pruss_dev->regs.core[pruss_num].control);

That's simple, transparent and save without magic offset handling.

Wolfgang.
