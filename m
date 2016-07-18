From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 18 Jul 2016 14:44:22 +0800
Subject: "coupled" regulator support
In-Reply-To: <20160715125039.GI30372@sirena.org.uk>
References: <20160715200113.0f3cd823@xhacker>
 <20160715125039.GI30372@sirena.org.uk>
Message-ID: <20160718144422.30be1e2f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Fri, 15 Jul 2016 13:50:39 +0100 Mark Brown wrote:

> On Fri, Jul 15, 2016 at 08:01:13PM +0800, Jisheng Zhang wrote:
> 
> > regR can only be set to v1 if devA and devB all call for set voltage to v1
> > regR can set to v2 if devA or devB call for set voltage to v2  
> 
> > To support this situation, I'd like to add flag to regulator structure and
> > patch regulator_check_consumers() to check whether we are safe to set the vol  
> 
> Surely this is just what normal set voltage calls do?  If devA says
> set_voltage(v1, v2) but devB still has set_voltage(v2, v2) then we will
> leave the voltage at v2, we'll only allow it to be set to v1 if both
> consumers agree that this is a valid voltage.  It feels like there's
> something else going on here that I'm missing?

oops, sorry for not describing the situation clearly. Here are more details.

I'm implementing DVFS for devA and devB, devA and devB shares the same
voltage regulator. devA and devB are different devices, and they are
independent in DVFS.

v1 and v2 and both valid voltages, but here we have an explicit limitation:
we must take the "regulator shared" fact into consideration. Let's assume
the voltage is at v2, devA is not busy now, it wants to scale down freq, then
scale down voltage to v1, but if devB hasn't call for setting voltage to
v1, we can't scale down voltage now, we need to wait for devB sending out
the voltage scaling down request when it is not busy in future some time.
Obviously, the last user will succeed to scale down the voltage.

My solution is
to extend regulator_check_consumers() to check whether all consumers agree
to scaling down voltage or not.

Thanks,
Jisheng
