From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Dec 2017 16:00:26 +0000
Subject: [PATCH] perf: qcom_l2_pmu: don't allow guest access
In-Reply-To: <d42a3430-a365-4fd3-bfd4-efa567f777a8@codeaurora.org>
References: <1512575733-923-1-git-send-email-nleeder@codeaurora.org>
 <20171206161149.ezlzzcuvxbot5tio@lakrids.cambridge.arm.com>
 <bc650fac-702c-e554-43ca-9cd3cfed9696@codeaurora.org>
 <20171207133812.GG31900@arm.com>
 <d42a3430-a365-4fd3-bfd4-efa567f777a8@codeaurora.org>
Message-ID: <20171207160025.GA15393@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 10:44:04AM -0500, Leeder, Neil wrote:
> On 12/7/2017 8:38 AM, Will Deacon wrote:
> > On Wed, Dec 06, 2017 at 04:19:24PM -0500, Leeder, Neil wrote:
> >> On 12/6/2017 11:11 AM, Mark Rutland wrote:
> >>> On Wed, Dec 06, 2017 at 10:55:33AM -0500, Neil Leeder wrote:
> >>>> Guests cannot access IMPDEF system registers, which are used
> >>>> by this driver. Disable the driver if it's running in a guest VM.
> >>>>
> >>>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> >>>> ---
> >>>>  drivers/perf/qcom_l2_pmu.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>
> >>> I'm a little confused by this. Why is this hypervisor providing a
> >>> QCOM8130 device to the guest that it cannot use?
> >>>
> >>> Could you elaborate on what's going on?
> >>>
> >>
> >> While there's an argument that the guest shouldn't be loading the driver
> >> in the first place, we can't control everyone's guest configuration or what
> >> their hypervisor does.
> > 
> > Ok, but why is the hypervisor advertising a device that effectively doesn't
> > exist? Most drivers trust the firmware tables they are given, so this makes
> > it sound like we should start annotating all drivers for devices that we
> > don't expect to see in a guest with is_hyp_mode_available() checks.
> > 
> > That doesn't feel quite right to me.
> 
> Hi Will,
> 
> I suspect that most mis-configured drivers don't fail until they're used, or are
> otherwise Mostly Harmless. The problem here is that this driver uses IMPDEF system
> registers in its init, and I'd guess only a minority of drivers do that. So it
> crashed the kernel with an illegal instruction on boot. I'm trying to be a good
> citizen here and not allow my driver to stop a kernel from booting because someone
> misconfigured something out of my control.

FWIW, I'm not blaming you here :)

But I don't think it's the case that "mis-configured" drivers are generally
harmless. For example, if the base address of a device is junk, then the
guest could spin on something that is supposed to be a status flag but is in
fact something else. Or we could end up accessing something that is a
translation fault at stage-2, and subsequently dying. Or registering a
shared IRQ line that we don't care about and consequently breaking some
other driver.

The fact is that Linux drivers trust the firmware tables, and your patch
doesn't change that. Besides, what if one day you want to have the guest
access the L2 PMU driver?

The correct fix is not to advertise the device in the ACPI tables being
provided by the hypervisor. I still don't have an understanding for why
that's happening in the first place.

Will
