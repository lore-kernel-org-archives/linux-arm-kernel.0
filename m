From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Feb 2014 15:05:32 -0800
Subject: ccf: where to put constraints?
In-Reply-To: <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
References: <20140224201046.GA13155@katana>
 <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
Message-ID: <20140224230532.22529.7958@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting S?ren Brinkmann (2014-02-24 13:21:58)
> Hi Wolfram,
> 
> On Mon, 2014-02-24 at 09:10PM +0100, Wolfram Sang wrote:
> > Hi,
> > 
> > Where do I put constraints when using the CCF? I have a CPU and GPU
> > clock derived from the same PLL. Both clocks have their own divider.
> > Now, there is the additional constraint that the CPU clock must not be
> > lower than the GPU clock. Do I add checks in the set_rate functions?
> > Feels like the wrong layer, but not checking it and blindly relying on
> > somebody else does not feel correct, too. How to do it best?
> 
> I don't know if it's the best or only way, but so far, I did things like
> that with clock notifiers.
> 
> I.e. when a clock consumer needs to be notified about its input clock
> being changed it registers a clock notifier. In that notifier callback
> it then can react to the rate change. E.g. adjust dividers to stay
> within legal limits or reject the change completely.

Yes, this is why the notifiers were created. A nice side effect of this
is that the code can live outside your clock driver. Often times the
clocks are quite capable of running at these speeds, but the problem is
the IP blocks (CPU & GPU in Wolfram's case) would be out of spec. It is
arguable that this logic does not belong in the clock driver but instead
in some cpufreq driver or something like it.

The clock notifiers make it easy to put this logic wherever you like and
you can even veto clock rate changes.

Regards,
Mike

> 
>         S?ren
> 
> 
