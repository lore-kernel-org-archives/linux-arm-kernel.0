From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2016 11:25:50 +0100
Subject: [PATCH] ARM: dts: realview: Extend PBX family memory description
In-Reply-To: <1476778873-12210-1-git-send-email-linus.walleij@linaro.org>
References: <1476778873-12210-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161018102550.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 10:21:13AM +0200, Linus Walleij wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> All three platforms sharing the later RealView Platform Baseboard memory
> map - PBX-A9, PB-A8 and PB11MPCore, provide 512MB of DDR SDRAM on the
> baseboard, of which the boot alias at 0x0 maps the first 256MB. Expand
> the size of the default memory node to reflect that, and describe the
> full memory regions in each board's DTS, but leave those commented by
> default to avoid breaking existing bootloaders.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I forgot to send this patch for ARM SoC earlier.
> As it is a small change I suggest you just apply it to the ARM
> SoC tree as I do not foresee any other RealView work in the near
> future. If you think it can go into v4.9 then put it in as a fix,
> else just push it to the next merge window.
> Robin: sorry for screwing up :(

Normally, memory nodes describe different regions of unique memory.
This is not unique memory, but is an alias of some already-described
memory.

The problem with adding the aliased memory addresses is that we end
up needing platform knowledge to reject the "other alias" from the
memory description, which really isn't good.

The only reason it works is that we reject memory nodes where the
physical address < PHYS_OFFSET.  That works provided the alias is
below PHYS_OFFSET, but that isn't always the case.

So, I think it is completely wrong to describe the aliased memory
regions in DT.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
