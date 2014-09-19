From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 19 Sep 2014 14:40:41 +0200
Subject: [PATCH] ARM: zImage: add support for ARMv7-M
In-Reply-To: <20140919103334.GB2295@e104818-lin.cambridge.arm.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <201409181938.46996.arnd@arndb.de>
 <CAGhQ9VxMKD-DcFhobUky3FnKjerTiv66w4PSCPfi+=bo_zWgUg@mail.gmail.com>
 <20140919103334.GB2295@e104818-lin.cambridge.arm.com>
Message-ID: <CAGhQ9Vzm+Tx00-kjX2SODiy9SbUvH+B6oiHcUHM_BqQAX4u9cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2014 12:33, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Sep 18, 2014 at 07:34:47PM +0100, Joachim Eastwood wrote:
>> On 18 September 2014 19:38, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 18 September 2014, Joachim Eastwood wrote:
>> >>   ARM(          mov     pc, r4  )               @ call kernel
>> >> - THUMB(                bx      r4      )               @ entry point is always ARM
>> >> +#ifdef CONFIG_CPU_V7M
>> >> +               add     r4, r4, #1              @ enter in Thumb mode for ARMv7M
>> >> +#endif
>> >> + THUMB(                bx      r4      )               @ entry point is always ARM for non ARMv7M CPUs
>> >>
>> >
>> > I think it would be much nicer to avoid sprinkling #ifdefs here. We already
>> > have the ARM() and THUMB() macros to deal with the two cases we support, which
>> > are booting in ARM mode vs ARMv7-A with THUMB2 mode. We can probably add
>> > another macro like this to deal with the ARMv7-M case that does not have
>> > ARM mode.
>>
>> Well, I guess I could make a THUMBONLY macro or something like that.
>> But I think that the macro would only be useful in the case you quoted
>> above. The other ifdefs in the patch are either for large blocks or
>> removing code. So I don't think it would improve the patch a great
>> deal.
>>
>> btw, do you have better name suggestion than THUMBONLY?
>
> It looks like you would need the reverse as well, !THUMBONLY. What about
> M_CLASS and A_CLASS (with or without underscore and maybe AR_CLASS if we
> ever need to differentiate between A and R)?

Yes, that would remove more of the ifdefs.
With M_CLASS/A_CLASS macros I could also wrap ".arch armv7-m" and
".arm" directives. But A_CLASS might look a bit strange when used for
ARM CPUs that are not called Cortex.

I'll cook up a new patch and see how it turns out.

regards,
Joachim Eastwood
