From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 May 2012 15:02:44 +0200
Subject: [PATCH 1/7] remoteproc: resource table overhaul
In-Reply-To: <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
Message-ID: <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

2012/5/17 Ohad Ben-Cohen <ohad@wizery.com>

> Hi Michal,
>
> On Sat, Mar 17, 2012 at 8:39 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > IOW: you can probably just wait a bit until this patch is ready and
> > take it into your tree. It will most likely bring back the behavior you
> > need :)
>
> Does something like the attached help ?
>

I have looked at it and tested on latest and greatest and the problem is
still there.  If you look at debug output below
you see that vrings are allocated before carveout area which is causing
that rtos text is not placed at 0x0 address.

I have looked at the code and path is
rproc_fw_config_virtio -> rproc_handliefirtion_rsc -> rproc_handle_vdev


~ # zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3
zynq_remoteproc 0.remoteproc-test: vdev rsc: id 7, dfeatures 1, cfg len 0,
2 vrings
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring0: da 400000, qsz 256,
align 256
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring1: da 404000, qsz 256,
align 256
zynq_remoteproc 0.remoteproc-test: vring0: va d1000000 dma 0 size 2000 idr 0
zynq_remoteproc 0.remoteproc-test: vring1: va d1002000 dma 2000 size 2000
idr 1
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test
zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 2353146
zynq_remoteproc 0.remoteproc-test: iommu not found
zynq_remoteproc 0.remoteproc-test: rsc: type 0
zynq_remoteproc 0.remoteproc-test: carveout rsc: da 0, pa 0, len 20ec20,
flags 0
zynq_remoteproc 0.remoteproc-test: carveout va d1400000, dma 400000, len
0x20ec20
zynq_remoteproc 0.remoteproc-test: rsc: type 3
zynq_remoteproc 0.remoteproc-test: rsc: type 2


For me it is necessary to ensure that dma_alloc_coherent in
rproc_alloc_vring is called after carveout allocation
just because dma_alloc_cohorent takes mermory from preallocated pool which
starts at 0x0. I also don't have
any other advance mechanism how to ensure mapping for the second arm core.

Here is log which I need to get. Look at attached patch which exactly show
you what I need to do which I have tested.
Maybe it is not big deal and I can use mainline remoteproc version and use
this patch to be in sync with mainline code.

zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0
zynq_remoteproc 0.remoteproc-test: carveout rsc: da 0, pa 0, len 20ec20,
flags 0
zynq_remoteproc 0.remoteproc-test: carveout va d1000000, dma 0, len 0x20ec20
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 2
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 0
zynq_remoteproc 0.remoteproc-test: rproc_handle_virtio_rsc: rsc type 3
zynq_remoteproc 0.remoteproc-test: vdev rsc: id 7, dfeatures 1, cfg len 0,
2 vrings
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring0: da 400000, qsz 256,
align 4096
zynq_remoteproc 0.remoteproc-test: vdev rsc: vring1: da 404000, qsz 256,
align 4096
zynq_remoteproc 0.remoteproc-test: vring0: va d1400000 dma 400000 size 3000
idr 0
zynq_remoteproc 0.remoteproc-test: vring1: va d1404000 dma 404000 size 3000
idr 1
zynq_remoteproc 0.remoteproc-test: powering up 0.remoteproc-test
zynq_remoteproc 0.remoteproc-test: Booting fw image test, size 2353146
zynq_remoteproc 0.remoteproc-test: iommu not found
zynq_remoteproc 0.remoteproc-test: rsc: type 0
zynq_remoteproc 0.remoteproc-test: rsc: type 3
zynq_remoteproc 0.remoteproc-test: rsc: type 2

Thanks,
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/3ce0a16c/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-remoteproc-Allocate-carveout-area-before-vrings-allo.patch
Type: application/octet-stream
Size: 2773 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/3ce0a16c/attachment.obj>
