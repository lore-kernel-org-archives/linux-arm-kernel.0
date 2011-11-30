From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 30 Nov 2011 18:24:16 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <20111130161555.GB25812@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
 <20111129151607.GE30966@redhat.com>
 <CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
 <20111130145958.GE21413@redhat.com>
 <CAK=WgbYyFdLftE_kp2_JOThVhn-FzGsDqVqKn0Jwm2teQyZBNA@mail.gmail.com>
 <20111130161555.GB25812@redhat.com>
Message-ID: <CAK=WgbazBq4GVo16sZsrZirgMYbwMcWtPaqn90c6d9Phr0gh3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 6:15 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> How are the rings mapped? normal memory, right?

No, device memory.

> We allocate them with plan alloc_pages_exact in virtio_pci.c ...

I'm not using virtio_pci.c; remoteproc is allocating the rings using
the DMA API.

> Yes wmb() is required to ensure ordering for MMIO.
> But here both accesses: index and ring - are for
> memory, not MMIO.

I'm doing IO with a device over shared memory. It does require
mandatory barriers as I explained.

> Is this something you see in practice?

Yes. These bugs are very real.
