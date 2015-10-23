From: lho@apm.com (Loc Ho)
Date: Thu, 22 Oct 2015 17:21:39 -0700
Subject: [PATCH RFC v2] apei: Add ACPI APEI event notification support
In-Reply-To: <20151022095716.GC3671@pd.tnic>
References: <1445458480-6493-1-git-send-email-lho@apm.com>
 <20151022095716.GC3671@pd.tnic>
Message-ID: <CAPw-ZTkhrQ0P8Y8LxpeOW+uG1uVbAo+-cAAmQHGL1eBpkXc4bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

>
> Ok, so what's the strategy here?
>
> I know Tomasz did some untangling of GHES stuff to make it load on ARM
> too and be arch-agnostic. The registration code in it is more than the
> tiny edac_apei_irq_handler().
>
> So why is this thing a separate driver? It is called EDAC_APEI although
> it is ARM-specific.
>
> Why can't it be part of ghes_edac.c with ARM-specific section, if
> absolutely needed?
>
> If this is going to implement the ACPI spec, then I don't see anything
> vendor-, or arch-specific getting in the way except maybe that APMC0D51
> id.
>
> Hmmm?

Tuan and I looked over the ghes.c code and it does seems to have most
of the stuff that we need. The only issue that we have is how to clear
the interrupt. With our HW, the hardware error source record isn't
really hardware but some memory table. Clearing the GHES table doesn't
clear the interrupt. If there is an method in which one can call in
function ghes_irq_func to clear the interrupt, it would work for us. I
am thinking one possible solution is to add an AML method. But in
order to call an AML method, one need an device node - which in turn
will requires another small piece of code (like the second version of
the driver). Any suggestion anyone?

-Loc
