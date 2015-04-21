From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 11:13:30 +0100
Subject: [PATCH 1/2] ARM: include Thumb2 bit in PROCINFO setup function
 offset
In-Reply-To: <1429610931-14903-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429610931-14903-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150421101330.GU12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 12:08:51PM +0200, Ard Biesheuvel wrote:
> This updates the PROCINFO offset-to-setup-function fields of the
> Thumb2 capable CPU definitions to include the Thumb bit when building
> a Thumb2 kernel. This ensures that these function are always called
> in the correct mode.

I don't think this is necessary, in fact, I think this is positively
regression causing.

The symbol 'initfunc' is known to the assembler to be a thumb symbol.
As we have seen already from the kernel dumps from the V7M kernel, when
it calculates initfunc - name in a T2 kernel, the resulting value is an
_odd_ number.

Using BSYM() here will increment it to be the next _even_ number, which
is wrong as this will potentially point at either half way through a
32-bit T2 instruction, or the second 16-bit T2 instruction.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
