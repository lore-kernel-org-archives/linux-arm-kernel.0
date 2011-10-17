From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 17 Oct 2011 10:05:02 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAK=Wgbar+z_Nm1cDM4bJgrP5yWbjCsVBW=orfYwsZsT7uET8ng@mail.gmail.com>
References: <20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
	<20111011103820.GF2138@amd.com>
	<CAK=WgbYOUZNX0OmRwZNO1mMG+3DZXwff+S60ESWixf04HOcbtw@mail.gmail.com>
	<20111014133510.GC2198@amd.com>
	<CAK=Wgbar+z_Nm1cDM4bJgrP5yWbjCsVBW=orfYwsZsT7uET8ng@mail.gmail.com>
Message-ID: <CAK=WgbbQ9RRFmMXGOK2An7f0QkObYigv_OWXALFr+Bchw97j9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Fri, Oct 14, 2011 at 7:03 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, Oct 14, 2011 at 3:35 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
>> Hmm, I'd like to constify the iommu_ops structures in the future. This
>> wouldn't work then anymore. How about renaming it to io_page_size
>> (because it is the base page-size of the iommu) and let the driver set
>> it?
>
> Sure, that'd work. Though asking the driver to provide this feels a
> bit redundant, as it already provided this info in the supported page
> sizes.
>
> I guess a cleaner solution might be allocating a 'struct iommu' in
> which drivers will set a 'const struct iommu_ops *' member. That new
> struct would then contain the base page-size and any other state the
> iommu core would ever need.
>
> This whole thing is quite marginal though and also very easy to change
> later, so we can start with the "driver-provided io_page_size"
> approach for now.

Sorry, I just couldn't get myself to sign-off this as it really feels
wrong to me.

This min_pagesz member is just cached by the core so it doesn't need to
look it up every time we're mapping. Drivers shouldn't care about it, as it's
completely internal to the iommu core. I'm afraid that pushing this to
the drivers
feels like redundant duplication of code and might also confuse developers.

Let me please suggest two alternatives:
a) drop this min_pagesz cache completely. iommu core would then redundantly
  re-calculate this every time something is mapped, but I hardly believe there
  is going to be a measurable impact on performance.
b) keep the current implementation for now, and fix this later (when we constify
  struct iommu_ops *) by caching min_pagesz in a dynamically allocated iommu
  context. Since this future "constify" patch will anyway need to change 'struct
  bus_type', it would be a good opportunity to do this change at the same time.

I don't mind which of those approaches to take, and I also don't mind doing (b)
myself later, in a separate patch. Your call.

>> This needs to be (left > 0). The drivers are allowed to unmap more then
>> requested, so this value may turn negative.
>
> Good point. 'left' is size_t though, so i'll fix this a bit differently.

Fixed, please take a look:
