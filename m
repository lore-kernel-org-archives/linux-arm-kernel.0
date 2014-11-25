From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 25 Nov 2014 11:17:24 +0000
Subject: [PATCH] of: support passing console options with stdout-path
In-Reply-To: <20141125103504.GA21525@leverpostej>
References: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
 <20141125103504.GA21525@leverpostej>
Message-ID: <20141125111724.GC2361@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 10:35:04AM +0000, Mark Rutland wrote:
> On Mon, Nov 24, 2014 at 10:23:58PM +0000, Leif Lindholm wrote:
> > Support specifying console options (like with console=ttyXN,<options>)
> > by appending them to the stdout-path property after a separating ':'.
> > 
> > Example:
> > 	stdout-path = "uart0:115200";
> 
> I would very much like to be able to use this -- it will allow
> distributions to boot on a board without having to know _anything_ about
> the console UART until userspace is up, which would make it possible to
> have a completely generic installer image, without requiring the
> platform to provide bootargs.
> 
> My only concern is that this conflates the set of kernel command line
> options for the UART wit the DT binding for it. I don't know how good
> people are at keeping those options stable, and I know they are
> currently not documented -- we would need to add a stdout-path options
> section to relevant UART bindings.

I don't disagree.

Current options are fairly well defined and stable, at least for any
driver that uses uart_parse_options() (documented in
Documentation/serial/driver).

>From drivers/tty/serial/serial_core.c:

* uart_parse_options decodes a string containing the serial console
* options.  The format of the string is <baud><parity><bits><flow>,
* eg: 115200n8r

/
    Leif 
> 
> > 
> > This patch also modifies of_find_node_by_path() to match only the
> > portion of the path before a ':'.
> > 
> > Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> > ---
> >  drivers/of/base.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 3823edf..89c6b33 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -37,6 +37,7 @@ EXPORT_SYMBOL(of_allnodes);
> >  struct device_node *of_chosen;
> >  struct device_node *of_aliases;
> >  struct device_node *of_stdout;
> > +static char *of_stdout_options;
> >  
> >  struct kset *of_kset;
> >  
> > @@ -703,6 +704,8 @@ static struct device_node *__of_find_node_by_path(struct device_node *parent,
> >  	if (!len)
> >  		return NULL;
> >  
> > +	len = strchrnul(path, ':') - path;
> > +
> >  	__for_each_child_of_node(parent, child) {
> >  		const char *name = strrchr(child->full_name, '/');
> >  		if (WARN(!name, "malformed device_node %s\n", child->full_name))
> > @@ -747,6 +750,8 @@ struct device_node *of_find_node_by_path(const char *path)
> >  		if (!of_aliases)
> >  			return NULL;
> >  
> > +		len = strchrnul(path, ':') - path;
> > +
> >  		for_each_property_of_node(of_aliases, pp) {
> >  			if (strlen(pp->name) == len && !strncmp(pp->name, path, len)) {
> >  				np = of_find_node_by_path(pp->value);
> > @@ -1830,8 +1835,12 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
> >  			name = of_get_property(of_chosen, "linux,stdout-path", NULL);
> >  		if (IS_ENABLED(CONFIG_PPC) && !name)
> >  			name = of_get_property(of_aliases, "stdout", NULL);
> > -		if (name)
> > +		if (name) {
> >  			of_stdout = of_find_node_by_path(name);
> > +			of_stdout_options = strchr(name, ':');
> > +			if (of_stdout_options != NULL)
> > +				of_stdout_options++;
> > +		}
> >  	}
> >  
> >  	if (!of_aliases)
> > @@ -1957,7 +1966,7 @@ bool of_console_check(struct device_node *dn, char *name, int index)
> >  {
> >  	if (!dn || dn != of_stdout || console_set_on_cmdline)
> >  		return false;
> > -	return !add_preferred_console(name, index, NULL);
> > +	return !add_preferred_console(name, index, of_stdout_options);
> >  }
> >  EXPORT_SYMBOL_GPL(of_console_check);
> >  
> > -- 
> > 1.9.1
> > 
> > 
