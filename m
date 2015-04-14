From: robdclark@gmail.com (Rob Clark)
Date: Tue, 14 Apr 2015 17:48:48 -0400
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <20150414211720.GA56647@MBP>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <20150414163613.GM28709@leverpostej>
 <07185B2C-3F37-4E70-9096-1EF5EA8D68CE@codeaurora.org>
 <20150414211720.GA56647@MBP>
Message-ID: <CAF6AEGtoxNrCoxT5n0CXmKMnL-YprJ3DkAuM4Myi87WMxPqBGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 5:17 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Apr 14, 2015 at 02:49:04PM -0500, Kumar Gala wrote:
>> On Apr 14, 2015, at 11:36 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Apr 10, 2015 at 11:05:29AM +0100, Catalin Marinas wrote:
>> >> On Thu, Apr 09, 2015 at 12:37:06PM -0500, Kumar Gala wrote:
>> >>> This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.
>> >>>
>> >>> To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
>> >>> setup the boot/release addresses for the secondary CPUs.  In addition we need
>> >>> a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
>> >>> CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
>> >>> firmware that does not support those methods.
>> >>
>> >> And the reason is? Some guesses:
>> >>
>> >> a) QC doesn't think boot interface (and cpuidle) standardisation is
>> >>   worth the effort (to put it nicely)
>> >> b) The hardware was available before we even mentioned PSCI
>> >> c) PSCI is not suitable for the QC's SCM interface
>> >> d) Any combination of the above
>> >>
>> >> I strongly suspect it's point (a). Should we expect future QC hardware
>> >> to do the same?
>> >>
>> >> You could argue the reason was (b), though we've been discussing PSCI
>> >> for at least two years and, according to QC press releases, MSM8916
>> >> started sampling in 2014.
>> >>
>> >> The only valid reason is (c) and if that's the case, I would expect a
>> >> proposal for a new firmware interface protocol (it could be PSCI-based),
>> >> well documented, that can be shared with others that may encounter the
>> >> same shortcomings.
>> >
>> > There's no need to even fork PSCI. The PSCI specification will evolve
>> > over time as vendors request changes and we try to accomodate them.
>> >
>> > If there's something that PSCI doesn't do that you need it to, contact
>> > ARM. Other vendors already have.
>
> Mostly yes but there may be valid reasons for not being able to use
> PSCI. The spin-table method is still a firmware interface, though not
> necessarily secure (a.k.a. SMC-based). The ACPI parking protocol is
> another and, who knows, maybe we define a way to park CPUs back to
> firmware without SMC calls (when EL3 is not available).
>
>> But what is someone to do between the period of getting PSCI spec
>> updated and needing to ship a product with firmware?
>>
>> The take still sounds like if you don?t implement an exact version of
>> PSCI you are screwed from being supported in the upstream ARM64
>> kernel.
>
> These are silly arguments. There is a big difference between "we
> couldn't get the firmware implementing the standard for the early
> silicon but we are working on fixing it for future revisions" vs. "we
> don't give a s**t about these standards, the kernel must be inclusive".
> So please make up your mind on which direction you want to pursue.
>

Just speaking as an outsider to this topic, but seems like most/all
tablets/phones/etc ship with signed firmware.  Which means for most of
the population, upgrading the firmware to a new version which did
support the standard (assuming it existed), isn't really an option on
our devices, any more than fixing buggy acpi tables is on our
laptops..

BR,
-R


> --
> Catalin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
