From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 3 Jul 2015 23:01:10 +0200
Subject: [PATCH 11/13] KVM: arm64: implement ITS command queue command
 handlers
In-Reply-To: <5596B0D0.3080505@arm.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-12-git-send-email-andre.przywara@arm.com>
 <20150628194148.GM28244@cbox> <5596B0D0.3080505@arm.com>
Message-ID: <20150703210110.GA10878@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 04:57:04PM +0100, Andre Przywara wrote:
> Hi Christoffer,
> 
> ....
> 
> >> +
> >> +static struct its_collection *vits_new_collection(struct kvm *kvm, u32 coll_id)
> >> +{
> >> +	struct its_collection *collection;
> >> +
> >> +	collection = kmalloc(sizeof(struct its_collection), GFP_KERNEL);
> > 
> > If I manage to understand the structure here, you're calling all these
> > handler functions with a spinlock held so any operation that may sleep
> > could cause your system to deadlock.
> > 
> > I'll stop looking for these and recommend you go over the whole series
> > for these.
> 
> Do you reckon it would be sufficient to just avoid the kmallocs inside
> the lock? For this case above we could go with some storage space
> preallocated outside of the lock (I hope).
> 

Yes, you can preallocate or you need to grab a mutex instead of a
spinlock...

> > 
> > Perhaps the right thing to do is to synchronize access to your data
> > structure (why you hold the spinlock right?) with RCU if you can...
> 
> Well, the point is that there is not one ITS data structure, but it's a
> mesh of lists connected to each other. I'd like to avoid going down with
> RCU there, so I'd like to keep it all under one lock.
> I wonder if this could be mutex_lock_interruptible, though. From the top
> of your head, is there anything that would prevent that? I reckon ITS
> access contention is rather rare (though possible), so a sleeping VCPU
> wouldn't harm us so much in practice, would it?
> 
We know from experience from x86 that one of the things they had to look
at was to get the run-loop lock-free, and we went through a lot of
effort to do that on ARM too.  Along came the vgic and that was out the
window, and now it feels like we're just grabbing spinlocks all over the
place.

I'm fine with a mutex if other solutions are not easy/possible and it's
in a truly non-critical path, but I wouldn't to speculate about the
level of contention at this point without profiling something.

In any case, let's fix the potential host-kernel deadlock issues in the
most elegant way first and let's try to think about not grabbing too
many spinlocks in this code and take it from there.

Thanks,
-Christoffer
