From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 5 Jul 2016 15:55:23 +0200
Subject: [PATCH 2/3] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <CAOMZO5CQWz++TVKBKEMSQuyks3C+7Tx5=Frh6R+Qubcab=EbjA@mail.gmail.com>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-3-git-send-email-afaerber@suse.de>
 <CAOMZO5CQWz++TVKBKEMSQuyks3C+7Tx5=Frh6R+Qubcab=EbjA@mail.gmail.com>
Message-ID: <577BBC4B.5040903@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am 05.07.2016 um 14:04 schrieb Fabio Estevam:
> On Tue, Jul 5, 2016 at 1:04 AM, Andreas F?rber <afaerber@suse.de> wrote:
> 
>> +/dts-v1/;
>> +
>> +#include "imx6sx-udoo-neo.dtsi"
>> +
>> +/ {
>> +       model = "UDOO Neo Basic";
> 
> This should be something like:
> 
> model = "Udoo i.MX6 SoloX UDOO Neo Basic";

Why should anyone use such a weird concatenation of names? If you wanted
"UDOO Neo Basic (based on i.MX 6SoloX)" that would be more
understandable, but there is no UDOO Neo Basic board with another SoC:

http://www.udoo.org/udoo-neo/

imx6dl-udoo.dts uses "Udoo i.MX6 Dual-lite Board" and
imx6q-udoo.dts  uses "Udoo i.MX6 Quad Board".

So I'm open to discussing UDOO vs. Udoo spelling, but I don't see a
requirement for mixing board vendor, SoC name and board name.

/proc/cpuinfo displays "Freescale i.MX6 SoloX (Device Tree)" based on
SoC compatible string and mach-imx/mach-imx6sx.c.

Note that NXP calls it "i.MX6SX" or "i.MX 6SoloX" (spacing):

http://www.nxp.com/products/microcontrollers-and-processors/arm-processors/i.mx-applications-processors/i.mx-6-processors/i.mx6qp/i.mx-6solox-processors-heterogeneous-processing-with-arm-cortex-a9-and-cortex-m4-cores:i.MX6SX

>> +       compatible = "fsl,imx6sx";
> 
> compatible = "udoo,imx6sx-udoo-neo", "fsl,imx6sx";
> 
> Then you can also send a separate patch to add udoo to
> Documentation/devicetree/bindings/vendor-prefixes.txt.
> 
> Same applies to other places in this patch.

I know we could add compatibles. But you say it backwards: If I add a
compatible string the vendor _must_ be defined in vendor-prefixes.txt
and the board compatible _must_ be documented, too. Since I saw that
there is no prefix for UDOO in vendor-prefixes.txt nor an arm/udoo.txt
file to document its board compatibles _despite_ "udoo,imx6q-udoo" and
"udoo,imx6dl-udoo" being in use, as an annoyed UDOO Neo owner I'd rather
leave it to UDOO to add those on their own as follow-up if they care.
Their downstream kernel does not have such a compatible string, they use
"fsl,imx6sx-sdb", which looks like a bad case of copy&paste to me.

However, "udoo,neo-basic", "udoo,neo", "fsl,imx6sx" should be sufficient
since unlike the Quad/Dual situation there is no SoC variation here. Or
"seco,udoo-neo"? "udoo,udoo-neo" looks duplicate.

>> +&fec1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_enet1>;
>> +       phy-mode = "rmii";
>> +       phy-reset-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
> 
> Shouldn't this be GPIO_ACTIVE_LOW instead?

Hm, network worked okay for me like this, how do we verify?

Schematics are here: http://www.udoo.org/other-resources/

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
