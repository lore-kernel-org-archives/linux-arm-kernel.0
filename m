From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 May 2015 14:20:19 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
In-Reply-To: <7268386.7h5UbnZJi7@phil>
References: <20150511193527.GA29690@lukather> <20150513115455.GZ10961@lukather>
 <3302855.7BhJdLtyJZ@wuerfel> <7268386.7h5UbnZJi7@phil>
Message-ID: <20150521122019.GC7461@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, May 13, 2015 at 04:42:51PM +0200, Heiko Stuebner wrote:
> Am Mittwoch, 13. Mai 2015, 15:03:04 schrieb Arnd Bergmann:
> > On Wednesday 13 May 2015 13:54:55 Maxime Ripard wrote:
> > > On Wed, May 13, 2015 at 12:30:39PM +0200, Arnd Bergmann wrote:
> > > > > > Sorry I hadn't looked at the new driver before, but I did now and
> > > > > > need a little clarification. It seems to me that the device should
> > > > > > be compatible with the generic DT binding we have in
> > > > > > Documentation/devicetree/bindings/misc/sram.txt, and use more
> > > > > > generic code. At least I can't see much in here that is really
> > > > > > sunxi specific.
> > > > > > 
> > > > > > Were you not aware of that generic binding, or did you have a good
> > > > > > reason
> > > > > > not to use it?
> > > > > 
> > > > > I asked myself the same question, and I don't really think that this
> > > > > would be wise, since that in order to be accessible by the CPU it has
> > > > > to be mapped to it through this driver.
> > > > > 
> > > > > I felt like this alone justify a new compatible, even though we might
> > > > > end up using the same driver.
> > > > 
> > > > Have you discussed this with Heiko?
> > > 
> > > No, I didn't.
> > > 
> > > We don't need to use his driver, there was no point about discussing
> > > with him about anything.
> > 
> > The point is that you add a new binding for an SRAM. We already have
> > a binding for that, so you should try to make your device fit in with
> > the existing design.
> > 
> > > > but I now think I was misreading it, and the problem is different:
> > > > Rather than having separate devices for parts of the SRAM, you
> > > > are actually missing a node for the SRAM physical window. I think
> > > > the individual SRAM pieces should be nodes below one that describes
> > > > all of the SRAM, as we do in
> > > > Documentation/devicetree/bindings/misc/sram.txt
> > > 
> > > These are physically separate SRAM, used for different purposes, by
> > > different devices.
> > > 
> > > Since when in the DT different instances of the same IP should be
> > > represented in a single node?
> > > 
> > > And again, this patch is really not about "Simple IO memory regions to
> > > be managed by the genalloc API". We have no use for these SRAMs, and
> > > just want them to be mapped to the device, so the CPU won't even have
> > > access to them for most of them.
> > 
> > I believe that is the case for a lot of the other SRAMs as well,
> > and that is why I think we need Heiko to review your binding and
> > say if it makes sense separately from the generic driver, or if
> > we should extend the existing binding.
> > 
> > We can still have separate drivers if necessary, but I really don't
> > want to see multiple incompatible ways of describing something this
> > fundamental in DT.
> 
> Preface: I only did the reserved sections so I could claim parts of my 
> Rockchip sram for the smp code that needed to reside at a specific place in it, 
> so I guess I don't necessarily feel qualified to judge one against the other 
> :-), but anyway
> 
> 
> The commit message for the driver contains
> 
> "We could also imagine changing this at runtime for example to change the
> mapping of these SRAMs to use them for suspend/resume or runtime memory rate
> change, if that ever happens."
> 
> which sounds to me a lot like the generic use case for the current sram driver 
> - for example in conjuction with the PIE stuff if it ever resurfaces.
> 
> 
> But from my short glance I also don't see how this quite custom mapping thing 
> (device vs. cpu) would be able to fit into the generic description.

So, what's the conclusion on this?

This driver has been properly sent, without any kind of review from
you. I then sent a pull request with it for 4.1, which has only been
silently ignored.

And now, it seems like this is going to be the same for 4.2. I'd
*really* like to have some kind of a discussion here, and not let it
fall into oblivion. It fixes some real issues we have.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/1b0d06d8/attachment.sig>
