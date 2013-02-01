From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 1 Feb 2013 17:35:05 +0000 (UTC)
Subject: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
In-Reply-To: <20130128191635.GA14158@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
 <20130108203853.GB1876@animalcreek.com>
 <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
 <20130117222728.GA32446@animalcreek.com>
 <20130128191635.GA14158@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1302011722070.10853@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

On Mon, 28 Jan 2013, Mark A. Greer wrote:

> On Thu, Jan 17, 2013 at 03:27:28PM -0700, Mark A. Greer wrote:
> > On Thu, Jan 17, 2013 at 07:13:36PM +0000, Paul Walmsley wrote:
> > > On Tue, 8 Jan 2013, Mark A. Greer wrote:
> > > 
> > > > On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
> 
> > > What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs[] array to 
> > > omap_hwmod_3xxx_data.c for these secure hwmods?  That carries the implicit 
> > > and possibly wrong assumption that it's likely to be ES1.0 devices that 
> > > are missing the SHAM/AES, but it seems unlikely that TI would have 
> > > multiple silicon revs running around claiming to be ES1.1?  Or maybe I'm 
> > > just being na?ve.
> > 
> > Something like that makes sense to me.  I'll re-read my email, etc. and
> > see if I can find something to help us figure it out.
> 
> I couldn't find any information that helped with this so AFAIK there is no
> good way to tell if a particular am35xx has the crypto hardware available
> or not.

I was thinking that we might assume that they are present on AM35xx 
ES1.1+.  If the TI folks are saying that they aren't available on only a 
few early devices, I'd guess that means ES1.0.  I personally have never 
seen an ES1.0 AM35xx device... 

Discriminating between ES1.0 and ES1.1+ should be pretty easy in the hwmod 
init...

>  At this point, I vote for moving 'omap3xxx_l4_core__sham' and
> 'omap3xxx_l4_core__aes' from omap3xxx_gp_hwmod_ocp_ifs[] and putting them
> in omap34xx_hwmod_ocp_ifs[] and omap36xx_hwmod_ocp_ifs[].  

I'm pretty sure that's going to break on HS OMAPs, like the HS OMAP3430 in 
the N900.  I don't think those IP blocks are directly accessible from 
Linux on most HS setups, although this might vary by device.  I'd feel 
more comfortable if you created an omap34xx_gp_hwmod_ocp_ifs[] list and an 
omap36xx_gp_hwmod_ocp_ifs[] list.  We should probably get rid of 
omap3xxx_gp_hwmod_ocp_ifs[] altogether.

> That should be safe in general and if someone with an am35xx wants to 
> use those modules, they can edit am35xx_hwmod_ocp_ifs[] locally.

If you want to just leave them commented in am35xx_hwmod_ocp_ifs[], rather 
than enabling them for ES1.1+ AM35xx, that's fine with me too, since we 
don't know that they are ES-level-based.  Maybe put a comment there that 
says that these are likely to be present, but no one seems to know for 
certain?  Seems ludicrous, but I guess that's what we're reduced to!


- Paul
