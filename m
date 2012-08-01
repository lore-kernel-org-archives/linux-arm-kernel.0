From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 1 Aug 2012 17:04:45 +0100
Subject: [PATCH 23/24] hvc_xen: allow dom0_write_console for HVM guests
In-Reply-To: <20120801145413.GR7227@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-23-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120801145413.GR7227@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1208011704000.4645@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Aug 2012, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 26, 2012 at 04:34:05PM +0100, Stefano Stabellini wrote:
> > On ARM all guests are HVM guests, including Dom0.
> > Allow dom0_write_console to be called by an HVM domain.
> 
> Um, but xen_hvm_domain() != xen_pv_domain() so won't this return without
> printing anything?

Nope, it would call dom0_write_console that issues a console hypercall.
However I am going to remove this patch and rely on the simple serial
emulator we have in Xen for early_printk stuff

> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  drivers/tty/hvc/hvc_xen.c |    5 +----
> >  1 files changed, 1 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> > index 3c04fb8..949edc2 100644
> > --- a/drivers/tty/hvc/hvc_xen.c
> > +++ b/drivers/tty/hvc/hvc_xen.c
> > @@ -616,12 +616,9 @@ static void xenboot_write_console(struct console *console, const char *string,
> >  	unsigned int linelen, off = 0;
> >  	const char *pos;
> >  
> > -	if (!xen_pv_domain())
> > -		return;
> > -
> >  	dom0_write_console(0, string, len);
> >  
> > -	if (xen_initial_domain())
> > +	if (!xen_pv_domain())
> >  		return;
> >  
> >  	domU_write_console(0, "(early) ", 8);
> > -- 
> > 1.7.2.5
> 
