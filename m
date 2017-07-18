From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Tue, 18 Jul 2017 23:40:22 +0200
Subject: [PATCH] ARM: zImage: Fix stack overflow in merge_fdt_bootargs()
In-Reply-To: <74e55919-5378-1412-5c20-aae9db56495f@gmail.com>
References: <257f11e3b0010a3a44c28b34a048278f7b960f3b.1500238579.git.rask@formelder.dk>
 <74e55919-5378-1412-5c20-aae9db56495f@gmail.com>
Message-ID: <20170718214022.znbme3ipirwtnuvn@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 09:39:10AM +0200, Richard Genoud wrote:
> On 16/07/2017 23:43, Rask Ingemann Lambertsen wrote:
[snip]
> > +/* This is called early on from head.S, so it can't use much stack. */
> > +static void merge_fdt_bootargs(void *fdt, const char *atag_cmdline)
> > +{
> > +	char *fdt_bootargs;
> > +	int len = 0;
> > +
> > +	/* With no ATAG command line or an empty one, there is nothing to do. */
> > +	if (!atag_cmdline || strlen(atag_cmdline) == 0)
> > +		return;
> > +
> > +	fdt_bootargs = getprop_w(fdt, "/chosen", "bootargs", &len);
> > +
> > +	/* With no FDT command line or an empty one, just use the ATAG one. */
> > +	if (!fdt_bootargs || len <= 1) {
> > +		setprop_string(fdt, "/chosen", "bootargs", atag_cmdline);
> > +		return;
> > +	}
> > +	fdt_bootargs[len - 1] = ' ';
> > +	appendprop_string(fdt, "/chosen", "bootargs", atag_cmdline);
> Let's say appendprop_string() fails for whatever reason, the /chosen
> string won't be null terminated anymore.

Good catch, I will fix that. Thank you for your review.

> Won't it cause some problems ?

It's OK at the moment because the last character of the "bootargs" property
is not used. This is the code from early_init_dt_scan_chosen() in
drivers/of/fdt.c:

	/* Retrieve command line */
	p = of_get_flat_dt_prop(node, "bootargs", &l);
	if (p != NULL && l > 0)
		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));

But not all accesses are that careful. I found get_cmdline() in
arch/arm64/kernel/kaslr.c using

		prop = fdt_getprop(fdt, node, "bootargs", NULL);

so there is an expectation that the string is NUL terminated.

-- 
Rask Ingemann Lambertsen
