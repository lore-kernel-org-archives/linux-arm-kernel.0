From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 30 Jul 2014 10:20:38 +0200
Subject: [PATCH v11 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
In-Reply-To: <20140729144042.GD4791@htj.dyndns.org>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140729144042.GD4791@htj.dyndns.org>
Message-ID: <20140730082038.GB29900@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 10:40:42AM -0400, Tejun Heo wrote:
> On Thu, Jul 24, 2014 at 11:17:25AM +0200, Antoine T?nart wrote:
> > @@ -321,6 +321,8 @@ struct ahci_host_priv {
> >  	u32			cap;		/* cap to use */
> >  	u32			cap2;		/* cap2 to use */
> >  	u32			port_map;	/* port map to use */
> > +	u32			force_port_map;	/* force port map */
> > +	u32			mask_port_map;	/* mask out particular bits */
> 
> Let's collect the inputs, including flags, at the top and mark them clearly.

Done.

> 
> >  int ahci_platform_init_host(struct platform_device *pdev,
> >  			    struct ahci_host_priv *hpriv,
> >  			    const struct ata_port_info *pi_template,
> > -			    unsigned long host_flags,
> > -			    unsigned int force_port_map,
> > -			    unsigned int mask_port_map)
> > +			    unsigned long host_flags)
> 
> This doesn't make much sense to me.  Near the head of the function, it
> does
> 
> 	hpriv->flags |= host_flags;
> 
> Wouldn't it make more sense to just let the caller set hpriv->flags?

I just removed the host_flags parameter and updated the drivers calling
it.


How do you want me to send the series? There is two conflicts when
applying to libata/for-3.17:
- patch 4/8: it takes into account a patch not in libata/for-3.17 but
  added before rc7. It should be better to first merge rc7, otherwise
  some modifications won't make sense.
- patch 6/8: "fsl,imx53-ahci" was removed from the documentation in
  libata/for-3.17 but not in rc7. Resolving the conflict is really
  simple.

I think it's better to apply the whole thing after merging rc7 into
libata/for-3.17, because it will only have a really simple conflict to
resolve.

Please tell me what do you prefer before I send the updated version.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
