From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 12:04:57 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022204238.GG29341@beef>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
 <20131022201228.GB8037@mithrandir> <20131022204238.GG29341@beef>
Message-ID: <20131023100456.GE11954@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 04:42:38PM -0400, Matt Porter wrote:
> On Tue, Oct 22, 2013 at 10:12:29PM +0200, Thierry Reding wrote:
> > On Tue, Oct 22, 2013 at 01:42:48PM -0400, Nicolas Pitre wrote:
> > > On Tue, 22 Oct 2013, Matt Porter wrote:
> > > 
> > > > DT has many benefits. It would be great to leverage them as long as it
> > > > doesn't interfere with the rate of change and willingness to evolve code
> > > > that's always been the strength of the kernel process. That strength is
> > > > too valuable to trade away for the "DT as ABI" vision.
> > > 
> > > Amen.  This is the best statement I've read about DT so far.
> > > 
> > > Having "stable" DT bindings is just a dream.  Experience so far is 
> > > showing that this is neither practical nor realistic.
> > > 
> > > The unstructured free-for-all approach isn't good either.  Some 
> > > compromise between the two extremes needs to be found.
> > 
> > I agree. I think we need an easy way to mark bindings as unstable. One
> > possible solution that I can think of would be to use some kind of
> > special marker within the compatible value defined by a binding that
> > would be used to qualify it as unstable. Perhaps something as simple as
> > a preceding exclamation mark (!) would do.
> > 
> > 	gpio {
> > 		compatible = "!foo-gpio";
> > 	};
> > 
> > The DT core code could look for that when matching device nodes to the
> > list of compatible values supported by a driver and output a big warning
> > message to make users aware of the fact that the binding may change. The
> > driver could use the same marker in the OF device ID table to make it
> > clear that it implements an experimental binding. Whenever a binding is
> > deemed stable we can simply remove the marker from both the driver and
> > the binding, as well as DTS files.
> 
> From a technical POV this seems nice.
> 
> What does stable mean at this point? DTBs using the stable binding are
> forever guaranteed compatibility with newer kernels? We really need to
> define *exactly* what this implies for future support.

I think there's some broad agreement about what stable bindings entail.
Essentially it means at no point in the future a new kernel is allowed
to stop working with an old binding.

It also entails that bindings can change, but only in ways that don't
break backwards-compatibility.

> More than likely, most bindings will choose to stay experimental/testing
> indefinitely if stable means a lifetime of ugly backward compatibility
> hacks.

Possibly, yes. I'd like to think that having an explicit marker for
unstable bindings would be incentive enough to keep efforts ongoing to
make it stable. Think of it as the DT equivalent of the staging tree.
Nobody wants code to stay in staging forever because, well, it's just
ugly. If we furthermore output a warning at runtime whenever the DT core
encounters a compatible string marked as experimental, then people will
likely be under pressure even more to stabilize.

I've also proposed in another subthread that we could easily add a
Kconfig option that could be used for people to decide whether they want
to use experimental bindings or not. If they don't, then their device
may simply run with degraded functionality. In my opinion that will also
help to get experimental bindings to a more stable state. I expect that
there will always be people that run a "conservative" configuration with
only stable bindings allowed, and if they end up missing out on much of
the functionality there's even more incentive to get bindings tested and
stabilized.

Marking bindings as experimental will also allow us to go and remove a
binding altogether when it has failed to stabilize after some period of
time. I believe there's a similar policy in the staging tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/0bb657da/attachment.sig>
