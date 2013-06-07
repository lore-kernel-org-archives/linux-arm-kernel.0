From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 7 Jun 2013 14:22:08 +0530
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <CAAVeFuKxRuLdhO+-+YHG=c-TNGUUJbDj5AHj+K5e8y1JDEDksg@mail.gmail.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <CABb+yY2SFfejMbbYOebMCUuMtAZF3u-yc+6z_MJTG2oOeSwL_g@mail.gmail.com>
 <CAAVeFuKxRuLdhO+-+YHG=c-TNGUUJbDj5AHj+K5e8y1JDEDksg@mail.gmail.com>
Message-ID: <CABb+yY38wSqfju0HOfMDpGQxgr1pFYkJGH3aa5fPOz2YpCCGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 12:43 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Thu, Jun 6, 2013 at 9:26 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Thu, Jun 6, 2013 at 12:58 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>>> Boot loaders on some Tegra devices can be unlocked but do not let the
>>> system operate without SecureOS. SecureOS prevents access to some
>>> registers and requires the operating system to perform certain
>>> operations through Secure Monitor Calls instead of directly accessing
>>> the hardware.
>>>
>> IOW, some critical h/w controls on Tegra are accessible only from
>> Secure mode (not unusual). So if we(Linux) run in NS mode we need to
>> make calls to the SecureOS, over SMC, to do things for us?
>
> Exactly.
>
OK so this just an instance of a situation that is going to be more
common in future - most modern cpus (CortexA based at least) support
TrustZone and it's a matter of device functionality before a board
designer chucks the Linux kernel (that we usually run in Secure mode
while development) into NS mode and have some
SecureOS/TrustedOS/Hypervisor et al control access to the secure
peripherals from Secure Mode.

>>> This patch introduces basic SecureOS support for Tegra. SecureOS support
>>> can be enabled by adding a "nvidia,secure-os" property to the "chosen"
>>> node of the device tree.
>>>
>> Probably just a nit, but shouldn't it be "nvidia,nonsecure-os"
>> instead, denoting the mode Linux is going to run?  (and then I wonder
>> if we could detect the mode (S or NS) at runtime and avoid this flag
>> at all).
>
> Detection of the secure mode at runtime would only solve half of the
> issue: we would know that we are running in non-secure mode, but we
> would still not know what monitor is operating. Detecting that part is
> impossible AFAIK, so I'm afraid we need to pass that information
> through the DT here.
>
Yes, Stephen's suggestion is far more generally applicable. We should
go for it, just bearing in mind that ABI need and type is going to be
board specific.

Cheers,
-Jassi
