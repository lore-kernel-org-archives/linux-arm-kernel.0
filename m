From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 13 Jun 2018 13:58:41 +0200
Subject: [PATCH v1 2/4] dt-bindings: mailbox: provide imx-mailbox
 documentation
In-Reply-To: <CAA+hA=RNxUHro_92YdORw7FOHba=ZSv4q697npCNKwoMG-_HMw@mail.gmail.com>
References: <20180601065821.28234-1-o.rempel@pengutronix.de>
 <20180601065821.28234-3-o.rempel@pengutronix.de>
 <CAA+hA=RNxUHro_92YdORw7FOHba=ZSv4q697npCNKwoMG-_HMw@mail.gmail.com>
Message-ID: <32ca8af2-7df7-4006-fbe1-f26077cbf455@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13.06.2018 13:05, Dong Aisheng wrote:
> Hi Oleksij,
> 
> Some more comments besides Rob's:
> 
> On Fri, Jun 1, 2018 at 2:58 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  .../bindings/mailbox/imx-mailbox.txt          | 35 +++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
>> new file mode 100644
>> index 000000000000..a45604b33039
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
>> @@ -0,0 +1,35 @@
>> +i.MX Messaging Unit
>> +===================
>> +
>> +The i.MX Messaging Unit (MU) contains two register sets: "A" and "B". In most cases
>> +they are accessible from all Processor Units. On one hand, at least for mailbox functionality,
>> +it makes no difference which application or processor is using which set of the MU. On
>> +other hand, the register sets for each of the MU parts are not identical.
>> +
>> +Required properties:
>> +- compatible : Shell be one of:
>> +                    "fsl,imx7s-mu-a" and "fsl,imx7s-mu-b" for i.MX7S or i.MX7D
> 
> What's current requirement to distinguish Side A and B?
> I see current code, side A only does extra clear of xCR register but none for B.
> Is this a generic approach or something customized?

A and B side have more then one BIT difference, and there is no way to
see the difference by software. Current driver do not make use of it,
but in devicetree we describe HW not SW. If HW is different, it should
have different compatibles.

> BTW can we name it more generically?e.g. fsl,imx7s-mu.
> And using a property to indicate whether it's side A or B if really required.
> 
> Furthermore, AFAIK MX7 MU is derived from MX6SX.
> Should we add and use fsl,imx6sx-mu instead?

As soon as some one will test this driver on imx6sx and confirm it
working, i'll add fsl,imx6sx-mu-a/b as well.

> e.g.
>  - compatible : Shell be one of:
>                        "fsl,imx6sx-mu" and "fsl,imx7s-mu".
> 
> Regards
> Dong Aisheng
> 
>> +- reg :        physical base address of the mailbox and length of
>> +               memory mapped region.
>> +- #mbox-cells: Common mailbox binding property to identify the number
>> +               of cells required for the mailbox specifier. Should be 1.
>> +- interrupts : interrupt number. The interrupt specifier format
>> +               depends on the interrupt controller parent.
>> +- clocks     :  phandle to the input clock.
>> +
>> +Example:
>> +       mu0a: mu at 30aa0000 {
>> +               compatible = "fsl,imx7s-mu-a";
>> +               reg = <0x30aa0000 0x28>;
>> +               interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&clks IMX7D_MU_ROOT_CLK>;
>> +               #mbox-cells = <1>;
>> +       };
>> +
>> +       mu0b: mu at 30ab0000 {
>> +               compatible = "fsl,imx7s-mu-b";
>> +               reg = <0x30ab0000 0x28>;
>> +               interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&clks IMX7D_MU_ROOT_CLK>;
>> +               #mbox-cells = <1>;
>> +       };
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180613/a91c9c57/attachment-0001.sig>
