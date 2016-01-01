From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 Jan 2016 21:23:48 +0100
Subject: [PATCH v2 RESEND 1/3] clocksource/vt8500: Use MIN_OSCR_DELTA from
 PXA
In-Reply-To: <20160101023208.7721e085@v1ron-s7> (Roman Volkov's message of
 "Fri, 1 Jan 2016 02:32:08 +0300")
References: <1451584927-4051-1-git-send-email-v1ron@mail.ru>
 <1451584927-4051-2-git-send-email-v1ron@mail.ru>
 <alpine.DEB.2.11.1512312331580.28591@nanos>
 <20160101023208.7721e085@v1ron-s7>
Message-ID: <871ta1f3qj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roman Volkov <v1ron@mail.ru> writes:

> ? Thu, 31 Dec 2015 23:33:45 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> ?????:
>
>> Roman,
>> 
>> On Thu, 31 Dec 2015, Roman Volkov wrote:
>> > Since vt8500 and PXA timers are identical, use MIN_OSCR_DELTA from
>> > PXA, which is bigger than existing value. It is required to
>> > determine the minimum delay which hardware can generate.  
>> 
>> Now that brings up the obvious question:
>> 
>> If the vt8500 and PXA timers are identical why has vt8500 it's own
>> slightly different implementation and does not use the PXA timer?
>
> Thomas,
>
> I occasionally noticed that the PXA can be reused, when working on the
> bugfix for vt8500. Another good question would be how exactly this code
> can be reused. We may rework PXA driver to make it working under
> vt8500, or include the C code from the vt8500 and get two slightly
> different modules. You may look at our previous discussion with Alexey:
>
> https://lkml.org/lkml/2015/12/21/437
>
> Adding Robert and Bill to get more opinions. At this step, fixing the
> vt8500 nanosleep bug is a priority.

Personnaly I'm not very thrilled by combining pxa and vt8500 drivers into one.

The rationale I have behind is that :
 - the new driver will have new ifs to switch form vt8500 to pxa
   For example, suspend/resume functions will be different.
   Moreover in order to not impact the pxa runtime some ifs will be necessary
   (will that be if (IS_ENABLED(CONFIG_ARCH_PXA) && ...)
 - the IPs do not look that similar to me
   They seems inter-operable, but that seems to me to be just because of the 3
   common register placement : register at match (@0x00), counter (@0x10) and
   interrupt enabled (@0x1c).
   The register acces semantics are different (vt8500 needs a bit to access),
   the input clock seems different.

For ~140 lines of code, I prefer the simplicity brought by drivers
separation. The diffstat should be pretty equivalent between 2 drivers and 1
combined driver with many ifs.

Cheers.

-- 
Robert
