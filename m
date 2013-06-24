From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Jun 2013 20:24:57 +0100
Subject: [PATCH 1/3] clk: Add APM X-Gene SoC clock driver for
 reference, PLL, and device clocks.
In-Reply-To: <CAPw-ZT=2fKtsnkygNmctWop+zRfQE05OgGSFTbjpZxdSD1wQSQ@mail.gmail.com>
References: <1371828605-18053-1-git-send-email-lho@apm.com>
 <1371828605-18053-2-git-send-email-lho@apm.com>
 <20130624084820.GC19489@e106331-lin.cambridge.arm.com>
 <CAPw-ZT=2fKtsnkygNmctWop+zRfQE05OgGSFTbjpZxdSD1wQSQ@mail.gmail.com>
Message-ID: <20130624192457.GB11204@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 06:48:56PM +0100, Loc Ho wrote:
> Hi,
> 
> I will fix them. With regard to continue where the CSR is NULL, it is
> possible to continue as long as both is NOT NULL.

Ah, so one bank of registers might not be present? Given that, it might
be worth using interrupt-names to describe which is present, so that you
don't need to describe a non-existent register bank.

Thanks,
Mark.

> 
> > Use of_iomap(np, 0) here.
> >
> >> +       } else {
> >> +               parameters.csr_reg = NULL;
> >> +       }
> >
> > Are you able to continue if this is the case?
> >
> >> +
> >> +       rc = of_address_to_resource(np, 1, &res);
> >> +       if (rc != 0) {
> >> +               pr_err("no DTS DIV register for %s\n", np->full_name);
> >> +               return;
> >> +       }
> >> +       if (resource_size(&res)) {
> >> +               parameters.divider_reg = ioremap(res.start,
> >> +                                               resource_size(&res));
> >> +               if (parameters.divider_reg == NULL) {
> >> +                       pr_err("Unable to map DIV register for %s\n",
> >> +                               np->full_name);
> >> +                       if (parameters.csr_reg)
> >> +                               iounmap(parameters.csr_reg);
> >> +                       return;
> >> +               }
> >
> > Use of_iomap(np, 1) here.
> >
> >> +       } else {
> >> +               parameters.divider_reg = NULL;
> >> +       }
> >
> > Similarly, are you able to continue with this being the case?
> 
> -Loc
> 
