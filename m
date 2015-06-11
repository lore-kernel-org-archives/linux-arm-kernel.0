From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 11 Jun 2015 08:50:56 +0200
Subject: [PATCH 1/2] scatterlist: use sg_phys()
In-Reply-To: <CAPcyv4gat8TG9YnHmvD_7A7RD00Urn=febCj2Uc_cVcPi+fnCg@mail.gmail.com>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150610093252.GA20384@8bytes.org>
 <CAPcyv4gat8TG9YnHmvD_7A7RD00Urn=febCj2Uc_cVcPi+fnCg@mail.gmail.com>
Message-ID: <20150611065056.GG20384@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 09:00:31AM -0700, Dan Williams wrote:
> > So sg_phys() turns out to be 'page_to_phys(sg_page(s)) + s->offset',
> > which makes the above statement to:
> >
> >         page_to_phys(sg_page(s)) + s->offset - s->offset;
> >
> > The compiler will probably optimize that away, but it still doesn't look
> > like an improvement.
> 
> The goal is to eventually stop leaking struct page deep into the i/o
> stack.  Anything that relies on being able to retrieve a struct page
> out of an sg entry needs to be converted.  I think we need a new
> helper for this case "sg_phys_aligned()?".

You still have a reference to a struct page, because sg_phys() calls
sg_page() too. If you want to get rid of sg_page() something like
sg_pfn() migth be a more workable solution than sg_phys_(page_)aligned.

But maybe I am just missing the bigger scope of this, so I agree with
Russell that it is better so see a patch series which shows the
direction you want to go with this.


	Joerg
