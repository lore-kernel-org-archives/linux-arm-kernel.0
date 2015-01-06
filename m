From: jcm@redhat.com (Jon Masters)
Date: Tue, 06 Jan 2015 17:06:15 -0500
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <1596791.jNp4rCPpnN@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
 <54AC0C4B.1000907@redhat.com> <1596791.jNp4rCPpnN@wuerfel>
Message-ID: <54AC5C57.7050504@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Happy New Year!

On 01/06/2015 02:21 PM, Arnd Bergmann wrote:
> On Tuesday 06 January 2015 11:24:43 Jon Masters wrote:
>> On 01/06/2015 06:20 AM, Catalin Marinas wrote:
>>
>>> Now, what's preventing a vendor firmware from providing only ACPI
>>> tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
>>> that both DT and ACPI are supported, or at least that dts files are
>>> merged in the kernel first?
>>
>> I know of some (server) firmware that will only provide ACPI in the
>> medium term, so this is coming.
> 
> Medium term is fine, as long as they are not expecting their hardware
> to be supported by Linux before ACPI support is stable enough for
> general consumption.

To be clear, I think that's reasonable for upstream. I may love ACPI,
but vendors can always ship kernels with a config supporting ACPI only
platforms in the interim period if they have a commercial justification
and that doesn't have to be supported in terms of the upstream default.

But, perhaps there's a way to have it both ways, you could consider also
a CONFIG_EXPERT option that would allow you to build a kernel with ACPI
only support in the medium term. That way, if someone is running a
vendor kernel, but wants to track upstream development more closely,
they can do so on such hardware by enabling the expert config bit.

> I have no idea how long that will take, but my
> guess is that we shouldn't plan on supporting ACPI-only platforms in
> Linux for the next couple of years and just demand that all drivers
> have DT support to let users add a valid DTB that can describe the
> hardware.

I'm not opposed. It was particularly useful in the early days of ACPI to
be able to boot our internal systems (which now all default to ACPI on
by default) with acpi=off when there were glitches that needed to be
isolated to whether they were ACPI related. One reason I was very keen
for a DT UUID in UEFI early on was so that there was a clean way to
specify both sets of tables on a UEFI platform. Keeping them in sync is
not something we can rely on in the longer term, but during bringup
timeframe I suspect you'll continue to see many platforms with both sets
of tables. This is especially true for early silicon that might be
supporting both embedded and server environments - hence a platform that
appears to be a server might have a DT posted upstream anyway if such a
platform is also being used for unrelated embedded work.

> That should always be possible using something like grub2 as an
> intermediate that boots using the UEFI interfaces and loads the
> kernel and DT from disk.

This is another reason (but it's up to you, I understand your position)
why it may not be a huge problem if there are ACPI only systems, since
the "devicetree" directive in GRUB2 configs is always possible.

Jon.
