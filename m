From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Nov 2015 14:18:16 +0000
Subject: [PATCH RFC v2] apei: Add ACPI APEI event notification support
In-Reply-To: <20151022095716.GC3671@pd.tnic>
References: <1445458480-6493-1-git-send-email-lho@apm.com>
 <20151022095716.GC3671@pd.tnic>
Message-ID: <20151119141816.GH22786@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Thanks Boris for CC'ing me]

Hi all,

Sorry for the delay on this, I had to do some research and this isn't
really my area of expertise.

On Thu, Oct 22, 2015 at 11:57:16AM +0200, Borislav Petkov wrote:
> I'm top-posting here because I'm adding some more ARM people to CC and
> would like for them to see the whole thing.
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

I think you've hit the nail on the head. As far as I can tell, this is
*not* conformant to ACPI APEI (which should be platform and architecture
agnostic) and is actually an implementation-specific interface. However,
I'm happy to be proven wrong if somebody can point me at a document
describing ACPI APEI in a way that matches this implementation.

> > +static const struct acpi_device_id edac_apei_match[] = {
> > +	{ "APMC0D51", 0},
> > +	{},

This, in particular, gives the game away methinks.

Will
