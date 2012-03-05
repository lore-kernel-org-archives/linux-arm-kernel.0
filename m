From: jason@lakedaemon.net (Jason)
Date: Sun, 4 Mar 2012 19:17:13 -0500
Subject: [PATCH 4/5 v2] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <201203041650.52217.arnd@arndb.de>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <4de611961e8210a0a2c3b56fe72b40dba638752a.1330709314.git.jason@lakedaemon.net>
 <201203041612.44966.michael@walle.cc>
 <201203041650.52217.arnd@arndb.de>
Message-ID: <20120305001713.GU11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 04:50:52PM +0000, Arnd Bergmann wrote:
> On Sunday 04 March 2012, Michael Walle wrote:
> > > @@ -294,11 +295,17 @@ static int __exit mv_rtc_remove(struct
> > > platform_device *pdev) return 0;
> > >  }
> > > 
> > > +static struct of_device_id rtc_mv_of_match_table[] = {
> > > +     { .compatible = "marvell,rtc", },
> > > +     {}
> > > +};
> > > +
> > Isn't here an ifdef CONFIG_OF missing to prevent compiler warnings?
> > 
> 
> Yes, I guess so. I keep thinking that an __unused attribute would
> actually be more helpful here because it lets the compiler automatically
> discard the symbol when it's not used, but we still get potential
> compiler errors and warnings if something inside of the unused data
> is broken.

Hmmm, in the process of responding, I looked up Grant's original email
[1] to show justification.  However, rereading it shows I was
overzealous in my desire to remove #ifdef's.  :-P  Grant only said
adding of_match_ptr() would remove the #else portion of my original
code:

#ifdef CONFIG_OF
...
#else
#define rtc_mv_of_match_table = NULL;
#endif

I'll restore the #ifdef/#endif across the kirkwood code I've changed so
far, without the #else.  __unused shouldn't be necessary, then.

Thanks for the review, Michael.

thx,

Jason.

[1] http://www.spinics.net/lists/arm-kernel/msg162595.html
