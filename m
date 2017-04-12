From: joe@perches.com (Joe Perches)
Date: Wed, 12 Apr 2017 09:40:03 -0700
Subject: [PATCH V14 02/10] ras: acpi/apei: cper: generic error data
 entry v3 per ACPI 6.1
In-Reply-To: <20170412133447.n2yft7v266v6k6gh@pd.tnic>
References: <1490729440-32591-1-git-send-email-tbaicar@codeaurora.org>
 <1490729440-32591-3-git-send-email-tbaicar@codeaurora.org>
 <20170412133447.n2yft7v266v6k6gh@pd.tnic>
Message-ID: <1492015203.28586.1.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-12 at 15:34 +0200, Borislav Petkov wrote:
> On Tue, Mar 28, 2017 at 01:30:32PM -0600, Tyler Baicar wrote:
> > Currently when a RAS error is reported it is not timestamped.
[]
> > diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
[]
> > +#define acpi_hest_generic_data_error_length(gdata)	\
> > +	(((struct acpi_hest_generic_data *)(gdata))->error_data_length)
> > +#define acpi_hest_generic_data_size(gdata)		\
> > +	((acpi_hest_generic_data_version(gdata) >= 3) ?	\
> > +	sizeof(struct acpi_hest_generic_data_v300) :	\
> > +	sizeof(struct acpi_hest_generic_data))
> > +#define acpi_hest_generic_data_record_size(gdata)	\
> > +	(acpi_hest_generic_data_size(gdata) +		\
> > +	acpi_hest_generic_data_error_length(gdata))
> > +#define acpi_hest_generic_data_next(gdata)		\
> > +	((void *)(gdata) + acpi_hest_generic_data_record_size(gdata))
> 
> This is one unreadable pile of too long names with a clearly redundant
> and too long prefix. Please shorten it all.

Naming is generally author's choice and internal
consistency has value too.

acpi_hest_generic<foo> is already used throughout this codebase
in multiple files and paths.

> > @@ -73,3 +85,13 @@ static inline void ghes_edac_unregister(struct ghes *ghes)
> >  {
> >  }
> >  #endif
> > +
> > +#define acpi_hest_generic_data_version(gdata)			\
> > +	(gdata->revision >> 8)
> > +
> > +static inline void *acpi_hest_generic_data_payload(struct acpi_hest_generic_data *gdata)
> 
> Lemme try to shorten it:
> 
> static inline void *acpi_hest_get_payload(struct acpi_hest_gdata *d)
> {
> 	if (hest_gdata_ver(d) >= 3)
> 		return (void *)(((struct acpi_hest_gdata_v3 *)d) + 1);
> 	else
> 		return d + 1;
> }
> 
> Now this is much more readable IMO. You can actually see what's going
> on. And you still know what the struct names are.

trivial: unnecessary cast to void *
