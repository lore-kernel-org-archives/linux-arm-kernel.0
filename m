From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 24 Jul 2017 10:22:39 +0100
Subject: [PATCH 2/4] ACPI: Make acpi_dev_get_resources() method agnostic
In-Reply-To: <24234737.CuhWYzNn5W@aspire.rjw.lan>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <20170720144517.32529-3-lorenzo.pieralisi@arm.com>
 <24234737.CuhWYzNn5W@aspire.rjw.lan>
Message-ID: <20170724092239.GC13145@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 12:05:39AM +0200, Rafael J. Wysocki wrote:
> On Thursday, July 20, 2017 03:45:14 PM Lorenzo Pieralisi wrote:
> > The function acpi_dev_get_resources() is completely generic and
> > can be used to parse resource objects that are not necessarily
> > coming from the _CRS method but also from other objects eg _DMA
> > that have the same _CRS resource format.
> > 
> > Create an acpi_dev_get_resources() helper, internal to the ACPI
> > resources parsing compilation unit, acpi_dev_get_resources_method(),
> > that takes a char* parameter to detect which ACPI method should be
> > called to retrieve the resources list and make acpi_dev_get_resources()
> > call it with a method name _CRS leaving the API behaviour unchanged.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > ---
> >  drivers/acpi/resource.c | 54 +++++++++++++++++++++++++++++--------------------
> >  1 file changed, 32 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index cd4c427..2b20a09 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -573,6 +573,36 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
> >  	return AE_OK;
> >  }
> >  
> > +static
> > +int acpi_dev_get_resources_method(struct acpi_device *adev,
> 
> Do not break lines like this, please.
> 
> It should be
> 
> static int acpi_dev_get...
> 
> Also I would call it differently, maybe simply __acpi_dev_get_resources()?

Ok, it was how I wanted to call it but was not sure you would be happy
with it, I will rename it.

> > +				  struct list_head *list,
> > +				  int (*preproc)(struct acpi_resource *, void *),
> > +				  void *preproc_data, char *method)
> 
> const char *method ?

Yes, will update.

Thanks !
Lorenzo
