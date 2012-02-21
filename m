From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 21 Feb 2012 23:49:22 +0800
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler
 to avoid oops
In-Reply-To: <20120221154007.GB23133@mudshark.cambridge.arm.com>
References: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
 <20120221133228.GK19696@mudshark.cambridge.arm.com>
 <CACVXFVMxpRDsG_hNn_WaX17uEdZCJmcraOvDwCL6JQ7Xyz5nig@mail.gmail.com>
 <20120221151909.GA23133@mudshark.cambridge.arm.com>
 <CACVXFVOR7oF1nq9p55+3b2at2Appa_YyFEWhD=dF8jGfy0H+OQ@mail.gmail.com>
 <20120221154007.GB23133@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNrWgeEKjZyrEgugGrKkLz030aeMwwNWd_jwdMA5-=N=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 11:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Feb 21, 2012 at 03:34:58PM +0000, Ming Lei wrote:
>> On Tue, Feb 21, 2012 at 11:19 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Feb 21, 2012 at 02:02:32PM +0000, Ming Lei wrote:
>> >> On Tue, Feb 21, 2012 at 9:32 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> > I have a couple of patches that solve this by (a) clearing the overflow flag
>> >> > when disabling the counter for ARMv7 and (b) adding the event checks to the
>> >>
>> >> Maybe ARMv6 and xscale need to be fixed too if the overflow flag will be kept
>> >> even after the counter is disabled.
>> >
>> > I don't think so - seems like we clear the overflow flag already for those
>> > PMUs in the disable path (note that we write ~mask).
>>
>> mask is only the counters enable bits, both v6 and xscale don't clear their
>> overflow flag in disable callback.
>
> Sure they do. When we read-modify-write the pmcr we &= ~mask, so we end up
> writing the overflow flags back if they are set, which is sufficient to
> clear them.

Sorry for missing it, but looks xscale uses standalone overflow
register and does not
clear its overflow flag.


thanks,
-- 
Ming Lei
