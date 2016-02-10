From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 Feb 2016 15:37:55 +0100
Subject: breaking DT compatibility (was: Re: [PATCH v4] clk: sunxi:
 Refactor A31 PLL6 so that it can be reused)
In-Reply-To: <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <56BB2D79.6090402@arm.com>
 <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
Message-ID: <20160210143755.GE31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Feb 10, 2016 at 07:42:02AM -0600, Rob Herring wrote:
> On Wed, Feb 10, 2016 at 6:30 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > Hi,
> >
> > just a ping:
> >
> > Are we really OK with breaking existing DTs in 4.6? (per the code in
> > -next: f7d372ba54ea04d528a291b8dbe34716507bb60b, which is this patch).
> 
> I only warn and make sure people are aware of the issue. I leave that
> up to platform maintainers to decide. It depends on the maturity of
> the platform and users.

The impacted SoCs support is really partial. For the most supported
one, big things like display or sound are totally missing, and we
still update them on a regular basis to add support for new
devices. As such, users are very likely to upgrade the DT from one
version to another just because there's new devices available to
them. And the newest SoC impacted just got introduced in 4.5, and only
has the UART and MMC devices available.

> If people complain about it then it's their mess. For platforms
> supported in distros such as debian or fedora, I would strongly
> recommend against breaking compatibility.

None of them are officially supported:
https://www.debian.org/releases/stable/armhf/ch02s01.html.en
https://fedoraproject.org/wiki/Architectures/ARM#Fedora_23

Only the older one are, and they are not affected by this patch.

> They do ship dtbs, but it's a chicken and egg problem. If dtbs were
> stable and provided by firmware, then they wouldn't have to provide
> them. If dtbs are unstable, then they have no choice.

And while it might work great on platforms that have all the needed
documentation, or a perfect one, which is our case. Almost each
release, we discover that something is not working as it was
documented, when it was documented in the first place.

It also seems that even on well documented platforms, supported by the
vendors, the stable ABI dream is not going to happen:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/arm/Atmel/README#n105
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/marvell,berlin.txt#n4

If it makes things clearer, I can also add such a statement.

> > Also I think one needs ACKs from DT maintainers before merging something
> > in the respective directories, which I don't see here.
> 
> It can go in with subsystem maintainers ack, but there are problems
> with this one regardless of compatibility.
> 
> > As I am somewhat blocked on that patch, I'd like to have some discussion
> > on the list.
> >
> > Thanks,
> > Andre.
> >
> > On 05/02/16 17:59, Andre Przywara wrote:
> >> Hi Maxime,
> >>
> >> just found this while looking at your current git branch, so sorry for
> >> the late reply.
> >>
> >> CC:ing DT people, since you touch both existing DTs(!) and the binding doc.
> >>
> >> On 01/02/16 20:20, Maxime Ripard wrote:
> >>> Remove the fixed dividers from the PLL6 driver to be able to have a
> >>> reusable driver that can be used across several SoCs that share the same
> >>> controller, but don't have the same set of dividers for this clock, and to
> >>> also be reused multiple times in the same SoC, since we're droping the
> >>> clock name.
> 
> Removing a compatible name or not has nothing to do with sharing code.

This was not about the compatible name, but the hardcoded name in our
structure associated to that compatible. And since we can't register
two clocks with the same name, we couldn't use the same compatible
several times.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/dbaba577/attachment.sig>
