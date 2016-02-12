From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 12 Feb 2016 18:27:32 +0200
Subject: [PATCH V2 3/6] stm class: provision for statically assigned
 masterIDs
In-Reply-To: <CANLsYkw=mG+ch8QzxmbwWs9o+mndVNo1MuqXcrPrNJYj_SQcHQ@mail.gmail.com>
References: <1454487337-30184-1-git-send-email-zhang.chunyan@linaro.org>
 <1454487337-30184-4-git-send-email-zhang.chunyan@linaro.org>
 <87mvrf5ngl.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYky2twQ98u241YyHD=atYRp1N56YVHUQNY2E2Ljsq0cseA@mail.gmail.com>
 <87twlj49k7.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkw=mG+ch8QzxmbwWs9o+mndVNo1MuqXcrPrNJYj_SQcHQ@mail.gmail.com>
Message-ID: <87r3gh3nd7.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 8 February 2016 at 06:26, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> This $end==$start situation itself may be ambiguous and can be
>> interpreted either as having just one *static* master ID fixed for all
>> SW writers (what I assumed from your commit message) or as having a
>> floating master ID, which changes of its own accord and is not
>> controllable by software.
>
> Some clarification here.
>
> On ARM from a SW point of view $end == $start and that doesn't change
> (with regards to masterIDs) .  The ambiguity comes from the fact that
> on other platforms where masterID configuration does change and is
> important, the condition $end == $start could also be valid.

Yes, that's what I was saying. The thing is, on the system-under-tracing
side these two situations are not very different from one
another. Master IDs are really just numbers without any semantics
attached to them in the sense that they are not covered by the mipi spec
or any other standard (to my knowledge).

The difference is in the way we map channels to masters. One way is to
allocate a distinct set of channels for each master (the way Intel Trace
Hub does it); another way is to share the same set of channels between
multiple masters. So we can describe this as "hardware implements the
same set of channels across multiple masters" or something along those
lines.

Actually, in the latter scheme of things you can also have multiple
masters, at least theoretically. Say, you have masters [0..15], each
with distinct set of channels, but depending on hardware state these
masters actually end up as $state*16+$masterID in the STP stream.

So we might also think about differentiating between the hardware
masters (0 though 15 in the above example) and STP masters.

Regards,
--
Alex
