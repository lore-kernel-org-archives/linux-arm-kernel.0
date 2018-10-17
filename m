From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Oct 2018 11:28:38 -0700
Subject: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu device nodes
In-Reply-To: <20180827151112.25211-6-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
Message-ID: <CAD=FV=WzkRtcdy_=eatp=AEkJ54d=qvNGzNYCMCMnVAWtrXAQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 27, 2018 at 8:11 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> +               gpu at 5000000 {
> +                       compatible = "qcom,adreno-630.2", "qcom,adreno";
> +                       #stream-id-cells = <16>;
> +
> +                       reg = <0x5000000 0x40000>;
> +                       reg-names = "kgsl_3d0_reg_memory";
> +
> +                       /*
> +                        * Look ma, no clocks! The GPU clocks and power are
> +                        * controlled entirely by the GMU
> +                        */
> +
> +                       interrupts = <0 300 0>;
> +                       interrupt-names = "kgsl_3d0_irq";

Drive-by feedback here.  The "interrupts" above should be:

interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;

* GIC_SPI is 0, but GIC_SPI is more documenting.

* having 0 for the final element means 'IRQ_TYPE_NONE'.  On newer
kernels commit 6ef6386ef7c1 ("irqchip/gic-v3: Loudly complain about
the use of IRQ_TYPE_NONE") will cause loud yells if you do this.  This
turns out to be a bit silly because (IIUC) the flags in the device
tree are totally ignored if the driver passes in flags itself [1].
...but I guess we should do it right.  I believe the code requesting
this irq is a6xx_gmu_get_irq() which requests a level high interrupt,
so we should list level high here.


[1] https://lore.kernel.org/lkml/CAD=FV=XmiOh0Mg0f4a=W0NCH8eb--OQhP2jNAv2ZMpUBOn9n6Q at mail.gmail.com/T/#u


-Doug
