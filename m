From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 14:33:00 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <3900315.9fjubb6CtE@wuerfel>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <3900315.9fjubb6CtE@wuerfel>
Message-ID: <20150430123300.GE3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 12:21:14PM +0200, Arnd Bergmann wrote:
> They don't normally change stuff intentionally, but you can have
> drivers for the same hardware that are written so differently that
> it becomes hard to spot that they are doing the same thing.
> 
> We have a bunch of XGMAC drivers for the same basic licensed IP block,
> each one configured a bit differently and extended with some soc-specific
> bits, and drivers written from scratch.

So not nice.

> I would also not assume that people are trying hard to hide something
> from you, it's more that some guy is given the task to write a driver
> for an IP block, but is not told who made that, so the binding will
> just come with the name of the company he's working for.

So I'd home some guy would go grep the sources and hopefully find that
very similar functionality is already present.

> Right, but they would then also have to load the code for the other
> blocks they did not license.

That's a problem? I mean, the other code is inactive anyway and is only
a couple of KBytes. So not a big deal IMO.

If that becomes a problem with embedded, we can always do ugly ifdeffery
and Kconfig games if absolutely necessary.

> > xgene_edac_mc
> > xgene_edac_mc-v2
> > xgene_edac_l3
> > xgene_edac-l2
> > ...
> 
> Not following you here, what is the problem here?

The unnecessary fragmentation of xgene_edac functionality. I would like,
if possible, to concentrate all xgene RAS stuff in one file, like x86
does. And then there's the talking between the two aspect below...

> Agreed. If the drivers need to talk to one another, that is a clear
> sign that the devices are not actually independent and that they
> really belong into a single driver. That's not the case I'm thinking
> of here.

But if we split <vendor>_edac stuff per IP block, that will become a
problem. So we better talk about it now.

> The devicetree just describes the available hardware blocks. Typically
> you have one node for one block (e.g. a memory controller), and then
> have one driver for that block.
>
> Things get a little funny if you want to have multiple drivers for
> the same device, e.g. you want a driver in drivers/memory/ to support
> autorefresh in sleep states and another driver in drivers/edac to
> support error handling. If you get something like this, you need
> some coordination between the two drivers, but that is unrelated to
> devicetree or not.
> 
> A platform driver should match against a set of similar devices that are
> identified by a "compatible" string, and we try to list the name of the
> ip block here, which could be something like "arm,pl12345rev1.2" if it
> is licensed from another company, or if that is not known, describe it
> by using the product number of the first chip it appeared in, e.g.
> "amcc,405ez-memory-controller". APM does not use numbers for their
> chips, so "apm,xgene-memory-controller" would refer to the memory
> controller used in the "xgene" chip. If they come out with a second
> product that uses the same one, they would use the same string, or
> use "apm,ygene-memory-controller" for the one that is in "ygene" if
> that is slightly different. The driver can then match against both
> and handle the differences based on the compatible string.

Thanks for that background info, it helps a lot.

> The point where it gets silly is when you try to handle multiple
> unrelated devices in the same driver and you get a probe function
> that just does:

Ok, what if they're related through RAS?

I.e., xgene_edac contains all RAS-specific functionality of the xgene IP
blocks. This doesn't sound silly to me, frankly, and it concentrates it
all in one place. Communication between blocks is trivial and there's no
code duplication.

Other vendors using those IP blocks would simply add new DT descriptions.

> apm_edac_probe(struct platform_device *dev)
> {
> 	if (dev_is_xgene_mc(dev))
> 		return apm_probe_xgene_mc(dev);
> 	if (dev_is_xgene_l2(dev))
> 		return apm_probe_xgene_l2(dev);
> 	if (dev_is_ygene_mc(dev))
> 		...

So we do that on x86 - amd64_edac does AMD per-family setup and sb_edac
too, for the last 4 Intel uarches. And it works just fine. So if "silly"
is the only problem, I can certainly live with it.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
