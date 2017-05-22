From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 May 2017 08:40:19 +0100
Subject: [DT Question] "simple-mfd" DT binding
In-Reply-To: <CAK7LNARQmfX+3RwFgwtvf2Qu79XNX1zh0O741-pPFWS6npytLw@mail.gmail.com>
References: <CAK7LNARQmfX+3RwFgwtvf2Qu79XNX1zh0O741-pPFWS6npytLw@mail.gmail.com>
Message-ID: <20170522074019.avzk7bc4ttk7bzex@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017, Masahiro Yamada wrote:

> Hi DT experts,
> 
> I have a question about "simple-mfd".
> 
> 
> Documentation/devicetree/bindings/mfd/mfd.txt says as allows:
> 
> ----------------------8<---------------------
> Optional properties:
> 
> - compatible : "simple-mfd" - this signifies that the operating system should
>   consider all subnodes of the MFD device as separate devices akin to how
>   "simple-bus" indicates when to see subnodes as children for a simple
>   memory-mapped bus.   <snip>
> ----------------------8<---------------------
> 
> 
> I'd like to be sure about the statement above.
> 
> Does this mean, "simple-bus" and "simple-mfd" are technically interchangeable?

You can use them interchangeably and they will 'work', but the
implication will be wrong.  Hence why both exist.

> If so, I thought the example some lines below is questionable.
> 
> ---------------------8<---------------------------
> Example:
> 
> foo at 1000 {
>         compatible = "syscon", "simple-mfd";
>         reg = <0x01000 0x1000>;
> 
>         led at 08.0 {
>                 compatible = "register-bit-led";
>                 offset = <0x08>;
>                 mask = <0x01>;
>                 label = "myled";
>                 default-state = "on";
>         };
> };
> ---------------------8<---------------------------
> 
> 
> Because "simple-bus" indicates that child nodes are
> simply memory mapped, but the node "register-bit-led"
> can not be memory-mapped.
> So, "simple-mfd" can not be replaced "simple-bus" here.

Correct.  It would be inappropriate to use "simple-bus" for this use
case.  That is most likely why "simple-mfd" is used instead.

> arch/arm/boot/dts/arm-realview-pb1176.dts is a real example.
> 
> If I replace "simple-mfd" with "simple-bus",
> DTC warns "empty reg/ranges property".
> 
> $ sed -i  -e 's/simple-mfd/simple-bus/'
> arch/arm/boot/dts/arm-realview-pb1176.dts
> $ make -s ARCH=arm defconfig
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- W=1  arm-realview-pb1176.dtb
>    ...
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.0 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.1 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.2 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.3 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.4 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.5 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.6 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/led at 08.7 missing or empty reg/ranges
> property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/osc0 at 0c missing or empty reg/ranges property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/osc1 at 10 missing or empty reg/ranges property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/osc2 at 14 missing or empty reg/ranges property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/osc3 at 18 missing or empty reg/ranges property
> arch/arm/boot/dts/arm-realview-pb1176.dtb: Warning (simple_bus_reg):
> Node /soc/syscon at 10000000/osc4 at 1c missing or empty reg/ranges property

Exactly.  Don't do that. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
