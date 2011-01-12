From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 09:17:16 +0000
Subject: [PATCH v2] ARM: Change misleading warning when
	CONFIG_CMDLINE_FORCE is used
In-Reply-To: <20110112081147.GA24920@pengutronix.de>
References: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
	<20110112081147.GA24920@pengutronix.de>
Message-ID: <20110112091716.GU11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 09:11:47AM +0100, Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 336f14e..eed2425 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -649,15 +649,17 @@ static int __init parse_tag_revision(const struct tag *tag)
> >  
> >  __tagtable(ATAG_REVISION, parse_tag_revision);
> >  
> > -#ifndef CONFIG_CMDLINE_FORCE
> >  static int __init parse_tag_cmdline(const struct tag *tag)
> >  {
> > +#ifndef CONFIG_CMDLINE_FORCE
> >  	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
> > +#else
> > +	pr_warning("Ignoring tag cmdline (using the default kernel command line)\n");
> > +#endif /* CONFIG_CMDLINE_FORCE */
> Does it make sense at all to disable CONFIG_CMDLINE_FORCE?  If not, I
> suggest to remove it.

Eeh?  Do you understand what CONFIG_CMDLINE_FORCE is and what effect it
has?

When CONFIG_CMDLINE_FORCE is enabled, we ignore the command line passed
in from the boot loader and always use the built-in command line.  When
CONFIG_CMDLINE_FORCE is disabled, we will use the boot loader supplied
command line if present.

"Does it make sense at all to disable CONFIG_CMDLINE_FORCE" so, if you
always have it enabled, you can never pass in a command line from a boot
loader.  That's an absolutely idiotic idea.

_Most_ of us want to pass in command lines from the boot loader so we can
configure things.

Please, if you don't understand, ask questions rather than making
completely misleading review comments which may confuse patch submitters.
