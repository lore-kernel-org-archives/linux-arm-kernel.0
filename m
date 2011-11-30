From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 30 Nov 2011 18:04:56 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <20111130145958.GE21413@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
 <20111129151607.GE30966@redhat.com>
 <CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
 <20111130145958.GE21413@redhat.com>
Message-ID: <CAK=WgbYyFdLftE_kp2_JOThVhn-FzGsDqVqKn0Jwm2teQyZBNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 4:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> I see. And this happens because the ARM processor reorders
> memory writes

Yes.

> And in an SMP configuration, writes are somehow not reordered?

They are, but then the smp memory barriers are enough to control these
effects. It's not enough to control reordering as seen by a device
(which is what our AMP processors are) though.

(btw, the difference between an SMP processor and a device here lies
in how the memory is mapped: normal memory vs. device memory
attributes. it's an ARM thingy).

> Just checking that this is not a bug in the smp_wmb implementation
> for the specific platform.

No, it's not.

ARM's smp memory barriers use ARM's DMB instruction, which is enough
to control SMP effects, whereas ARM's mandatory memory barriers use
ARM's DSB instruction, which is required to ensure the ordering
between Device and Normal memory accesses.

Thanks,
Ohad.
