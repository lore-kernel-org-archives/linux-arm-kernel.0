From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 26 Feb 2012 20:30:17 +0200
Subject: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin
 omap3isp
In-Reply-To: <3215700.hj2jFm3b0A@avalon>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com>
 <3215700.hj2jFm3b0A@avalon>
Message-ID: <CAK=WgbYkVALqrVMVv1ma3WzN5dYriM8X0MfwH4knwWwojB6hjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Sun, Feb 26, 2012 at 7:34 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Sunday 26 February 2012 12:14:14 Ohad Ben-Cohen wrote:
>> omap3isp depends on omap's iommu and will fail to probe if
>> initialized before it (which always happen if they are builtin).
>>
>> Make omap's iommu subsys_initcall as an interim solution until
>> the probe deferral mechanism is merged.
>
> How will that fix the problem ?

Sorry, I'm not entirely sure I understand the question: are you asking
about this patch or about the probe deferral thingy ?

> I'm fine with this patch, as it fixes the problem as well, although I still
> believe modifying the link order would be a better fix in this case.

I'm personally not a huge fan of implicit link order dependencies, as
someone may change the order in the future (for whatever benign
reason) without even realizing he's breaking drivers.

>> +/* must be ready before omap3isp is probed */
>
> The problem is not limited to the omap3isp driver, the DSP driver could be
> affected as well.

If you refer to tidspbridge, then I'm not sure it has the same issue:
IIUC it doesn't enable the iommu hw on probe; only in response to an
ioctl command (btw, tidspbridge doesn't even use this omap iommu
driver - it manipulates the iommu registers directly. iicks.)

The omap4 solutions (remoteproc et al.) will only enable the iommu
after userspace is alive, so no risk there as well.

Thanks,
Ohad.
