From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Thu, 14 Aug 2014 14:45:45 +0000
Subject: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <87a9774lf5.fsf@nvidia.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
 <87a9774lf5.fsf@nvidia.com>
Message-ID: <cfb1d2ff66004685b7ead3f5e6321681@BL2PR03MB468.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> bounces at lists.linux-foundation.org] On Behalf Of Hiroshi Doyu
> Sent: Thursday, August 14, 2014 12:18 PM
> To: Thierry Reding; Stephen Warren; Arnd Bergmann; Will Deacon
> Cc: Mark Rutland; devicetree at vger.kernel.org; Olof Johansson;
> iommu at lists.linux-foundation.org; Rob Herring; linux-tegra at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
> 
> 
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > +Multiple-master IOMMU:
> > +----------------------
> > +
> > +       iommu {
> > +               /* the specifier represents the ID of the master */
> > +               #iommu-cells = <1>;
> > +       };
> > +
> > +       master at 1 {
> > +               /* device has master ID 42 in the IOMMU */
> > +               iommus = <&{/iommu} 42>;
> > +       };
> > +
> > +       master at 2 {
> > +               /* device has master IDs 23 and 24 in the IOMMU */
> > +               iommus = <&{/iommu} 23>, <&{/iommu} 24>;
> > +       };
> 
> I think that this "master ID" will be parsed in IOMMU driver. For example,
> ARM,SMMU expects "streamID" as "master ID", right?
> 
> If a SoC has a feature to configure to assign streamID to devices at runtime,
> "streamID" is not equal to "master ID".
> 
>   iommus = <&{/smmu} "soc specific master ID">;
> 
> "soc master ID" needs to be translated into "streamID" by SoC SW. It seems
> that ARM,SMMU kernel driver doesn't expect this kind of ID translation. If
> ARM,SMMU kernel driver is used as is, "soc master ID"
> would be incompatible? ARM,SMMU needs such translation before parsing. Is
> this my understanding right?
> 
> If so I think that this master ID configuration/translation may be quite
> reasonable requirment for SoC using ARM,SMMU.
> 
> Can we consider this ID translation within ARM,SMMU compatibility?
> 
> IOW, is it possible to implement some SoC specific hook for ID
> translation/configuration in ARM,SMMU kernel driver?


Can the id translation be done using a SMR mask? Also, for dynamic stream ID allocation we would need to represent the specific master register (to store the stream ID) in the device tree.

-Varun
