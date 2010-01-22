From: t.fujak@samsung.com (Tomasz Fujak)
Date: Fri, 22 Jan 2010 14:08:35 +0100
Subject: [PATCH v1 1/1] Extended events (platform-specific) support in perf
In-Reply-To: <20100122122607.GE1244@ghostprotocols.net>
References: <1264162139-26788-1-git-send-email-t.fujak@samsung.com>
	<1264162139-26788-2-git-send-email-t.fujak@samsung.com>
	<20100122122607.GE1244@ghostprotocols.net>
Message-ID: <034a01ca9b64$01863d10$0492b730$%fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Arnaldo Carvalho de
> Melo
> Sent: Friday, January 22, 2010 1:26 PM
> To: Tomasz Fujak
> Cc: jpihet at mvista.com; peterz at infradead.org; p.osciak at samsung.com;
> jamie.iles at picochip.com; will.deacon at arm.com; linux-
> kernel at vger.kernel.org; kyungmin.park at samsung.com; mingo at elte.hu;
> linux-arm-kernel at lists.infradead.org; m.szyprowski at samsung.com
> Subject: Re: [PATCH v1 1/1] Extended events (platform-specific) support
> in perf
> 
> Em Fri, Jan 22, 2010 at 01:08:59PM +0100, Tomasz Fujak escreveu:
> > Signed-off-by: Tomasz Fujak <t.fujak@samsung.com>
> > Reviewed-by: Pawel Osciak <p.osciak@samsung.com>
> > Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Kyungmin Park <kuyngmin.park@samsung.com>
> 
> "Extended" seems vague, I think in this context "platform_" would be a
> better namespace specifier.

Right.

> > +#define	BYTES_PER_CHUNK 4096
> > +/* returns the number of lines read;
> > +   on fail the return is negative and no memory is allocated
> > +   otherwise the *buf contains a memory chunk of which first
> > +   *size bytes are used for file contents
> > + */
> > +static int read_file(int fd, char **buf, unsigned *size)
> > +{
> > +	unsigned bytes = BYTES_PER_CHUNK;
> > +	int lines = 0;
> > +	char *ptr = malloc(bytes);
> 
> malloc can fail... Also why is that you can't process the lines one by
> one instead of reading the whole (albeit small) file at once?

Right, no malloc check.
The purpose of not processing line-by-line is that then the collection needs
to be dynamic.

Since the file buffer gets dropped after it's processed, the overallocated
memory is returned to the system.
In case of the collection (here an array and a counter) it'd require tricks
not to overallocate, and still be O(#events).

But you're right I didn't do it right - in case the a line does not parse,
memory reserved for it is not freed. Fixing.

> > +
> > +		if (name && description) {
> > +			symbols[count].symbol = name;
> > +			symbols[count].alias = "";
> > +			++count;
> > +			/* description gets lost here */
> > +			free(description);
> > +		} else {
> > +			free(description);
> > +			free(name);
> > +		}
> 
> Having "free(description);" in both cases seems funny :-)

I wasn't so bold as to upgrade the perf with human-readable event
description.
Otherwise yes, moving it outside.

> 
> - Arnaldo
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
