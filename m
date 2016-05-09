From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 9 May 2016 17:03:12 -0600
Subject: [PATCH v9 7/7] vfio/type1: return MSI geometry through
 VFIO_IOMMU_GET_INFO capability chains
In-Reply-To: <5729E5BB.1030101@linaro.org>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
 <1462362858-2925-8-git-send-email-eric.auger@linaro.org>
 <5729E5BB.1030101@linaro.org>
Message-ID: <20160509170312.06e9c4fe@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 May 2016 14:06:19 +0200
Eric Auger <eric.auger@linaro.org> wrote:

> Hi Alex,
> On 05/04/2016 01:54 PM, Eric Auger wrote:
> > This patch allows the user-space to retrieve the MSI geometry. The
> > implementation is based on capability chains, now also added to
> > VFIO_IOMMU_GET_INFO.  
> 
> If you prefer we could consider this patch outside of the main series
> since it brings extra functionalities (MSI geometry reporting). In a
> first QEMU integration we would live without knowing the MSI geometry I
> think, all the more so I currently report an arbitrary number of
> requested IOVA pages. The computation of the exact number of doorbells
> to map brings extra complexity and I did not address this issue yet.
> 
> It sketches a possible user API to report the MSI geometry based on the
> capability chains, as you suggested some time ago. I am currently busy
> drafting a QEMU integration.

How would the user know that reserved MSI mappings are requires or
available without this?  Wouldn't the only option be for userspace to
try to map something with the reserved MSI flag set and see if the
kernel accepts it?  That's not a very desirable programming model.  The
arbitrary size is pretty ugly, but it at least makes for a consistent
user interface.  Is it a functional issue if we overestimate the size
or is it just a matter of wasting IOVA space?  Is there significant
harm in making it obscenely large, like 1MB?  The reference counting and
re-use of IOVA pages seems like we may often only be using a single
IOVA page for multiple doorbells.  I guess I'm leaning towards defining
the API even if the value is somewhat arbitrary because we'd rather have
control of this rather than having the user guess and try to rope them
back in later to use a kernel recommended value.  Thanks,

Alex
