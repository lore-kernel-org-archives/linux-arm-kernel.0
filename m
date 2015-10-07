From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Oct 2015 12:20:11 +0100
Subject: [PATCH] arm: perf: Add event descriptions
In-Reply-To: <20150924175257.GH7356@arm.com>
References: <20150804001522.GA13214@dreric01-gentoo.localdomain>
 <20150817205809.GA16506@dreric01-gentoo.localdomain>
 <20150826165148.GF30466@arm.com>
 <20150817214035.GA25775@dreric01-gentoo.localdomain>
 <20150924175257.GH7356@arm.com>
Message-ID: <20151007112011.GH16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again, Drew,

On Thu, Sep 24, 2015 at 06:52:57PM +0100, Will Deacon wrote:
> On Mon, Aug 17, 2015 at 10:40:36PM +0100, Drew Richardson wrote:
> > So my suggestion to solve the problem is that the kernel can have the
> > list of events as proposed in the patch.
> 
> Sorry, but I just don't buy this argument. Your problem is that the user
> needs to be running an up-to-date perf tool, but with your proposed
> solution, you're asking them to update the *kernel* instead, which is
> (unfortunately) one of the hardest pieces of software to upgrade on a
> typical ARM platform.

I've spent some time thinking about this and, actually, it makes sense
to do this for the architected events. These event numbers are guaranteed
to be portable between CPUs, so if we expose those through sysfs then
we don't have this dependency on updating the kernel for newer cores
(well, once the initial period without your patch has expired). It's the
noon-portable, micro-architectural events that I object to.

So how about you roll a new version of this patch just exposing the
architected events and making use of the macros in perf_event.h to make
it a bit tidier (PMU_EVENT_ATTR, PMU_EVENT_ATTR_STRING etc)?

Be aware that there's a fair amount of arm64 perf patches queue for 4.4,
since we're moving over to the code in drivers/perf/. Hopefully these
will appear on the arm64 for-next/core branch shortly.

Will
