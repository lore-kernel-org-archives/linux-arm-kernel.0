From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 20:11:21 +0100
Subject: [PATCH 63/75] ARM: l2c: zynq: remove cache size override
In-Reply-To: <533BC56D.4010600@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk> <533BC56D.4010600@monstr.eu>
Message-ID: <20140403191120.GW7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 10:08:13AM +0200, Michal Simek wrote:
> Reset values are correctly setup by bootrom to 0x02060000
> That's why we can even use full mask.
> For current mainline code just like this
> 	l2x0_of_init(0x00000000, 0xffffffff);
> and we will submit the code which change this to
> 	l2x0_of_init(0x00400000, 0xffffffff);

If you wish to do that, please use 0xffbfffff as the mask, otherwise
some of the checks will fire (about possibly corrupted values.)

Fields you wish to set to a value must have clear bits in the mask.
This is to stop things like:

	l2x0_of_init(0x...246, 0x...fff)

which if the LSBs of the register are already set to a different value,
ends up doing this:

	new_reg = (old_reg & mask) | val

and hence ends up ORing the specified value with the existing value in
the register.  Hence, (val & mask) must be zero.

I'd rather not force bit 22 on for everyone - this problem /should/ no
longer be present with CMA since the memory is remapped in place rather
than having a second mapping setup.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
