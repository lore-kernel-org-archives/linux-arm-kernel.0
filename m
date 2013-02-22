From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Feb 2013 11:11:15 -0700
Subject: [PATCH] kbuild: create an "include chroot" for DT bindings
In-Reply-To: <20130222023526.GA27371@S2101-09.ap.freescale.net>
References: <1361394356-19385-1-git-send-email-swarren@wwwdotorg.org>
 <20130221043751.GB17738@S2101-09.ap.freescale.net>
 <51266AC1.8040507@wwwdotorg.org>
 <20130222023526.GA27371@S2101-09.ap.freescale.net>
Message-ID: <5127B4C3.8070001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2013 07:35 PM, Shawn Guo wrote:
> On Thu, Feb 21, 2013 at 11:43:13AM -0700, Stephen Warren wrote:
>> There are two things that include DT-related headers:
>>
>> a) Device trees (*.dts, *.dtsi)
>> b) The kernel
>>
>> All the headers relevant here fall into category (a) by definition. I'd
>> actually expect most to also fall into category (b), although I can see
>> that category (b) might be a strict subset of category (a).
>>
>> I believe you're proposing only storing category (b) headers in
>> include/dt-bindings/, and storing any others I suppose in arch/*/boot/dts/.
>>
>> But, my thoughts are that /all/ these headers (both categories) should
>> be stored in one place for consistency.
>>
>> That way, if/when the DT binding docs, these headers, and the DT files
>> themselves move out of the kernel, we'll end up with some other
>> repository/repositories that might have the following top-level
>> directories (or at least these sets of logical data):
>>
>> 1) DT binding documents
>> 2) Headers that define constants for (1)
>> 3) DT files (*.dts/*.dtsi)
>>
>> We need at least some of (2) in the kernel for drivers to share the
>> constant definitions, so my proposal is to simply copy /all/ the headers
>> from (2) into the kernel's include/dt-bindings/. That keeps things
>> simple; simply copy everything and maintain the same hierarchy under
>> that "root" directory. Otherwise, we'll be constantly wondering which
>> headers to copy, perhaps moving things back/forth as people realize that
>> the kernel needs them, etc.
> 
> You need to anyway identify the headers needed by a) but not b) and
> remove them from linux/include/dt-bindings/, when all DTS gets moved
> out of kernel tree.  Otherwise, you end up leaving those headers only
> needed by DTS in the kernel tree.

Well that's really my point - do you actually /need/ to do that?

What headers would be in (b) but not (a)? We'd typically be defining
headers for the purpose of defining constants that are part of the
binding definitions. To keep the kernel and binding documents in sync,
the kernel should have access to any such header. Hence, I think the set
of headers only in (a) would be non-existent. Even if there are some,
presumably there would be so few it wouldn't actually matter if we
weeded them out.

The only exception I can think of right now is the header for the i.MX
pinctrl bindings, since that's expanding the names into a set of values
the kernel will use directly rather than as needing to use as table
indices. I'm not sure if that's the right way to go on the bindings; I
see you're getting some pushback. But, I guess "pinctrl-simple" would
end up in the same boat, so perhaps there's some argument for not
removing boot/dts/ itself from the include path.
