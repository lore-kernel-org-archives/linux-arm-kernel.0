From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Feb 2015 11:12:58 +0000
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <54DB12B5.4080000@samsung.com>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <1422347154-15258-2-git-send-email-sumit.semwal@linaro.org>
 <54DB12B5.4080000@samsung.com>
Message-ID: <20150211111258.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 09:28:37AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> On 2015-01-27 09:25, Sumit Semwal wrote:
> >Add some helpers to share the constraints of devices while attaching
> >to the dmabuf buffer.
> >
> >At each attach, the constraints are calculated based on the following:
> >- max_segment_size, max_segment_count, segment_boundary_mask from
> >    device_dma_parameters.
> >
> >In case the attaching device's constraints don't match up, attach() fails.
> >
> >At detach, the constraints are recalculated based on the remaining
> >attached devices.
> >
> >Two helpers are added:
> >- dma_buf_get_constraints - which gives the current constraints as calculated
> >       during each attach on the buffer till the time,
> >- dma_buf_recalc_constraints - which recalculates the constraints for all
> >       currently attached devices for the 'paranoid' ones amongst us.
> >
> >The idea of this patch is largely taken from Rob Clark's RFC at
> >https://lkml.org/lkml/2012/7/19/285, and the comments received on it.
> >
> >Cc: Rob Clark <robdclark@gmail.com>
> >Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> 
> The code looks okay, although it will probably will work well only with
> typical cases like 'contiguous memory needed' or 'no constraints at all'
> (iommu).

Which is a damn good reason to NAK it - by that admission, it's a half-baked
idea.

If all we want to know is whether the importer can accept only contiguous
memory or not, make a flag to do that, and allow the exporter to test this
flag.  Don't over-engineer this to make it _seem_ like it can do something
that it actually totally fails with.

As I've already pointed out, there's a major problem if you have already
had a less restrictive attachment which has an active mapping, and a new
more restrictive attachment comes along later.

It seems from Rob's descriptions that we also need another flag in the
importer to indicate whether it wants to have a valid struct page in the
scatter list, or whether it (correctly) uses the DMA accessors on the
scatter list - so that exporters can reject importers which are buggy.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
