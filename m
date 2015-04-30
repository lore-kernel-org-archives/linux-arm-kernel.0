From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 14:52:52 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <20150430123300.GE3488@pd.tnic>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <3900315.9fjubb6CtE@wuerfel> <20150430123300.GE3488@pd.tnic>
Message-ID: <17860828.NGjfVanSol@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 14:33:00 Borislav Petkov wrote:
> 
> > The point where it gets silly is when you try to handle multiple
> > unrelated devices in the same driver and you get a probe function
> > that just does:
> 
> Ok, what if they're related through RAS?
> 
> I.e., xgene_edac contains all RAS-specific functionality of the xgene IP
> blocks. This doesn't sound silly to me, frankly, and it concentrates it
> all in one place. Communication between blocks is trivial and there's no
> code duplication.

My point is that with the current implementation, there is no communication
at all: you have four separate drivers that just live in the same file.

> Other vendors using those IP blocks would simply add new DT descriptions.
> 
> > apm_edac_probe(struct platform_device *dev)
> > {
> >       if (dev_is_xgene_mc(dev))
> >               return apm_probe_xgene_mc(dev);
> >       if (dev_is_xgene_l2(dev))
> >               return apm_probe_xgene_l2(dev);
> >       if (dev_is_ygene_mc(dev))
> >               ...
> 
> So we do that on x86 - amd64_edac does AMD per-family setup and sb_edac
> too, for the last 4 Intel uarches. And it works just fine. So if "silly"
> is the only problem, I can certainly live with it.

This is different, because in your examples, there is still some shared
code between the CPU families, fact most of the driver looks like it's
shared, and even the family-specific code is mostly shared. E.g.
f1x_early_channel_count() is used on almost all families.

What I mean with silly is the case where none of the code behind those
is shared at all, and the only common part is the probe() function
that contains the multiplexer.

	Arnd
