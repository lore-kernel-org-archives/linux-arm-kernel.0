From: koro.chen@mediatek.com (Koro Chen)
Date: Wed, 14 Oct 2015 09:19:09 +0800
Subject: [alsa-devel] [RFC PATCH] ASoC: Modify check condition of
 multiple bindings of components
In-Reply-To: <561D1843.1020007@metafoo.de>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
 <561D0AA9.5080702@metafoo.de> <1444745902.26493.2.camel@mtksdaap41>
 <561D1843.1020007@metafoo.de>
Message-ID: <1444785549.26493.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-10-13 at 16:42 +0200, Lars-Peter Clausen wrote:
> On 10/13/2015 04:18 PM, Koro Chen wrote:
> > On Tue, 2015-10-13 at 15:44 +0200, Lars-Peter Clausen wrote:
> >> On 10/13/2015 03:37 PM, Koro Chen wrote:
> >>> The patch "ASoC: Prevent components from being bound to multiple cards"
> >>> adds check to prevent multiple cards from using the same component.
> >>> However, snd_soc_register_platform() or snd_soc_register_codec() will
> >>> also create components, and sharing the same platform by multiple cards
> >>> is then refused. This happens with a platform having multiple
> >>> independent DAIs that share the same DMA controller.
> >>>
> >>> Relax the condition by checking component->registered_as_component,
> >>> which is only true in case of snd_soc_register_component() and
> >>> will be false for components created by snd_soc_register_platform()
> >>> or snd_soc_register_codec().
> >>
> >> Binding a component to multiple cards results in internal data structure
> >> corruption, regardless of whether it is a raw component, CODEC or platform,
> >> which is why the check was added. So the proposed change wont work.
> >>
> > Thanks for your comment. Is it possible to share an example of how the
> > data structure will be corrupted? So I can study into this further.
> 
> Just look at soc_probe_component() and think about what happens if that runs
> twice for two different cards. Multiple calls to list_add() on the same
> list, controls are added multiple times, DAPM widgets are created multiple
> times, the card field will only point to the last card.
> 
When multiple binding happens, soc_probe_component() just returns zero
without doing anything after this patch (actually it also returned zero
before the patch "ASoC: Prevent components from being bound to multiple
cards"). So the component still binds to the first card. For this case I
think it should be fine?

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
