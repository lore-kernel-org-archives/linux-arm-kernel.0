From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 25 Jan 2017 22:24:09 +0100
Subject: [PATCH] usb: musb: constify musb_hdrc_config structures
In-Reply-To: <20170125165815.GA5318@uda0271908>
References: <1485285742-6949-1-git-send-email-bhumirks@gmail.com>
 <20170125165815.GA5318@uda0271908>
Message-ID: <20170125212409.GC5496@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:58:15AM -0600, Bin Liu wrote:
> On Wed, Jan 25, 2017 at 12:52:22AM +0530, Bhumika Goyal wrote:
> > Declare musb_hdrc_config structures as const as they are only stored in
> > the config field of a musb_hdrc_platform_data structure. This field is of
> > type const, so musb_hdrc_config structures having this property can be
> > made const too.
> > Done using Coccinelle:
> > 
> > @r disable optional_qualifier@
> > identifier x;
> > position p;
> > @@
> > static struct musb_hdrc_config x at p={...};
> > 
> > @ok@
> > struct musb_hdrc_platform_data pdata;
> > identifier r.x;
> > position p;
> > @@
> > pdata.config=&x at p;
> > 
> > @bad@
> > position p != {r.p,ok.p};
> > identifier r.x;
> > @@
> > x at p
> > 
> > @depends on !bad disable optional_qualifier@
> > identifier r.x;
> > @@
> > +const
> > struct musb_hdrc_config x;
> > 
> > File size before:
> >    text	   data	    bss	    dec	    hex	filename
> >    1212	    338	      0	   1550	    60e	drivers/usb/musb/jz4740.o
> > 
> > File size after:
> >    text	   data	    bss	    dec	    hex	filename
> >    1268	    290	      0	   1558	    616	drivers/usb/musb/jz4740.o
> > 
> > File size before:
> >    text	   data	    bss	    dec	    hex	filename
> >    6151	    333	     16	   6500	   1964	drivers/usb/musb/sunxi.o
> > 
> > File size after:
> >    text	   data	    bss	    dec	    hex	filename
> >    6215	    269	     16	   6500	   1964	drivers/usb/musb/sunxi.o
> > 
> > File size before:
> >    text	   data	    bss	    dec	    hex	filename
> >    3668	    864	      0	   4532	   11b4	drivers/usb/musb/ux500.o
> > 
> > File size after:
> >    text	   data	    bss	    dec	    hex	filename
> >    3724	    808	      0	   4532	   11b4	drivers/usb/musb/ux500.o
> > 
> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> 
> Hi Greg,
> 
> Why you don't want this patch go through my tree? Now it causes me tree
> rebase failed. It should be easy to fix, but just wanted to learn your
> rules.

What are you rebasing?  And why?  Just send me patches, I can merge them
when they come in just fine.

Normally yes, I do wait for these to go through your tree, but it was
just so simple, and obvious, and in a bunch of others from the author,
that I figured I could just take it as-is.

sorry if it caused you problems, but you might want to look at your
development process if it is.  You should always be able to handle other
people changing files in your area at any point in time.  Kernel
maintainership is not "no one else can ever touch this!" type of
development, you have to be able to handle stuff like this easily.

thanks,

greg k-h
