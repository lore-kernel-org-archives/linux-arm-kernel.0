From: drjones@redhat.com (Andrew Jones)
Date: Mon, 2 Mar 2015 18:05:19 +0100
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <54F49610.6090000@redhat.com>
References: <20150219175518.GB26965@hawk.usersys.redhat.com>
 <54E62404.9040702@redhat.com>
 <20150220142905.GA10942@hawk.usersys.redhat.com>
 <CAKv+Gu-YUzmnACZQi98OPRgKKL+gAGqwWYq2-_dwCdNqcktNUg@mail.gmail.com>
 <20150220153626.GB10942@hawk.usersys.redhat.com>
 <20150224145529.GA5498@hawk.usersys.redhat.com>
 <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
 <20150302163146.GB9686@lvm> <54F49418.5070108@redhat.com>
 <54F49610.6090000@redhat.com>
Message-ID: <20150302170519.GB14186@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 05:55:44PM +0100, Laszlo Ersek wrote:
> On 03/02/15 17:47, Paolo Bonzini wrote:
> > 
> > Also, we may want to invalidate the cache for dirty pages before
> > returning the dirty bitmap, and probably should do that directly in
> > KVM_GET_DIRTY_LOG.
> 
> "I agree."
> 
> If KVM_GET_DIRTY_LOG is supposed to be atomic fetch and clear (from
> userspace's aspect), then the cache invalidation should be an atomic
> part of it too (from the same aspect).
> 
> (Sorry if I just said something incredibly stupid.)
>

With the path I'm headed down, all cache maintenance operations will
be done before exiting to userspace (and after returning). I was
actually already letting a feature creep into this PoC by setting
KVM_MEM_LOG_DIRTY_PAGES when we see KVM_MEM_INCOHERENT has been set,
and the region isn't readonly. The dirty log would then be used by
KVM internally to know exactly which pages need to be invalidated
before the exit.

drew
