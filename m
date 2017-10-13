From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Fri, 13 Oct 2017 20:38:13 +0200
Subject: [PATCH 05/37] KVM: Record the executing ioctl number on the vcpu
 struct
In-Reply-To: <20171013173151.GA17578@cbox>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
 <20171012104141.26902-6-christoffer.dall@linaro.org>
 <20171013171307.GA16116@flask> <20171013173151.GA17578@cbox>
Message-ID: <20171013183812.GA26563@flask>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-13 19:31+0200, Christoffer Dall:
> On Fri, Oct 13, 2017 at 07:13:07PM +0200, Radim Kr?m?? wrote:
> > I think that other (special) callsites of vcpu_load()/vcpu_put() have a
> > well defined IOCTL that can be used instead of vcpu->ioctl, so we could
> > just pass the ioctl value all the way to arch code and never save it
> > anywhere,
> 
> I don't think that works; what would you do with preempt notifier calls?

Right, BUG :), I didn't consider them before and they need to know.

> One solution is to add a parameter to vcpu_put, lie for vcpu_load, which
> also sets the ioctl, and other callers than the final vcpu_put in
> kvm_vcpu_ioctl() just pass the existing value, where the kvm_vcpu_ioctl
> call can pass 0 which gets set before releasing the mutex.
> 
> Can you think of a more elegant solution?

Not really, only thought of touching preempt notifiers and it seems to
be more complicated.

I think we shouldn't restore ioctl on vcpu_put() at all -- the value
isn't well defined outside of the mutex, so there is no point in looking
and we can just zero the ioctl.

Actually, I wouldn't rely on the existing value at all because that.
The need for load/put depends on the current code path, not on the one
we race with.

x86 seems to be the only user of vcpu_load() outside of kvm_vcpu_ioctl()
and the callers are either under a VM ioctl or under a VM destruction
paths (invalid IOCTL) and we can just hardcode that.

Passing 0 to all other vcpu_load()s and unconditionally zeroing ioctl
before mutex_unlock() should work.
