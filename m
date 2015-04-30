From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 11:41:34 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <7128860.xHITr0VFap@wuerfel>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <4411194.KCIZ9l536O@wuerfel> <20150430084549.GB3488@pd.tnic>
 <7128860.xHITr0VFap@wuerfel>
Message-ID: <20150430094134.GD3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 11:01:43AM +0200, Arnd Bergmann wrote:
> Ok, but I'd also do multiple drivers for one vendor if they have several
> blocks that are clearly unrelated. My understanding was that this is the
> case here, but I have not looked too closely.

AFAIU, this is a driver for a bunch of xgene IP blocks.

Now, if someone integrates xgene memory controller in some other hw
platform, we could still serve it with the same xgene-edac driver -
it'll simply use only the memory controller part of the functionality.

> Note that a lot of vendors do not like to say who they licensed IP
> blocks from, or they are contractually required not to say it.

Then there's that :-\

But the moment they supply an EDAC driver, one can recognize the IP
block from the registers and functionality, no? Or do they change stuff
a little bit so that it looks sufficiently different?

> Yes, that is helpful feedback, but seems unrelated to the discussion
> about how to split this driver or not.

Yeah, I know. I just wanted to mention that in the discussion because
I get the impression that people are throwing out EDAC drivers just
because the hw functionality is there. So I wanted to remind people to
step back and consider the usefullness of such a driver first.

> Ok, let me try to state what I think we agree on:
> 
> - For EDAC devices that are clearly unrelated (in particular, made by
>   different vendors, but possibly part of the same chip), there should
>   be one module per device type that registers one platform_driver.
> 
> - For EDAC drivers that are variants of one another (e.g. different
>   generations of the same memory controller), we want one module with
>   one platform_driver that can handle all variants.
> 
> Let me know if you disagree with the above. If that's fine, I think it
> leaves the case where we have one chip that has multiple EDAC blocks
> and we can't easily tell if those blocks are all inter-related or not.
> For this case, I would like to rely on your judgment as subsystem
> maintainer on whether the parts look related enough to have a single
> driver (with matching all device variants) or one driver for each
> class of device, as well as spotting cases where a part already has
> a driver from a different chip vendor that was licensing the same IP
> block.

Well, so the way I see it is, if we could map the EDAC drivers to the IP
blocks. I.e., I'd like to have EDAC drivers mapped to the *IP* *blocks*
vendor *instead* of the platform vendor.

We will have to be able to load multiple EDAC drivers anyway but it'll
be much easier this way.

So let's have an example:

Let's say there's one xgene_edac driver which contains all the RAS
functionality of xgene IP blocks. Memory controller, L3 cache,
whatever...

Now, three *platform* vendors license, say, the xgene memory controller.

With my scheme, xgene_edac will be loaded on all those three vendors'
Linux. Done.

But if those three vendors went and created an EDAC module each for
their system, it would be a lot of repeated copy'pasting and bloat.

Now, the other dimension doesn't look better either:

xgene_edac_mc
xgene_edac_mc-v2
xgene_edac_l3
xgene_edac-l2
...

Also, in both cases, if any of those drivers need to talk to each other
or know of one another in any way, the situation becomes really funny as
they need to create something ad-hoc each time.

And this all can be avoided by having a single IP-blocks RAS driver.

Does that make more sense? Can it even be done with devicetree and all?

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
