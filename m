From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 24 Feb 2014 16:43:31 -0800
Subject: ccf: where to put constraints?
In-Reply-To: <20140225002214.22529.23643@quantum>
References: <20140224201046.GA13155@katana>
 <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
 <20140224230532.22529.7958@quantum>
 <32a83aee-624b-47ef-a13e-1a9d993005c0@CH1EHSMHS039.ehs.local>
 <20140225002214.22529.23643@quantum>
Message-ID: <982cbb23-d1e4-4048-bf7f-3c1909bf766c@TX2EHSMHS023.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-24 at 04:22PM -0800, Mike Turquette wrote:
> Quoting S?ren Brinkmann (2014-02-24 15:11:55)
> > On Mon, 2014-02-24 at 03:05PM -0800, Mike Turquette wrote:
> > > Quoting S?ren Brinkmann (2014-02-24 13:21:58)
> > > > Hi Wolfram,
> > > > 
> > > > On Mon, 2014-02-24 at 09:10PM +0100, Wolfram Sang wrote:
> > > > > Hi,
> > > > > 
> > > > > Where do I put constraints when using the CCF? I have a CPU and GPU
> > > > > clock derived from the same PLL. Both clocks have their own divider.
> > > > > Now, there is the additional constraint that the CPU clock must not be
> > > > > lower than the GPU clock. Do I add checks in the set_rate functions?
> > > > > Feels like the wrong layer, but not checking it and blindly relying on
> > > > > somebody else does not feel correct, too. How to do it best?
> > > > 
> > > > I don't know if it's the best or only way, but so far, I did things like
> > > > that with clock notifiers.
> > > > 
> > > > I.e. when a clock consumer needs to be notified about its input clock
> > > > being changed it registers a clock notifier. In that notifier callback
> > > > it then can react to the rate change. E.g. adjust dividers to stay
> > > > within legal limits or reject the change completely.
> > > 
> > > Yes, this is why the notifiers were created. A nice side effect of this
> > > is that the code can live outside your clock driver. Often times the
> > > clocks are quite capable of running at these speeds, but the problem is
> > > the IP blocks (CPU & GPU in Wolfram's case) would be out of spec. It is
> > > arguable that this logic does not belong in the clock driver but instead
> > > in some cpufreq driver or something like it.
> > > 
> > > The clock notifiers make it easy to put this logic wherever you like and
> > > you can even veto clock rate changes.
> > 
> > Right, that's how I have it. If a device driver needs to enforce some
> > policy on its clock, it implements a clock notifier callback.
> > 
> > The drawback though, as I see it, it makes interactions hard to
> > understand. With such a scheme, rate changes may fail and the cause is
> > not always obvious - often hidden really well. Usually all you get is a
> > message from the CCF that the rate change for clock <name> failed, but
> > if your notifier callback isn't verbose, you can search forever for the
> > cause of that failure.
> > 
> > On our internal repo I had it a few times that "bugs" get assigned to the
> > wrong piece. E.g. cpufreq, even though that works perfectly well and
> > correct on its own, but some other device enforced some policy through a
> > notifier.
> 
> Yes, debugging across notifiers is notoriously annoying. How about
> something like the following patch?

Good idea. Now I should just follow that advice and my life may become a
lot easier :)
ACK

	Thanks,
	S?ren
