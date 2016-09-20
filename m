From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 20 Sep 2016 20:02:47 +0200
Subject: [PATCH 2/4] ARM: tegra: nyan: Use external control for bq24735
 charger
In-Reply-To: <00697eef-0b36-1ff5-9c7a-43c1b53b52bc@nvidia.com>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-2-contact@paulk.fr>
 <00697eef-0b36-1ff5-9c7a-43c1b53b52bc@nvidia.com>
Message-ID: <1474394567.1215.14.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 20 septembre 2016 ? 18:40 +0100, Jon Hunter a ?crit :
> On 28/08/16 18:32, Paul Kocialkowski wrote:
> >?
> > Nyan boards come with an embedded controller that controls when to
> > enable and disable the charge. Thus, it should not be left up to the
> > kernel to handle that.
> >?
> > Using the ti,external-control property allows specifying this use-case.
>?
> So the bq24735 is populated under the EC's 'i2c-tunnel' property which
> is there to specifically interface it's child devices to the host. So I
> am a bit confused why this is expose to the host if it should not be used?

Well, it needs to access the information in the read-only registers provided by
the chip, which is allowed by the setup in place that you described.

However, the EC has its internal state machine that decides when to start
charging, etc and so should be the only one to write registers, to avoid
conflicts.

> Again you may right and I did find the original series [0] for this
> which specifically references the Acer Chromebook that needs this.
> However, I am not sure why this was never populated? Is there any other
> history here?

I am also confused about why it wasn't applied earlier. However, the cros kernel
is using the very same scheme.

> What is the actual problem you see without making this change?

There is a risk of conflict (even though it's probably not that significant),
given the low variety of possible cases here. The idea is simply to say that the
EC is in charge and to let it do its job without interfering.

> The original series states ...
>?
> "On Acer Chromebook 13 (CB5-311) this module fails to load if the
> charger is not inserted, and will error when it is removed."

I'm confused about that comment. At this point (and with this patch), it works
normally.

> Cheers
> Jon
>?
> [0] http://marc.info/?l=linux-pm&m=145447948705686&w=2

Cheers,

--?
Paul Kocialkowski, developer of low-level free software for embedded devices

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160920/19d6ecea/attachment.sig>
