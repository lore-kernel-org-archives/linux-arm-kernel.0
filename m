From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 13 Sep 2011 15:48:54 +0300
Subject: [PATCH 3/3] iommu/core: split mapping to page sizes as supported
	by the hardware
In-Reply-To: <20110913104433.GL11701@amd.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<1315421604-12286-3-git-send-email-ohad@wizery.com>
	<20110913101011.GK11701@amd.com>
	<CAK=WgbbhdFpAHTt=Bku-v1ZOCf48+u+XB-f4yO=5EDojv1kCJg@mail.gmail.com>
	<20110913104433.GL11701@amd.com>
Message-ID: <CAK=Wgbb_DZgH0jvgQr_Rt7G0-Cy0q2pHe+auBOtrFai-D-yMSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 1:44 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Not necessarily. You could implement this side-by-side with the old code
> until all drivers are converted and remove the old code then. This keeps
> bisectability.

Ok.

>> > Intel IOMMU does not support arbitrary page-sizes, afaik.
>>
>> It does; besides the usual 4K it has "super page sizes" support of
>> 2MB, 1GB, 512GB and 1TB.
>
> But the value ~0xfffUL indicates support for 4k, 8k, 16k .. 2^63, no?

Yes, I have done this intentionally, in order to retain the existing
behavior for IOMMU drivers which are already capable of handling
arbitrary page sizes (intel-iommu handles this in software, see
hardware_largepage_caps() and the code that uses it).

Long term, it might make more sense to remove
hardware_largepage_caps() (and the logic around it) and instead just
declare the real page sizes the hardware supports when calling
register_iommu(), but I guess it's up to Intel guys. For now it's just
safer to declare ~0xfffUL which really means: keep calling me with
sizes and alignments that are an order of 4KB, just like you always
did.
