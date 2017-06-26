From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 26 Jun 2017 14:19:57 -0700
Subject: [PATCH v3 2/3] remoteproc/keystone: Add a remoteproc driver for
 Keystone 2 DSPs
In-Reply-To: <1f8d65fc-0acc-499e-a98e-953dce60750f@ti.com>
References: <20170613234513.7624-1-s-anna@ti.com>
 <20170613234513.7624-3-s-anna@ti.com>
 <20170625201545.GA26155@builder>
 <1ccd9273-0fde-4241-6d99-1d03be2f5b57@ti.com>
 <20170626200608.GG18666@tuxbook>
 <1f8d65fc-0acc-499e-a98e-953dce60750f@ti.com>
Message-ID: <20170626211957.GH18666@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 26 Jun 13:20 PDT 2017, Suman Anna wrote:

> On 06/26/2017 03:06 PM, Bjorn Andersson wrote:
> > On Mon 26 Jun 08:54 PDT 2017, Suman Anna wrote:
> >> On 06/25/2017 03:15 PM, Bjorn Andersson wrote:
[..]
> > I still would like to have resources allocated at probe() time, so I
> > would appreciate a follow up patch moving the request_irq()s to probe,
> > per above comment (but we can take that after v4.13).
> 
> OK thanks. This is a common theme across all the remoteproc drivers
> supporting rpmsg, and I definitely need to disable them in probe since
> the boot or the virtio/rpmsg devices are not guaranteed to be present in
> the probe.
> 

We have a consistent struct rproc after rproc_alloc(). So before the
virtio device (rpmsg in your case) calls virtio_find_vqs() rvring->vq
will be NULL and rproc_vq_interrupt() is a nop.

So AFAICT it should be fine to register this at probe time and leave it
enabled...but there's a lot of moving parts involved here, so it's
possible that I'm missing something.


But in for both interrupts it's important to disable them before calling
rproc_free(), as this will free the memory passed to the interrupt
handler.

Regards,
Bjorn
