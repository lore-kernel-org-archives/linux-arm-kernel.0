From: btw@mail.itp.ac.cn (Bintian Wang)
Date: Wed, 13 May 2015 15:12:07 +0800 (GMT+08:00)
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon
 Hi6220 SoC
In-Reply-To: <20150506104856.GC707@leverpostej>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
 <5549B9CC.1040709@huawei.com> <20150506093022.GB31001@leverpostej>
 <5549EE97.3020801@huawei.com> <20150506104856.GC707@leverpostej>
Message-ID: <cf6ae9.68c7.14d4c1dc0f6.Coremail.btw@mail.itp.ac.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> Hi,
> 
> > > I think that given that we know the UART is not quite a PL011 we should
> > > add an additional compatible string just in case some difference crops
> > > up later that is problematic.
> > >
> > > So we'd have something like:
> > >
> > > 	compatible = "hisilicon,hi6220-uart", "arm,pl011", "arm,primecell";
> > >
> > > That way we can add any optimisations or workarounds later as required.
> > I understand and thanks for your suggestion.
> > 
> > Can I do not do this work in this patch set? Because I got the
> > information UART0 is PL011 compatible. Hisilicon uart engineer can do
> > this work in the future, maybe for UART1/UART2.
> 
> I am not asking you to do any driver work for this -- the current driver
> should ignore the "hisilicon,hi6220-uart" string and recognise
> "arm,pl011".
> 
> I am only asking you to add the additional string to the DTS, and to
> update the binding document to list the new string. That way if and when
> we need the kernel to distinguish between a regular PL011 and the
> hi6220-specific variant, the DTB does not need to be updated in order to
> do so.
How about add the following binding rule to the 2/5 patch:
---------------------------
*Hisilicon Enhanced ARM AMBA Primecell PL011 serial UART

Required properties:
- compatible: must be "hisilicon,hi6220-uart", "arm,primecell", "arm,pl011"
- reg: exactly one register range with length 0x1000
- interrupts: exactly one interrupt specifier

See also bindings/serial/pl011.txt

Example:

uart0: uart at f8015000 { 
        compatible = "hisilicon,hi6220-uart", "arm,pl011", "arm,primecell";
        reg = <0x0 0xf8015000 0x0 0x1000>;
        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
        clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl HI6220_UART0_PCLK>;
        clock-names = "uartclk", "apb_pclk";
};
---------------------------
 
> Is UART 0 different from UART1 and UART2?
Yes,  but my patch just includes UART0, we do some changements for UART1/2
to improve performance.  

Thanks,

Bintian

> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
