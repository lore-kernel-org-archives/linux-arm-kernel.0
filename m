From: konkers@google.com (Erik Gilling)
Date: Fri, 30 Mar 2012 10:29:27 -0700
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <20120330100742.GB21950@opensource.wolfsonmicro.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
 <20120309124119.GV3273@opensource.wolfsonmicro.com>
 <CACSP8ShU5tu=9N53PtYMLyFVFMS9whNRhMvu7nu8rBoPuVCy+Q@mail.gmail.com>
 <20120330100742.GB21950@opensource.wolfsonmicro.com>
Message-ID: <CACSP8SjhOZcXZa2hCNsH8zS+hm8X-i9uNm50UH=_VwOV=BJGmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 3:07 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Mar 29, 2012 at 03:27:01PM -0700, Erik Gilling wrote:
>> On Fri, Mar 9, 2012 at 4:41 AM, Mark Brown
>
>> > This seems somewhat sad - if ANDROID is turned on the standard ABI
>> > vanishes. ?It'd be much nicer to do this with a symlink (or with
>> > symlinks within the android directory if the driver core doesn't support
>> > that). ?That way userspace code can be written to the new ABI and will
>> > work on Android systems without ifdefery.
>
>> This won't work if userspace code is receiving uevents through netlink
>> and comparing based on the device name which it does in android. ?Why
>
> That's not really the point here - the point is that the new ABI
> vanishes as soon as you turn on the legacy Android ABI. ?You're right
> that the particular fix I suggested has issues but the overall problem
> exists and should be dealt with more sensibly.

I'm also not in favor of having functionality conditionally compiled
based on CONFIG_ANDROID.  If fact, going through the patch stack
there's much more that changes the ABI from the switch driver than
just the name.  Android asumes that there is a single "switch" for
each logical entity (called cable types in extcon) each with a binary
state (0,1).  Here things have changed to have a single extcon
instance that can have a bitmask of states which are sent as strings
in the uevent.

As it stands, this patch does not solve the cases where we use switch
today and we'll probably continue to carry the switch driver in the
common android tree.  If, instead, we got rid of the idea of multiple
states and mutual exclusivity and relied on the driver that uses
extcon to have multiple instances for each logical entity and deal
with mutual exclusion itself, we'd have a driver that would be pretty
easy to support in android.

-Erik
