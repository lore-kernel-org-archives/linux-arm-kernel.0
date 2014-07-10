From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 10 Jul 2014 12:15:28 +0200
Subject: [GIT PULL 1/3] ARM: tegra: rework PCIe regulators
In-Reply-To: <CAOesGMjwE=xThuUwmBF02YaQ32_uFogryW5anNoGc8yfkuN_Pg@mail.gmail.com>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <20140707003854.GD8469@quad.lixom.net>
 <20140707055211.GA15216@ulmo>
 <CAOesGMjwE=xThuUwmBF02YaQ32_uFogryW5anNoGc8yfkuN_Pg@mail.gmail.com>
Message-ID: <20140710101527.GC21583@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 09:45:46PM -0700, Olof Johansson wrote:
> On Sun, Jul 6, 2014 at 10:52 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Sun, Jul 06, 2014 at 05:38:54PM -0700, Olof Johansson wrote:
> >> On Mon, Jun 23, 2014 at 03:23:44PM -0600, Stephen Warren wrote:
> >> > This branch reworks the set of regulators that the Tegra PCIe driver
> >> > uses, so that the driver and DT bindings more correctly model what's
> >> > really going on in HW.
> >> >
> >> > I've made this a separate branch in case it needs to be pulled into the
> >> > PCIe tree to resolve any conflicts. Any branch that adds Tegra124
> >> > support to the PCIe driver will need to be based on this branch, and
> >> > such patches might show up for 3.17, and be taken through the ARM tree
> >> > so we can manage our own dependencies.
> >>
> >> Isn't PCI broken if you boot with an older device tree now?
> >
> > Yes.
> >
> >> I would like to see this as two branches: One to the PCI driver, and one
> >> modifying DT contents. The PCI driver should remain working for old DTs,
> >> so the last couple of commits on this branch can't be there.
> >
> > This is one of my main gripes with device tree these days. We have many
> > situations where device tree bindings got rushed with the result that
> > many of them describe hardware in a *completely* wrong way.
> >
> > The Tegra PCIe binding was designed with an incomplete understanding of
> > the hardware (I wonder how many other cases there are like this in
> > mainline) and it just happens to work by accident on existing platforms.
> >
> > So this really boils down to one question: how do we fix bugs in device
> > tree bindings?
> >
> > I suppose we could keep some sort of backwards-compatible shim inside
> > the driver to cope with the existing, wrong device tree binding. However
> > that means an additional maintenance burden and I'm not convinced that
> > there's a need in this particular case.
> 
> It's really unfortunate, and this is very likely not the last time
> we're going to see something like this.
> 
> Backwards compatibility is only needed where there actually are users
> of it. Are you absolutely 100% sure that there will not be such a
> case?

Of course not. Nobody can be absolutely sure about that.

> Trimslice users?

I think there are two categories here: people that use non-upstream
kernels provided by Compulab (because you get all the hardware
acceleration goodness) and those that use upstream kernels. Those that
use the downstream kernels likely use bindings (if DT at all) that are
not supported upstream. And everybody that uses upstream almost
certainly uses an upstream U-Boot where it's trivial to update kernel
and DTB in one go.

And this brings me back to another complaint about DTB: we keep saying
things are stable ABI based on the rationale that somebody may have
shipped some DT version in a read-only ROM and therefore can't be
replaced and thus can't be broken. Today more people are likely to have
some version of a downstream DTB in their device that was never
supported upstream. And by the above argument we're giving downstream
users the finger because it's impossible to update to an upstream
kernel. So there's a lot of hypocrisy in that whole argument.

> Out-of-tree DTS:es that now need to be fixed up or they will break?

Yes, any out-of-tree DTS'es would need to be updated or things will
indeed break. There at least one case where an out-of-tree DTS was
already updated updated during the process of getting the support
upstream (Toradex).

> This isn't the same thing as in-kernel interface changes where we say
> "out of tree, out of mind".

That's exactly the problem. When we started out with the DT conversion
this was never mentioned. Maybe some people always took this for granted
but certainly not all. Most of the device tree bindings back at the time
were pulled out of a hat. Many were subsequently changed because they
didn't work out as expected. Until the big discussions around ABI
stability started.

> If you have to stay compatible, then I suggest you try to fill in
> local driver variables with derivatives of the old properties (and
> directly from the newer properties where you can). I haven't looked at
> the specifics here so I don't know how hard it might be.
> 
> If you are 100% sure that you don't have to stay compatible, then you
> can remove the code handling the old bindings. Still, even then I am a
> little worried about dependencies (and more importantly conflicts)
> between these dtsi changes and others done by tegra platform code for
> this release. I suppose that can be resolved by having this as a base
> of any DT changes for tegra if needed.

To be honest, I'm very much tempted to just drop this series. Even if
that means keeping a totally broken DT binding. But frankly I don't have
any energy left to debate DT stability.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/2b71ebf6/attachment.sig>
