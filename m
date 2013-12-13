From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Dec 2013 09:13:47 -0600
Subject: [PATCH] arm64: print cpu frequency in /proc/cpuinfo
In-Reply-To: <20131213142407.GI4360@n2100.arm.linux.org.uk>
References: <1386924222-23169-1-git-send-email-vkale@apm.com>
 <20131213103632.GC19177@mudshark.cambridge.arm.com>
 <CAL_Jsq+Z9K4sus6xwN9KYyCUVWy7NFBQCGYvz0wrt=J7h+G35Q@mail.gmail.com>
 <20131213142407.GI4360@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqLPnm4j8zAWehw=8o3r8CUKs=eiGEYYDR=dVdR87-arcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 8:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 13, 2013 at 08:16:16AM -0600, Rob Herring wrote:
>> On Fri, Dec 13, 2013 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Dec 13, 2013 at 08:43:42AM +0000, Vinayak Kale wrote:
>> >> Print the cpu frequency field in /proc/cpuinfo.
>> >
>> > Why? ["x86 does this" isn't a valid answer :)].
>>
>> People want to know this stuff.
>
> People want to know this stuff so they can do stupid things in userspace,
> like make the assumption that if it gets reported that the CPU is running
> at N MHz, then that means to delay M us, they need Z instructions in a
> loop.
>
> We've also had people want the cache information in userspace, so that
> they can use that to make a decision on whether function X would be
> faster than Y, rather than measuring each implementation and basing it
> off measurement - we've shown in the past that the cache information
> doesn't let you make that kind of decision, because the result is
> affected not only by the cache but many other parameters as well (such
> as the implementation of the CPU itself.)
>
> I've been dead against exporting cache information from the kernel into
> userspace: it's not something that userspace should ever concern itself
> with, and it's not something that userspace should ever use to make
> decisions about what code should be run.
>
> So, "people want to know this stuff" is a poor reason.  A good reason is
> "If I have access to X, then it allows me to do Y, and this is the right
> way to allow me to do Y".  So far, I haven't seen any evidence that the
> export of cache information gives the right solution to any userspace
> problem.  Hence, my position is still the same as above, and this
> information should *never* be exported to userspace.

I agree using it for functional purposes in this way is stupid. It is
more for informational purposes than functional reasons. The use case
I hear is server OEMs want to run some tool(s) to dump out system
information for support requests. You can argue all day long that
there are other ways to do something, but they already have the
infrastructure in place on x86. For example, they may want to know if
the user changed the CPU or DIMMs. Frequency and cache sizes may be
part of the SKU. One way or another, this information is going to get
to userspace. The real question is should the kernel provide a
standard cross-arch interface to various fields or just pass this
information thru to userspace via DMI tables, /proc/device-tree, ACPI,
etc. I'd rather see this presented in a standard way so userspace does
not have to change depending on whether the data comes from DT, DMI,
ACPI or somewhere else.

Rob
