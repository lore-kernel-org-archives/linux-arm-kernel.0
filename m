From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 May 2016 10:13:05 +0200
Subject: [RFC PATCH 0/7] AC97 device/driver model revamp
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <s5hlh3j8uwg.wl-tiwai@suse.de>
Message-ID: <87y47dhxbi.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> On Sat, 30 Apr 2016 23:15:32 +0200,
> Robert Jarzmik wrote:
>> 
>> Well, this is a long term effort, which might need a complete rewrite according
>> to the comments it'll get. Let's expose it for comments and see how I can
>> progress with it.
>
> I think it's good in general.  The implementation looks fairly simple
> and thin enough.
Thanks.

> An open question is whether migrating the former AC97 layer into the
> new bus.  I'm not sure about this.  Transition to a new layer always
> brings subtle bugs, especially when the target devices are in wide
> range of legacy ones...   If any, we should start just wrapping via
> the new bus ops.
I agree, the migration to the new layer will bring bugs. And the test might be
impossible to carry out by lack of testers.

The wrapping of bus operations is the goal of sound/ac97/snd_ac97_compat.c.

> Some other nitpicks:
> - We usually use snd_ prefix for sound stuff.  Better to keep this for
>   exported symbols at least.
Of course, for RFC v2.

> - I don't see much value in the usefulness of compat_* stuff.
That's mainly the bus operation wrapping and backward compatibility. The idea is
to be able to convert only the probing/removal/suspend/resume of an ac97 codec
or controller without changing its main code in a first patch, and then consider
surgery (if applicable) to convert it wholly.

>   For example, it doesn't cover the actual reset procedure or such
>   done as in the old ac97 code.
Ah then my code is incomplete and I must work on it.

For the reset procedure I have ported snd_ac97_reset(), as well as the
snd_ac97_us_ops operation wrappers. Would you give me an example of the reset
I'm missing (a file and a function) ?

> So it won't work compatibly.  If it's a few lines of changes, the direct call
> would be likely simpler in the end.

>
> - The order of patches needs reconsideration.  The current patchset
>   will break the build, as the hook to sound/ac97/* is done in the
>   last patch, while you're already building against to the new stuff
>   beforehand.
Very true. kbuild robot objected as well :) For RFC v2.

Cheers.

-- 
Robert
