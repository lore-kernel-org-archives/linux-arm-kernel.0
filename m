From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 6 Jan 2012 09:23:35 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <7FE21149F4667147B645348EC605788507F615@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885077F82@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1887@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F615@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE39E40@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng-B29396 wrote at Friday, January 06, 2012 3:51 AM:
> Stephen Warren wrote at Friday, January 06, 2012 7:38 AM:
> > Dong Aisheng-B29396 wrote at Tuesday, December 27, 2011 7:41 AM:
...
> > > But what about the pin maps without device associated?
> >
> > Indeed; that's why I'd tend towards defining a table of pinmux usage in the
> > pinmux node, and having other devices refer to that table.
>
> Currently we still prefer to use device node relationship to reflect the pinmux
> map if we can since as you said pinmux map is little depending on the pinctrl
> subsystem implementation.
> And I'm trying to do it now.
> 
> > Still, if the pinmux definitions are in the device nodes, we could simply make
> > the pinmux controller have such a definition itself too, for the "system hog"
> > case.
>
> Yes, that way I think is like:
> iomuxc at 020e0000 {
>         pinctrl_uart4: uart4 {
>                 grp-pins = <107 108>;
>                 grp-mux = <4 4>;
> 		   hog_on_boot;
>         };
> }

If pinmux usage is defined in each individual device node, and the "hog"
setup is included in the pinmux controller's own device node, then there's
no need for a "hog_on_boot" property; any pinmux setup node that's inside
the pinmux controller node would automatically be a "hog" entry, and
could be activated as soon as the pinmux controller was probed and
registered with the pinctrl subsystem.

(as a minor nit, DT usually uses - not _ in property names, so that would
be "hog-on-boot").

-- 
nvpublic
