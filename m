From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 2 May 2016 13:42:12 +0530
Subject: [PATCH v2 2/5] ARM: dts: vfxxx: Add device tree node for OCOTP
In-Reply-To: <4759698.elnRBldlxl@wuerfel>
References: <cover.1462171989.git.maitysanchayan@gmail.com>
 <b5c1ff5a805eae3e53f07f8d0161f0af51586c00.1462171990.git.maitysanchayan@gmail.com>
 <4759698.elnRBldlxl@wuerfel>
Message-ID: <20160502081211.GA7847@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 16-05-02 09:31:12, Arnd Bergmann wrote:
> On Monday 02 May 2016 12:35:01 Sanchayan Maity wrote:
> > +                       ocotp at 400a5000 {
> > +                               compatible = "fsl,vf610-ocotp";
> > +                               #address-cells = <1>;
> > +                               #size-cells = <1>;
> > +                               reg = <0x400a5000 0xCF0>;
> > +                               clocks = <&clks VF610_CLK_OCOTP>;
> > +
> > +                               ocotp_cfg0: cfg0 at 410 {
> > +                                       reg = <0x410 0x4>;
> > +                               };
> > +
> > +                               ocotp_cfg1: cfg1 at 420 {
> > +                                       reg = <0x420 0x4>;
> > +                               };
> > +                       };
> 
> How do the registers of the child nodes relate to the registers of the
> parent? If there are in the same address space, it might be good to
> add a "ranges" property to describe it.

cfg0 and cfg1 are in the same address space viz. 0x400a5410 and 0x400a5420
respectively. These nodes are primarily for use by the NVMEM consumer API in
the SoC bus driver to retrieve the values from these registers leveraging
the NVMEM vf610 ocotp driver.

Based on the NVMEM bindings here
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/nvmem/nvmem.txt#L33

Thanks.

Regards,
Sanchayan.

> 
> 	Arnd

> Date: Mon, 02 May 2016 12:02:21 +1000
> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
> To: Rob Herring <robherring2@gmail.com>
> Cc: "devicetree at vger.kernel.org" <devicetree@vger.kernel.org>,
>  aik at ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely
>  <grant.likely@linaro.org>, "linux-pci at vger.kernel.org"
>  <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
>  linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dja at axtens.net
> Subject: Re: [PATCH v8 40/45] drivers/of: Split unflatten_dt_node()
> 
> On Wed, Feb 17, 2016 at 08:30:42AM -0600, Rob Herring wrote:
> >On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> >> The function unflatten_dt_node() is called recursively to unflatten
> >> device nodes and properties in the FDT blob. It looks complicated
> >> and hard to be understood.
> >>
> >> This splits the function into 3 functions: populate_properties(),
> >> populate_node() and unflatten_dt_node(). populate_properties(),
> >> which is called by populate_node(), creates properties for the
> >> indicated device node. The later one creates the device nodes
> >> from FDT blob. populate_node() gets the offset in FDT blob for
> >> next device nodes and then calls populate_node(). No logical
> >> changes introduced.
> >>
> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> ---
> >>  drivers/of/fdt.c | 249 ++++++++++++++++++++++++++++++++-----------------------
> >>  1 file changed, 147 insertions(+), 102 deletions(-)
> >
> >One nit, otherwise:
> >
> >Acked-by: Rob Herring <robh@kernel.org>
> >
> >[...]
> >
> >> +               /* And we process the "ibm,phandle" property
> >> +                * used in pSeries dynamic device tree
> >> +                * stuff
> >> +                */
> >> +               if (!strcmp(pname, "ibm,phandle"))
> >> +                       np->phandle = be32_to_cpup(val);
> >> +
> >> +               pp->name   = (char *)pname;
> >> +               pp->length = sz;
> >> +               pp->value  = (__be32 *)val;
> >
> >This cast should not be needed.
> >
> 
> It's needed. Otherwise, we will have warning. So I will keep it. I just
> went through this one for next revision and sorry for late response.
> 
> drivers/of/fdt.c:225:14: warning: assignment discards ?const? qualifier from pointer target type
>    pp->value  = val;
>               ^
> 
> Thanks,
> Gavin
> 
> >> +               *pprev     = pp;
> >> +               pprev      = &pp->next;
> >> +       }
> >
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
