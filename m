From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Mar 2011 22:58:15 +0800
Subject: Revert "[ARM] pxa: remove now unnecessary dma_needs_bounce()"
In-Reply-To: <20110321145434.GB4340@n2100.arm.linux.org.uk>
References: <AANLkTin0hVKnicRtxLwxwPJZU6tYiuTZnbGUfxt9bLYe@mail.gmail.com>
	<AANLkTimGBGNdBa2NzYDTOXxNF-1MgOOC502a-ATfNoBA@mail.gmail.com>
	<20110321145434.GB4340@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinMrXdi=VYgbBchTCt=fBWfCiJ2nBAb0gQYyFG6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 10:54 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 21, 2011 at 03:21:24PM +0800, Eric Miao wrote:
>> Hrm... checked again. The IXP4xx build regression seems to have been fixed
>> by the below commits:
>>
>> 88a5810 ARM: fix IXP4xx build failure
>> 710224f arm: fix "arm: fix pci_set_consistent_dma_mask for dmabounce devices"
>
> Annoyingly, no one reported what the actual error messages with IXP4xx
> were, so we can only guess at this point.
>
> Eric's patch (4fa5518) did this:
>
> +#ifdef CONFIG_SA1111
> ?extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
> +#else
> +static inline int dma_needs_bounce(struct device *dev, dma_addr_t addr,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?size_t size)
> +{
> + ? ? ? return 0;
> +}
> +#endif
>
> which assumes that SA1111 is the _only_ user of the dma_needs_bounce()
> function. ?This is incorrect as IXP4xx also has an implementation.
>
> So, reapplying the original patch will immediately reintroduce the
> IXP4xx build failure as we end up with two functions called
> dma_needs_bounce().
>

Yeah, I remember I had once removed that dma_needs_bounce() from
ixp4xx. And simply re-revert that patch won't work. And it looks like
things changed a bit since then, so it does need further look-into for
a proper fix now.
