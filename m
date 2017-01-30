From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 12:39:15 +0000
Subject: [PATCH] arm: module: handle negative R_ARM_PREL31 addends
 correctly
In-Reply-To: <1484907663-32322-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484907663-32322-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170130123914.GQ27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 10:21:03AM +0000, Ard Biesheuvel wrote:
> According to the spec 'ELF for the ARM Architecture' (IHI 0044E),
> addends for R_ARM_PREL31 relocations are 31-bit signed quantities,
> so we need to sign extend the value to 32 bits before it can be used
> as an offset in the calculation of the relocated value.
> 
> We have not been bitten by this because these relocations are usually
> emitted against the start of a section, which means the addends never
> assume negative values in practice. But it is a bug nonetheless, so fix
> it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> This is something I spotted while looking into adding support for
> R_ARM_REL32 relocations. Feel free to ignore if it is guaranteed in some
> way that these relocations can never be emitted with negative addends.

I still think this is a good thing to have, even if we should never
see them - it avoids updating the relocation with an incorrect value.
Any relocations we perform should be guaranteed to be correct, or
we should fail.

Please put it in the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
