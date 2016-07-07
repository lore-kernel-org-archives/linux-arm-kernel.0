From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 7 Jul 2016 13:06:26 +0100
Subject: clk: Per controller locks (prepare & enable)
In-Reply-To: <913d98f6-0d7c-63e3-8748-961eafd776f4@osg.samsung.com>
References: <57737761.2020708@samsung.com>
 <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
 <577A1D54.9010203@samsung.com>
 <98eb9718-1267-dafe-2e36-323f4976ece0@osg.samsung.com>
 <577B54CE.90004@samsung.com>
 <913d98f6-0d7c-63e3-8748-961eafd776f4@osg.samsung.com>
Message-ID: <20160707120626.GE1835@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 09:48:34AM -0400, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 07/05/2016 02:33 AM, Krzysztof Kozlowski wrote:
> > On 07/04/2016 05:15 PM, Javier Martinez Canillas wrote:
> 
> [snip]

I have also been have a brief look at this as we have been
encountering issues attempting to move some of the clocking on
our audio CODECs to the clock framework. The problems are even
worse when the device can be controlled over SPI as well, as the
SPI framework may occasionally defer the transfer to a worker
thread rather than doing it in the same thread which causes the
re-enterant behaviour of the clock locking to no longer function.

> 
> >>
> >> Yes, splitting the lock per controller will fix the possible deadlock in
> >> this case but I think we need an approach that is safe for all possible
> >> scenarios. Otherwise it will work more by coincidence than due a design.
> > 
> > This is not a coincidence. This design is meant to fix this deadlock.
> > Not by coincidence. By design.
> >
> 

I think there is still some milage in thinking about them just
to be sure, if we are going to the effort of changing the clock
framework locking it is worth getting it right as it will be
non-trivial.

I could perhaps imagine a situation where one device is passing
a clock to second device and that device is doing some FLL/PLL
and passing the resulting clock back. For example supplying a
non-audio rate clock to a CODEC which then supplies back a clock
at an audio rate, which is used for audio functions on the first
device.

Although that said I do think that by controller locking probably
fixes my primary issues right now.

> Ok, if the configurations I described doesn't exist in practice and are
> just theoretical then yes, doing a per controller lock is a good design. 
>  
> > You are talking about theoretical different configurations... without
> > even real bug reports. I am providing an idea to fix a real deadlock and
> > your argument is that it might not fix other (non-reported) deadlocks.
> > These other deadlocks happen now as well probably...
> >
> 
> I'm not against you re-working the locks to do it per controller, is just
> that I thought it would be good to have a solution that is going to work
> for all possible scenarios.
> 
> You asked for comments/opinions/ideas and I gave mine, that's all :)
> 

I had also been leaning more towards a lock per clock rather
than a lock per controller. But one other issue that needs to be
kept in mind (with both the controller or clock based locking)
through is that the enable and prepare operations propagate down
the clock tree, where as the set rate operations propagate up the
clock tree.  This makes things a rather furtile breeding ground
for mutex inversions as well.

Thanks,
Charles
