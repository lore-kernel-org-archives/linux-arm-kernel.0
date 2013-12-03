From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Dec 2013 19:41:43 +0000
Subject: [PATCH] arm64: dts: Add a virtio disk to the RTSM motherboard
In-Reply-To: <1386098643-30784-1-git-send-email-broonie@kernel.org>
References: <1386098643-30784-1-git-send-email-broonie@kernel.org>
Message-ID: <20131203194136.GB22668@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 07:24:03PM +0000, Mark Brown wrote:
> From: Mark Hambleton <mahamble@broadcom.com>
> 
> Describe the virtio device so we can mount disk images in the simulator.
> 
> Signed-off-by: Mark Hambleton <mahamble@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
> index b45e5f39f577..4ccd96552b70 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
> @@ -183,6 +183,12 @@
>  				clocks = <&v2m_oscclk1>, <&v2m_clk24mhz>;
>  				clock-names = "clcdclk", "apb_pclk";
>  			};
> +
> +			virtio_block at 0130000 {
> +				compatible = "virtio,mmio";
> +				reg = <0x130000 0x1000>;

Can we make this 0x200 for the size? That's what kvmtool uses and, from the
virtio-mmio spec, config data from offset 0x100+ is driver-specific. A quick
look at the virtio block driver suggests we only use 31 bytes of that at the
moment, so 4k is really OTT (and doesn't match the page size for 64K page
systems anyway).

With that change:

  Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
