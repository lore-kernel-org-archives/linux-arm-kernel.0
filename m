From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Jan 2017 16:12:26 -0600
Subject: [PATCH V6 4/5] LPC: Support the device-tree LPC host on
 Hip06/Hip07
In-Reply-To: <1485241525-201782-5-git-send-email-yuanzhichang@hisilicon.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-5-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <20170127221226.wlii3fv7tm4to7ie@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 03:05:24PM +0800, zhichang.yuan wrote:
> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
> I/O port addresses. This patch implements the LPC host controller driver which
> perform the I/O operations on the underlying hardware.
> We don't want to touch those existing peripherals' driver, such as ipmi-bt. So
> this driver applies the indirect-IO introduced in the previous patch after
> registering an indirect-IO node to the indirect-IO devices list which will be
> searched in the I/O accessors.
> As the I/O translations for LPC children depend on the host I/O registration,
> we should ensure the host I/O registration is finished before all the LPC
> children scanning. That is why an arch_init() hook was added in this patch.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
>  MAINTAINERS                                        |   9 +
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |   4 +
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi           |  14 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/bus/Kconfig                                |   8 +
>  drivers/bus/Makefile                               |   1 +
>  drivers/bus/hisi_lpc.c                             | 599 +++++++++++++++++++++
>  7 files changed, 668 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>  create mode 100644 drivers/bus/hisi_lpc.c
