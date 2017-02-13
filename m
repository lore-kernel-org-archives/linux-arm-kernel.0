From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 13 Feb 2017 07:05:07 -0800
Subject: [PATCH] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170209212620.3xn3pom5oeiqnaf5@rob-hp-laptop>
References: <20170206150529.9697-1-andrew.smirnov@gmail.com>
 <20170209212620.3xn3pom5oeiqnaf5@rob-hp-laptop>
Message-ID: <CAHQ1cqGtGdRUwvqfiXbjHjQ0uMNWejLxxWD_bCGAmQGfb3wD4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2017 at 1:26 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Feb 06, 2017 at 07:05:29AM -0800, Andrey Smirnov wrote:
>> Add code allowing for control of various power domains managed by GPCv2
>> IP block found in i.MX7 series of SoCs. Power domains covered by this
>> patch are:
>>
>>     - PCIE PHY
>>     - MIPI PHY
>>     - USB HSIC PHY
>>     - USB OTG1/2 PHY
>>
>> Support for any other power domain controlled by GPC is not present, and
>> can be added at some later point.
>>
>> Testing of this code was done against a PCIe driver.
>>
>> Cc: yurovsky at gmail.com
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>
>> Shawn:
>>
>> Since this driver was modlelled after analogous driver for i.MX6 from
>> Lucas Stach
>>
>> https://www.spinics.net/lists/arm-kernel/msg558548.html
>>
>> I made this patch to be applied on top of his. Please let me know if
>> that was a bad idea.
>>
>>
>>  .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  73 ++++
>>  drivers/soc/imx/Makefile                           |   2 +-
>>  drivers/soc/imx/gpcv2.c                            | 380 +++++++++++++++++++++
>>  include/dt-bindings/power/imx7-power.h             |  18 +
>>  4 files changed, 472 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
>>  create mode 100644 drivers/soc/imx/gpcv2.c
>>  create mode 100644 include/dt-bindings/power/imx7-power.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
>> new file mode 100644
>> index 0000000..949e190
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
>> @@ -0,0 +1,73 @@
>> +Freescale i.MX General Power Controller v2
>> +==========================================
>> +
>> +The i.MX7S/D General Power Control (GPC) block contains Power Gating
>> +Control (PGC) for various power domains.
>> +
>> +Required properties:
>> +
>> +- compatible: Should be "fsl,imx7d-gpc"
>> +
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +
>> +- interrupts: Should contain GPC interrupt request 1
>> +
>> +- #power-domain-cells: Should be 1, see below:
>
> Should be 1 or ...

This is an oversight on my part. The property is not needed for that
node at all. Will fix in v2.

>
>> +
>> +Power domains contained within GPC node are generic power domain
>> +providers, documented in
>> +Documentation/devicetree/bindings/power/power_domain.txt, which are
>> +described as subnoded of the power gating controller 'pgc' node,
>
> s/subnoded/subnodes/

Ugh. Sorry about that, will fix in v2.

>
>> +which, in turn, is expected to conatine the following:
>
> s/conatine/contain/

Ditto.

>
>> +
>> +Required properties:
>> +
>> +- reg: Power domain index. Valid values are defined in
>> +  include/dt-bindings/power/imx7-power.h
>> +
>> +- #power-domain-cells: Should be 0
>
> ... 0?

Yeah, I can see how my description is confusing. This one is correct
though and hopefully with the first mention of the property gone the
description should become clear.

Thanks,
Andrey Smirnov
