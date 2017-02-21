From: Mike.Leach@arm.com (Mike Leach)
Date: Tue, 21 Feb 2017 12:34:25 +0000
Subject: [PATCH] arm64: dts: juno: update definition for programmable
 replicator.
In-Reply-To: <2ba59da5-fc79-ab53-2f2a-2ddc6e5e9c3d@arm.com>
References: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
 <2ba59da5-fc79-ab53-2f2a-2ddc6e5e9c3d@arm.com>
Message-ID: <DB6PR0802MB219850A35C8DAD5CB2858C1C8C510@DB6PR0802MB2198.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep

> -----Original Message-----
> From: CoreSight [mailto:coresight-bounces at lists.linaro.org] On Behalf Of
> Sudeep Holla
> Sent: 21 February 2017 11:03
> To: Mike Leach; linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org; coresight at lists.linaro.org;
> robh+dt at kernel.org; Sudeep Holla
> Subject: Re: [PATCH] arm64: dts: juno: update definition for programmable
> replicator.
>
> Hi Mike,
>
> On 17/02/17 19:13, Mike Leach wrote:
> > Juno platforms have a programmable replicator splitting the trace
> > output to TPIU and ETR. Currently this is not being programmed as it
> > is being treated as a none-programmable replicator - which is the
> > default operational mode for these devices. The TPIU in the system is
> > enabled by default, and this combination is causing back-pressure in
> > the trace system resulting in overflows at the source.
> >
> > Replaces the existing definition with one that defines the
> > programmable replicator, using the "qcom,coresight-replicator1x"
> > driver that provides the correct functionality for CoreSight programmable
> replicators.
> >
>
> I assume this is just enhancement and not a fix.

I guess it depends on your point of view - with this update the trace overflows I was seeing disappear, as the trace path to TPIU is blocked.
So it affects the quality of collected trace using the ETR rather than a binary didn't work / works now change.

>  Since it's too late for
> v4.11 (already in merge window now), I will queue this for v4.12
>

Thanks.

Mike



> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  arch/arm64/boot/dts/arm/juno-base.dtsi | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi
> > b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > index 9d799d9..6546e23 100644
> > --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> > +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > @@ -372,12 +372,14 @@
> >  };
> >  };
> >
> > -coresight-replicator {
> > -/*
> > - * Non-configurable replicators don't show up on the
> > - * AMBA bus.  As such no need to add "arm,primecell".
> > - */
> > -compatible = "arm,coresight-replicator";
> > +coresight-replicator at 20120000 {
> > +
> > +compatible = "qcom,coresight-replicator1x", "arm,primecell";
> > +reg = <0 0x20120000 0 0x1000>;
> > +
> > +clocks = <&soc_smc50mhz>;
> > +clock-names = "apb_pclk";
> > +power-domains = <&scpi_devpd 0>;
> >
> >  ports {
> >  #address-cells = <1>;
> >
>
> --
> Regards,
> Sudeep
> _______________________________________________
> CoreSight mailing list
> CoreSight at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
