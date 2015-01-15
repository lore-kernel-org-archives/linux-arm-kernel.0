From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 15 Jan 2015 09:45:27 +0100
Subject: [PATCH] ARM: at91: dts: sama5d3/sama5d4: reduce NFC command
 registers memory region
In-Reply-To: <1421305683-8739-1-git-send-email-josh.wu@atmel.com>
References: <1421305683-8739-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150115094527.3fde882a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Thu, 15 Jan 2015 15:08:03 +0800
Josh Wu <josh.wu@atmel.com> wrote:

> To get NFC status, we need to read the NFC command registers, which is a
> 256M memory mapping address. To check the status, you just read such
> address from NFC command registers.
> For example, to check NFCBUSY (bit 27), you need to read 0x08000000
> (bit 27 is set to 1) of the NFC command register.
> If you want to check NFCBUSY (bit 27) and NFCWR (bit 26) in same time,
> you need to read 0x0c000000 (bit 27 and bit 26 are set to 1).

Are NFCBUSY and NFCWR found in NFCDATA_STATUS and those found in HSMC_SR
representing the same thing.
If they are, I think you can just use HSMC_SR instead of NFCDATA_STATUS
to check the status [1] and drop the last bit in the NFC Command
Resgiters range.

> 
> But mapping such huge memory address only for multiple NFC status check
> is not very economic.
> 
> The economic way is we check the NFC status one bit a time, then we don't
> have to mapping such huge address.
> 
> Now we reduce the memory mapping from 256M to 128M+4 (include 0x08000000),
> the only difference is NFCBUSY (bit 27) status. You cannot check NFCBUSY
> bit with other NFC status bit.
> 
> Since current atmel_nand driver check the NFCBUSY status without combine
> other bits, so this change (reduce 256M to 128M+4) will not be harmful.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> ---
> 
>  arch/arm/boot/dts/sama5d3.dtsi | 2 +-
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index d701ddd..d243732 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -1426,7 +1426,7 @@
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  				reg = <
> -					0x70000000 0x10000000	/* NFC Command Registers */
> +					0x70000000 0x08000004	/* NFC Command Registers */

This would give the following range:

					0x70000000 0x08000000


Best Regards,

Boris

[1]http://code.bulix.org/2noozv-87724


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
