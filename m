From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 22 Oct 2012 09:47:06 -0700
Subject: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
In-Reply-To: <1350899541.2768.82.camel@twins> (Peter Zijlstra's message of
 "Mon, 22 Oct 2012 11:52:21 +0200")
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
 <20121018055136.GF11137@arwen.pp.htv.fi>
 <1350655227.2768.11.camel@twins> <87391ahvao.fsf@deeprootsystems.com>
 <1350899541.2768.82.camel@twins>
Message-ID: <87ehkqihdh.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, 2012-10-19 at 16:54 -0700, Kevin Hilman wrote:
>
>> So I did the same thing for my ARM SoC, and it definitley stops the RT
>> throttling.  
>> 
>> However, it has the undesriable (IMO) side effect of making timed printk
>> output rather unhelpful for debugging suspend/resume since printk time
>> stays constant throughout suspend/resume no matter how long you
>> sleep. :(
>> 
>> So does that mean we have to choose between useful printk times during
>> suspend/resume or functioning IRQ threads during suspend/resume ?
>
> Urgh.. this was not something I considered. This being primarily the
> sched_clock infrastructure and such.
>
> So what exactly is the problem with the suspend resume thing (its not
> something I've ever debugged), is all you need a clean break between pre
> and post suspend, or do you need the actual time the machine was gone?

I think it's more a question of what people are used to.  I think folks
used to debugging suspend/resume (at least on ARM) are used to having
the printk timestamps reflect the amount of time the machine was gone.

With a sched_clock() that counts during suspend, that feature doesn't
work anymore.  I'm not sure that this feature is a deal breaker, but it
has been convenient.  I see that on x86, it's already normal that
printk times don't reflect time spent in suspend, so I guess ARM needs
to adapt.  

Kevin
