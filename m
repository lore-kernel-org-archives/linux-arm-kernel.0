From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Feb 2017 16:44:04 -0800
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <20170220164926.GB15493@ulmo.ba.sec>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <20170216184524.cxcy2ux37yrwutla@lukather>
 <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
 <20170217154341.vn7uqvdaijtrj64s@lukather>
 <20170220164926.GB15493@ulmo.ba.sec>
Message-ID: <20170223004404.jyxlvvsoojw7qnud@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Mon, Feb 20, 2017 at 05:49:26PM +0100, Thierry Reding wrote:
> On Fri, Feb 17, 2017 at 04:43:41PM +0100, Maxime Ripard wrote:
> > On Fri, Feb 17, 2017 at 01:45:44PM +0100, Tobias Jakobi wrote:
> > > Hello Maxime,
> > > 
> > > Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Feb 16, 2017 at 01:43:06PM +0100, Tobias Jakobi wrote:
> > > >> I was wondering about the following. Wasn't there some strict
> > > >> requirement about code going upstream, which also included that there
> > > >> was a full open-source driver stack for it?
> > > >>
> > > >> I don't see how this is the case for Mali, neither in the kernel, nor in
> > > >> userspace. I'm aware that the Mali kernel driver is open-source. But it
> > > >> is not upstream, maintained out of tree, and won't land upstream in its
> > > >> current form (no resemblence to a DRM driver at all). And let's not talk
> > > >> about the userspace part.
> > > >>
> > > >> So, why should this be here?
> > > > 
> > > > The device tree is a representation of the hardware itself. The state
> > > > of the driver support doesn't change the hardware you're running on,
> > > > just like your BIOS/UEFI on x86 won't change the device it reports to
> > > > Linux based on whether it has a driver for it.
> > >
> > > Like Emil already said, the new bindings and the DT entries are solely
> > > introduced to support a proprietary out-of-tree module.
> > 
> > No. This new binding and the DT entries are solely introduced to
> > describe a device found in a number of SoCs, just like any other DT
> > binding we have.
> > 
> > > The current workflow when introducing new DT entries is the following:
> > > - upstream a driver that uses the entries
> > > - THEN add the new entries
> > 
> > And that's never been the preferred workflow, for *any* patches.
> 
> Actually it has. How else are you going to test that your driver really
> works? You've got to have both pieces before you can verify that they're
> both adequate. So the typical workflow is to:
> 
> 	1) define the bindings
> 	2) write a driver that implements the bindings
> 	3) add entries to device tree files
> 
> Usually it doesn't matter in which order you do the above because they
> are all part of the same patch series. But that's not what you're doing
> here. The more general problem here is that you're providing device tree
> content (and therefore ABI) that's based on a binding which has no
> upstream users. So you don't actually have a way of validating that what
> you merge is going to be an adequate description.
> 
> You're probably going to respond: "but DT describes hardware, so it must
> be known already, there won't be a need for changes". Unfortunately that
> is only partially true. We've had a number of occasions where it later
> turned out that a binding was in fact not an adequate description, and
> then we've had to jump through hoops in order to preserve backwards
> compatibility. That's already annoying enough if you've got in-tree
> users, but it's going to be even more painful if you start out with an
> out-of-tree user.
> 
> All of that said, you've got an Acked-by from Rob and that's about as
> good as it's going to get. So I'm not going to NAK this. But I will
> caution against this, because I don't think you're doing yourself any
> favours with this.
> 
> So perhaps the question that we should ask is this: what do you gain by
> merging this series? The fact remains that you don't have an upstream
> driver that implements this binding, so ultimately you're going to be
> carrying patches in some development tree anyway. Why not simply stash
> these patches into the same tree? That should be about the same amount
> of work for you and your users, but it has the advantage of not locking
> you into something that you may regret.

This is really a usability issue. I don't want the average Jane / Joe
to have to patch and recompile the DT in order to get the GPU running
on her / his distro of choice. The only thing that should be needed
would be to install an (or a couple of) extra package in order to get
everything running. Just like it's done for any other GPU out there,
or wifi, disregarding whether it's supported upstream or not.

Another nice thing is also that the mali bindings have been a huge
mess so far. If we have a common bindings, everything will just work
the same for all the platforms, and we can use the same driver there,
allowing us at least to consolidate the source code.

I'm not too afraid about getting something wrong. We already have code
working for two different vendors, and all the other GPUs already
described in DT (nvidia's, the Adreno) all have the same kind of
binding that we have.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170222/d94edd35/attachment.sig>
