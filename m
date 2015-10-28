From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 14:29:40 +0000
Subject: [PATCH] arm: perf: Add event descriptions
In-Reply-To: <5630D840.6050706@codeaurora.org>
References: <20150804001522.GA13214@dreric01-gentoo.localdomain>
 <20150817205809.GA16506@dreric01-gentoo.localdomain>
 <20150826165148.GF30466@arm.com>
 <20150817214035.GA25775@dreric01-gentoo.localdomain>
 <20150924175257.GH7356@arm.com> <20151007112011.GH16065@arm.com>
 <562F9C44.50702@codeaurora.org> <20151027160412.GI3091@leverpostej>
 <5630D840.6050706@codeaurora.org>
Message-ID: <20151028142940.GE25451@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 10:14:24AM -0400, Christopher Covington wrote:
> On 10/27/2015 12:04 PM, Mark Rutland wrote:
> > On Tue, Oct 27, 2015 at 11:46:12AM -0400, Christopher Covington wrote:
> >> On 10/07/2015 07:20 AM, Will Deacon wrote:
> >>> Hi again, Drew,
> >>>
> >>> On Thu, Sep 24, 2015 at 06:52:57PM +0100, Will Deacon wrote:
> >>>> On Mon, Aug 17, 2015 at 10:40:36PM +0100, Drew Richardson wrote:
> >>>>> So my suggestion to solve the problem is that the kernel can have the
> >>>>> list of events as proposed in the patch.
> >>>>
> >>>> Sorry, but I just don't buy this argument. Your problem is that the user
> >>>> needs to be running an up-to-date perf tool, but with your proposed
> >>>> solution, you're asking them to update the *kernel* instead, which is
> >>>> (unfortunately) one of the hardest pieces of software to upgrade on a
> >>>> typical ARM platform.
> >>>
> >>> I've spent some time thinking about this and, actually, it makes sense
> >>> to do this for the architected events. These event numbers are guaranteed
> >>> to be portable between CPUs, so if we expose those through sysfs then
> >>> we don't have this dependency on updating the kernel for newer cores
> >>> (well, once the initial period without your patch has expired). It's the
> >>> noon-portable, micro-architectural events that I object to.
> >>>
> >>> So how about you roll a new version of this patch just exposing the
> >>> architected events and making use of the macros in perf_event.h to make
> >>> it a bit tidier (PMU_EVENT_ATTR, PMU_EVENT_ATTR_STRING etc)?
> >>>
> >>> Be aware that there's a fair amount of arm64 perf patches queue for 4.4,
> >>> since we're moving over to the code in drivers/perf/. Hopefully these
> >>> will appear on the arm64 for-next/core branch shortly.
> >>
> >> Have you considered using OF/ACPI to describe this aspect of the hardware?
> > 
> > FW-provided data structures are going to be harder to upgrade than the
> > kernel, so the same argument applies as with placing this data in the
> > kernel (if anything, more strongly).
> 
> A convenient place for workarounds is great, when necessary, but I don't see
> why Plan A for hardware description should be anything other than standardized
> hardware description mechanisms.
> 
> Why are you eager to inflate the expectations of firmware when it comes to
> power state coordination but reluctant to rely on firmware for describing
> performance monitor events?

Firmware has the responsibility to describe the integration details of
the PMU (the interrupt routing), because that varies between platforms.
The set of supported events does not, for a given PMU (e.g. the events
supported by a Cortex-A57 are the same regardless of whether it's
integrated an ARM Juno or an AMD Seattle), and are effectively part of
the programming model of the device.

Power state coordination is very much platform specific; and is not
comparable.

Thanks,
Mark.
