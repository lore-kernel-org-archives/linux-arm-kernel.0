From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 25 Dec 2016 23:08:15 +0100
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <201612161242.34764@pali>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <20161215100931.GJ14217@n2100.armlinux.org.uk> <201612161242.34764@pali>
Message-ID: <201612252308.15324@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 December 2016 12:42:34 Pali Roh?r wrote:
> On Thursday 15 December 2016 11:09:32 Russell King - ARM Linux wrote:
> > > What is reason that CONFIG_CMDLINE is not supported for DT?
> > 
> > Sorry, that's my mistake - as you've pointed out above, it is
> > supported but via generic code.  I was only looking at arch code
> > when I made the statement.
> > 
> > This patch (untested) should solve it:
> >  drivers/of/fdt.c | 40 ++++++++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index c89d5d231a0e..fb89157332c6 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1073,26 +1073,6 @@ int __init
> > early_init_dt_scan_chosen(unsigned long node, const char *uname,
> > if (p != NULL && l > 0)
> > 
> >  		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
> > 
> > -	/*
> > -	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> > -	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
> > -	 * is set in which case we override whatever was found earlier.
> > -	 */
> > -#ifdef CONFIG_CMDLINE
> > -#if defined(CONFIG_CMDLINE_EXTEND)
> > -	strlcat(data, " ", COMMAND_LINE_SIZE);
> > -	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > -#elif defined(CONFIG_CMDLINE_FORCE)
> > -	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > -#else
> > -	/* No arguments from boot loader, use kernel's  cmdl*/
> > -	if (!((char *)data)[0])
> > -		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > -#endif
> > -#endif /* CONFIG_CMDLINE */
> > -
> > -	pr_debug("Command line is: %s\n", (char*)data);
> > -
> > 
> >  	/* break now */
> >  	return 1;
> >  
> >  }
> > 
> > @@ -1205,6 +1185,26 @@ void __init early_init_dt_scan_nodes(void)
> > 
> >  	/* Retrieve various information from the /chosen node */
> >  	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
> > 
> > +	/*
> > +	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> > +	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
> > +	 * is set in which case we override whatever was found earlier.
> > +	 */
> > +#ifdef CONFIG_CMDLINE
> > +#if defined(CONFIG_CMDLINE_EXTEND)
> > +	strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > +	strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > +#elif defined(CONFIG_CMDLINE_FORCE)
> > +	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > +#else
> > +	/* No arguments from boot loader, use kernel's cmdline */
> > +	if (!boot_command_line[0])
> > +		strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > +#endif
> > +#endif /* CONFIG_CMDLINE */
> > +
> > +	pr_debug("Command line is: %s\n", boot_command_line);
> > +
> > 
> >  	/* Initialize {size,address}-cells info */
> >  	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> 
> Patch is working fine and fixes my problem. You can add my Tested-by.

Russell, are you going to use your patch? Or original my? Or any other?
If you need more testing or other data, let me know.

I would like to see this problem (non working CONFIG_CMDLINE) fixed...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161225/1962bb36/attachment.sig>
