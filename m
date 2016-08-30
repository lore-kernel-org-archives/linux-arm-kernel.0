From: mmarek@suse.com (Michal Marek)
Date: Tue, 30 Aug 2016 13:53:47 +0200
Subject: [PATCH] arm64: Set UTS_MACHINE in the Makefile
In-Reply-To: <20160830112036.GB24906@arm.com>
References: <1472545895-7237-1-git-send-email-mmarek@suse.com>
 <20160830095322.GA24906@arm.com>
 <435a26f2-29ce-f40c-4749-6d8d6d81ac67@suse.com>
 <20160830112036.GB24906@arm.com>
Message-ID: <a2518725-e0ed-06de-ee1b-bcc70c455263@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-30 13:20, Will Deacon wrote:
> On Tue, Aug 30, 2016 at 12:50:41PM +0200, Michal Marek wrote:
>> On 2016-08-30 11:53, Will Deacon wrote:
>>> On Tue, Aug 30, 2016 at 10:31:35AM +0200, Michal Marek wrote:
>>>> The make rpm target depends on proper UTS_MACHINE definition.  Also, use
>>>> the variable in arch/arm64/kernel/setup.c, so that it's not accidentally
>>>> removed in the future.
>>>>
>>>> Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
>>>> Signed-off-by: Michal Marek <mmarek@suse.com>
>>>> ---
>>>
>>> What exactly do you mean by "proper", here? Is it just the endianness
>>> suffix that you need?
>>
>> The default for UTS_MACHINE is the kbuild arch name, which would be arm64.
> 
> Ok, but why doesn't that work for rpm?

It does not work for rpm, because the arch/* subdirectory names are
unknown to userspace. rpmbuild --target ... expects the uname -m string
of the target architecture. What other architectures do is that they
change the UTS_MACHINE definition if it differs from the kbuild
architecture name (e.g. x86, power, s390).


> Did you see the other part of my reply?

Oops, I haven't.

On 2016-08-30 11:53, Will Deacon wrote:
> I think we're be better off changing scripts/package/Makefile to map
> UTS_MACHINE into whatever rpm requires, just like scripts/package/builddeb
> already does this for .deb (which I think ends up broken with your patch
> applied).

As explained above, rpm requires the UTS_MACHINE definition that other
architectures set in their Makefiles. Debian architectures use a
slightly different naming than the uname -m string, so a mapping is
needed. You are right about the breakage, I will send a v2.

Michal
