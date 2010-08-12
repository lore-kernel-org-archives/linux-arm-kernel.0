From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Aug 2010 16:24:24 +0100
Subject: [PATCH] spi: add spi_tegra driver
In-Reply-To: <AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN@mail.gmail.com>
	<AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
Message-ID: <20100812152424.GB31982@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 05:31:00PM -0700, Erik Gilling wrote:
> >> + ? ? ? if (!request_mem_region(r->start, (r->end - r->start) + 1,
> >> + ? ? ? ? ? ? ? ? ? ? ? dev_name(&pdev->dev))) {
> >> + ? ? ? ? ? ? ? ret = -EBUSY;
> >> + ? ? ? ? ? ? ? goto err0;
> >> + ? ? ? }
> >
> > I believe the platform bus does this for you already by calling
> > insert_resource() on all the platform bus ranges. ?See if /proc/iomem
> > is any different with or without this call to verify.
> 
> You're right.  Didn't realize this

There is a big difference between what the platform bus does and what
drivers do.

The platform bus adds the resources to the resource tree as they stand
without marking them _busy_.  This means that they can be sub-divided
and other resources registered within their range.

request_mem_region() adds resources to the resource tree marking them
busy, detecting overlapping resources and indicating whether two
drivers are trying to claim the same resource region.  In other words,
it's a preventative measure against two device drivers accessing the
same region.

You're absolutely right to do what you're doing above, please continue
to do so.
