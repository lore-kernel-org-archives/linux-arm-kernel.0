From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 25 Sep 2016 10:41:23 +0100
Subject: [PATCH 0/4] Add DMA support for ti_am335x_adc driver
In-Reply-To: <20160921161134.6951-1-mugunthanvnm@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
Message-ID: <22588f2d-d0de-7911-35ed-92094f7dd28d@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/16 17:11, Mugunthan V N wrote:
> The ADC has a 64 work depth fifo length which holds the ADC data
> till the CPU reads. So when a user program needs a large ADC data
> to operate on, then it has to do multiple reads to get its
> buffer. Currently if the application asks for 4 samples per
> channel with all 8 channels are enabled, kernel can provide only
> 3 samples per channel when all 8 channels are enabled (logs at
> [1]). So with DMA support user can request for large number of
> samples at a time (logs at [2]).
> 
> Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
> patch [3] to enable ADC and pushed a branch for testing [4]
> 
> [1] - http://pastebin.ubuntu.com/23211490/
> [2] - http://pastebin.ubuntu.com/23211492/
> [3] - http://pastebin.ubuntu.com/23211494/
> [4] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma
Just curious.  How fast is the ADC sampling at in these?  Never that
obvious for this driver!

I'm also curious as to whether you started to hit the limits of the
kfifo based interface.  Might be worth considering adding alternative
support for the dma buffers interface which is obviously much lower
overhead.

Good to have this work prior to that as the kfifo stuff is somewhat
easier to use.

Jonathan
> 
> Mugunthan V N (4):
>   mfd: ti_am335x_tscadc: store physical address
>   drivers: iio: ti_am335x_adc: add dma support
>   ARM: dts: am33xx: add DMA properties for tscadc
>   ARM: dts: am4372: add DMA properties for tscadc
> 
>  arch/arm/boot/dts/am33xx.dtsi        |   2 +
>  arch/arm/boot/dts/am4372.dtsi        |   2 +
>  drivers/iio/adc/ti_am335x_adc.c      | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/mfd/ti_am335x_tscadc.c       |   1 +
>  include/linux/mfd/ti_am335x_tscadc.h |   8 ++
>  5 files changed, 170 insertions(+), 3 deletions(-)
> 
