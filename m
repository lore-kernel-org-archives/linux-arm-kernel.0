From: robh@kernel.org (Rob Herring)
Date: Sat, 21 Jan 2017 14:21:22 -0600
Subject: [PATCH v3 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
In-Reply-To: <DB5PR0401MB181361EBAD1B2BFA8DC5ED7AFE610@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <1482139554-13618-1-git-send-email-jerry.huang@nxp.com>
 <1482139554-13618-2-git-send-email-jerry.huang@nxp.com>
 <20161222184514.hfd4g7ifrz5cv627@rob-hp-laptop>
 <DB5PR0401MB1813E210B2ADE1C9493F7768FE950@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <CAL_JsqJuifiSQAt-6FgtYYSukAnjzOLuTGEsO-Spn5LxkU-iwQ@mail.gmail.com>
 <DB5PR0401MB181361EBAD1B2BFA8DC5ED7AFE610@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Message-ID: <CAL_JsqJLr7pFSd5DW2ghNmn5-Lggrefp=GMPLOiiQmmqyPU4iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2017 at 8:24 PM, Jerry Huang <jerry.huang@nxp.com> wrote:
> Hi, Rob,
>
>> -----Original Message-----
>> From: Rob Herring [mailto:robh at kernel.org]
>> Sent: Wednesday, January 04, 2017 5:24 AM
>> To: Jerry Huang <jerry.huang@nxp.com>
>> Cc: balbi at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
>> will.deacon at arm.com; linux at armlinux.org.uk; devicetree at vger.kernel.org;
>> linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH v3 2/3] USB3/DWC3: Add property "snps, incr-burst-
>> type-adjustment" for INCR burst type
>>
>> On Thu, Dec 22, 2016 at 8:52 PM, Jerry Huang <jerry.huang@nxp.com> wrote:
>> > Hi, Rob,
>> >> -----Original Message-----
>> >> From: Rob Herring [mailto:robh at kernel.org]
>> >> Sent: Friday, December 23, 2016 2:45 AM
>> >> To: Jerry Huang <jerry.huang@nxp.com>
>> >> Cc: balbi at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
>> >> will.deacon at arm.com; linux at armlinux.org.uk;
>> >> devicetree at vger.kernel.org; linux-usb at vger.kernel.org;
>> >> linux-kernel at vger.kernel.org; linux-arm- kernel at lists.infradead.org
>> >> Subject: Re: [PATCH v3 2/3] USB3/DWC3: Add property "snps,
>> >> incr-burst- type-adjustment" for INCR burst type
>> >>
>> >> On Mon, Dec 19, 2016 at 05:25:53PM +0800, Changming Huang wrote:
>> >> > New property "snps,incr-burst-type-adjustment = <x>, <y>" for
>> >> > USB3.0
>> >> DWC3.
>> >> > Field "x": 1/0 - undefined length INCR burst type enable or not;
>> >> > Field
>> >> > "y": INCR4/INCR8/INCR16/INCR32/INCR64/INCR128/INCR256 burst type.
>> >> >
>> >> > While enabling undefined length INCR burst type and INCR16 burst
>> >> > type, get better write performance on NXP Layerscape platform:
>> >> > around 3% improvement (from 364MB/s to 375MB/s).
>> >> >
>> >> > Signed-off-by: Changming Huang <jerry.huang@nxp.com>
>> >> > ---
>> >> > Changes in v3:
>> >> >   - add new property for INCR burst in usb node.
>> >> >
>> >> >  Documentation/devicetree/bindings/usb/dwc3.txt |    5 +++++
>> >> >  arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
>> >> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>> >> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |    2 ++
>> >> >  4 files changed, 11 insertions(+)
>> >> >
>> >> > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
>> >> > b/Documentation/devicetree/bindings/usb/dwc3.txt
>> >> > index e3e6983..8c405a3 100644
>> >> > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>> >> > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>> >> > @@ -55,6 +55,10 @@ Optional properties:
>> >> >     fladj_30mhz_sdbnd signal is invalid or incorrect.
>> >> >
>> >> >   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be
>> >> reallocated.
>> >> > + - snps,incr-burst-type-adjustment: Value for INCR burst type of
>> >> GSBUSCFG0
>> >> > +   register, undefined length INCR burst type enable and INCRx type.
>> >> > +   First field is for undefined length INCR burst type enable or not.
>> >> > +   Second field is for largest INCRx type enabled.
>> >>
>> >> Why do you need the first field? Is the 2nd field used if the 1st is 0?
>> >> If not, then just use the presence of the property to enable or not.
>> > The first field is one switch.
>> > When it is 1, means undefined length INCR burst type enabled, we can use
>> any length less than or equal to the largest-enabled burst length of
>> INCR4/8/16/32/64/128/256.
>> > When it is zero, means INCRx burst mode enabled, we can use one fixed
>> burst length of 1/4/8/16/32/64/128/256 byte.
>> > So, the 2nd field is used if the 1st is 0, we need to select one largest burst
>> length the USB controller can support.
>> > If we don't want to change the value of this register (use the default value),
>> we don't need to add this property to usb node.
>>
>> Just make this a single value with 0 meaning INCR and 4/8/16/etc being INCRx.
> Maybe, I didn't describe it clearly.
> According to DWC3 spec, the value "0" of field INCRBrstEna means INCRx burst mode, 1 means INCR burst mode.
> Regardless of the value of INCRBrstEna [bit0], we need to modify the other field bit[1,2,3,4,5,6,7] to one INCR burst type  for the platform supported.
> Ad you mentioned, if we just use a single value with 0 meaning INCR and 4/8/16/etc being INCRx.
> I understand totally that when it is none-zero, we can use it for INCR burst mode.
> Then, when it is 0, how to select the INCRx value?

What I mean is:
<no prop> - burst disabled
0 - INCR burst. INCR is undefined length burst IIRC.
4/8/16/etc. - INCR4/INCR8/INCR16/etc.

What case does this not cover?

Rob
