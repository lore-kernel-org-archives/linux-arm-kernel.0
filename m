From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 09:54:35 -0800
Subject: [PATCH] ARM: Tegra: DMA: Fail safe if initialization fails
In-Reply-To: <AANLkTi=iWsX_UN6pE7nE=7NBXRPv7=6Ja68B=u8U4Ww=@mail.gmail.com>
References: <1298482170-3678-1-git-send-email-swarren@nvidia.com>
	<AANLkTi=iWsX_UN6pE7nE=7NBXRPv7=6Ja68B=u8U4Ww=@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5CF5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Wednesday, February 23, 2011 10:38 AM:
> 
> On Wed, Feb 23, 2011 at 9:29 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > tegra_dma_init currently simply bails out early if any initialization fails.
> > This skips various data-structure initialization. In turn, this means that
> > tegra_dma_allocate_channel can still hand out channels. In this case, when
> > tegra_dma_free_channel is called, which calls tegra_dma_cancel, the walking
> > on ch->list will OOPS since the list's next/prev pointers may still be
> > NULL.
> >
> > To solve this:
> > * Mark all possible channels as in-use before doing anything else in init.
> > * Only mark a channel as free once all channel-related initialization has
> > ?completed.
> >
> > This prevents allocate_channel from handing out uninitialized channels.
> >
> > There is still one small hole; allocate_channel can't check the usage array
> > for the shared channel, since this channel is permanently marked in-use.
> > This could be solved using an explicit "init OK" flag that allocate_channel
> > could check.
>
> If we still need an init complete flag, why not skip this patch and
> just add that?

I tend to like the cleanup in this patch; it simplifies the channel_usage
initialization. I'll let you make the call on whether to take this or not.

I can certainly throw together a second patch, or modify this patch, to also
use an init_ok flag to completely solve the shared channel case too though.

-- 
nvpublic
