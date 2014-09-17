From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 17 Sep 2014 19:45:27 +0100
Subject: [PATCH v5 11/12] sched: replace capacity_factor by utilization
In-Reply-To: <20140915200159.GE2840@worktop.localdomain>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-12-git-send-email-vincent.guittot@linaro.org>
 <20140911161517.GA3190@worktop.ger.corp.intel.com>
 <CAKfTPtDFuzxzGBKi_n6v_F8FUkQ84MW+dQBX4WNXo-o54mksGA@mail.gmail.com>
 <20140914194156.GC2832@worktop.localdomain>
 <20140915114229.GB3037@worktop.localdomain>
 <alpine.LFD.2.11.1409151451540.8647@knanqh.ubzr>
 <20140915200159.GE2840@worktop.localdomain>
Message-ID: <20140917184527.GB9854@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 09:01:59PM +0100, Peter Zijlstra wrote:
> On Mon, Sep 15, 2014 at 03:07:44PM -0400, Nicolas Pitre wrote:
> > On Mon, 15 Sep 2014, Peter Zijlstra wrote:
> 
> > Let's suppose a task running on a 1GHz CPU producing a load of 100.
> > 
> > The same task on a 100MHz CPU would produce a load of 1000 because that 
> > CPU is 10x slower.  So to properly evaluate the load of a task when 
> > moving it around, we want to normalize its load based on the CPU 
> > performance.  In this case the correction factor would be 0.1.
> > 
> > Given those normalized loads, we need to scale CPU capacity as well.  If 
> > the 1GHz CPU can handle 50 of those tasks it has a capacity of 5000.
> > 
> > In theory the 100MHz CPU could handle only 5 of those tasks, meaning it 
> > has a normalized capacity of 500, but only if the load metric is already 
> > normalized as well.
> > 
> > Or am I completely missing the point here?
> 
> So I was thinking of the usage as per the next patch; where we decide if
> a cpu is 'full' or not based on the utilization measure. For this
> measure we're not interested in inter CPU relations at all, and any use
> of capacity scaling simply doesn't make sense.

Right. You don't need to scale capacity to determine whether a cpu is
full or not if you don't have DVFS, but I don't think it hurts if it is
done right. We need the scaling to figure out how much capacity is
available.

> But I think you asking this question shows a 'bigger' problem in that
> the Changelogs are entirely failing at describing the actual problem and
> proposed solution. Because if that were clear, I don't think we would be
> having this particular discussion.

Yes, the bigger problem of scaling things with DVFS and taking
big.LITTLE into account is not addressed in this patch set. This is the
scale-invariance problem that we discussed at Ksummit.

I will send a few patches shortly that provides the usage
scale-invariance. The last bit missing is then to scale capacity too (in
the right places), such that we can determine whether as cpu is full or
not, and how much spare capacity it has by comparing scale usage
(utilization) with scaled capacity. Like in Nico's example above.

Morten
