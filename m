From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Sep 2016 16:30:21 +0200
Subject: [RFC PATCH 00/10] ARM: dts: exynos: Fix invalid GIC interrupt
 flags
In-Reply-To: <20160918103436.6af07ee9@arm.com>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
 <CAGOxZ50WiEVGNKf_1_8DQiKruxY=0813dko18fPfuRqxeyud0A@mail.gmail.com>
 <20160917175553.GA9499@kozik-lap> <20160918103436.6af07ee9@arm.com>
Message-ID: <20160918143021.GA9489@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 10:34:36AM +0100, Marc Zyngier wrote:
> On Sat, 17 Sep 2016 19:55:53 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On Sat, Sep 17, 2016 at 11:05:39PM +0530, Alim Akhtar wrote:
> > > Hi Krzysztof,
> > > 
> > > On Sat, Sep 17, 2016 at 1:12 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:  
> > > > Hi,
> > > >
> > > > Marek (internally), Geert and Alban reported errors like:
> > > >         genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
> > > > The patchset fixes this issue.
> > > >
> > > > Tested on:
> > > > 1. Exynos4412: Odroid U3,
> > > > 2. Exynos5410: Odroid XU,
> > > > 3. Exynos5422: Odroid XU3.
> > > >  
> > > 
> > > Tested on Exynos5800 based peach-pi board, so fpr patch 06/10
> > > 
> > > Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
> > > 
> > >   
> > > > Other platforms not tested so testing would be highly appreciated.
> > > >
> > > > Best regards,
> > > > Krzysztof
> > > >
> > > > Krzysztof Kozlowski (10):
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4210
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4x12
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos4415
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos3250
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5250
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in
> > > >     exynos5410/exynos542x
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5260
> > > >   ARM: dts: exynos: Fix invalid GIC interrupt flags in exynos5440
> > > >  
> > > 
> > > In general these patches looks good, feel free to add my review-by tag
> > > for this series.
> > > 
> > > Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> > >   
> > 
> > Thanks, I'll add your reviewed-by to all patches.
> 
> There is a couple of things that I don't like about these patches:
> 
> - Are you sure that all your interrupts are level? I appreciate that's
>   a very common setting, but you seem to have simply decided that there
>   wasn't any edge interrupt. Is that a "Let's see what breaks"
>   situation? If so, It'd be good to state it.

Yes, that's the case. I can mention it in commit msg more explicitly.
Anyway till now, Exynos platform always used IRQ_TYPE_NONE. Also vendor
kernel uses it. However this did not affect the platform. I didn't dig
too much into it but it seemts that __irq_set_trigger wasn't called
before for these interrupts.

> 
> - You've used the IRQ_TYPE_LEVEL_HIGH macro everywhere, but didn't use
>   the GIC_SPI macro as the first argument of each interrupt specifier.
>   I'm by no mean a fan of these macros, but you should at least have
>   some consistency inside an interrupt specifier.

I wanted to fix here only the error itself. Using GIC_SPI instead of 0
is not related so I replaced it in separate patches [1]. Keeping such
change separate makes testing easy - dtx_diff.

Best regards,
Krzysztof

[1] https://patchwork.kernel.org/patch/9336781/
