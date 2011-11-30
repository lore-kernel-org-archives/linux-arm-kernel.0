From: mst@redhat.com (Michael S. Tsirkin)
Date: Wed, 30 Nov 2011 16:59:59 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
 <20111129151607.GE30966@redhat.com>
 <CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
Message-ID: <20111130145958.GE21413@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 01:45:05PM +0200, Ohad Ben-Cohen wrote:
> > So you put virtio rings in MMIO memory?
> 
> I'll be precise: the vrings are created in non-cacheable memory, which
> both processors have access to.
> 
> > Could you please give a couple of examples of breakage?
> 
> Sure. Basically, the order of the vring memory operations appear
> differently to the observing processor. For example, avail->idx gets
> updated before the new entry is put in the available array...

I see. And this happens because the ARM processor reorders
memory writes to this uncacheable memory?
And in an SMP configuration, writes are somehow not reordered?

For example, if we had such an AMP configuration with and x86
processor, wmb() (sfence) would be wrong and smp_wmb() would be sufficient.

Just checking that this is not a bug in the smp_wmb implementation
for the specific platform.

-- 
MST
