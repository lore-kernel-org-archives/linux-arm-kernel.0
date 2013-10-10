From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 10 Oct 2013 14:14:41 -0700
Subject: [PATCH v7 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <CAAVeFuLvHdUuDurqA_=tvxJonNP+RekotM_MuysQrJD0PUgcSQ@mail.gmail.com>
 (Alexandre Courbot's message of "Thu, 10 Oct 2013 13:58:24 -0700")
References: <1380904635-18113-1-git-send-email-acourbot@nvidia.com>
 <1380904635-18113-2-git-send-email-acourbot@nvidia.com>
 <CAOesGMj74Pui1V5O7zxEipM5Hg6nboVTUCFuMY0c0aUh=wuu3Q@mail.gmail.com>
 <CAAVeFuLvHdUuDurqA_=tvxJonNP+RekotM_MuysQrJD0PUgcSQ@mail.gmail.com>
Message-ID: <87y560q14u.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Courbot <gnurou@gmail.com> writes:

> On Wed, Oct 9, 2013 at 4:47 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Fri, Oct 4, 2013 at 9:37 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:

[...]

>>> +static inline void register_trusted_foundations(
>>> +                                  struct trusted_foundations_platform_data *pd)
>>> +{
>>> +       /* If we try to register TF, this means the system needs it to continue.
>>> +        * Its absence if thus a fatal error. */
>>> +       panic("No support for Trusted Foundations, stopping...\n");
>>> +}
>>> +
>>> +static inline void of_register_trusted_foundations(void)
>>> +{
>>> +       /* If we find the target should enable TF but does not support it,
>>> +        * fail as the system won't be able to do much anyway */
>>> +       if (of_find_compatible_node(NULL, NULL, "tl,trusted-foundations"))
>>> +               register_trusted_foundations(NULL);
>>> +}
>>> +#endif /* CONFIG_TRUSTED_FOUNDATIONS */
>>
>> The latter function can just be shortcut unto a local panic too.
>>
>> But do we really need to panic here? It's a PITA to debug since it'll
>> be a very early panic. I'd rather have the system log errors in dmesg
>> but continue booting with one cpu.
>
> Actually the first version of this series continued on one CPU if TF
> support was missing (as secondary CPUs would simply fail to boot), but
> IIRC Stephen advocated for the current behavior (panic) instead. I
> agree such an early panic is hard to debug, especially considering
> that most devices using TF (Tegra retail devices) do not even feature
> a serial port.
>
> On the other hand, if we continue booting in these conditions the
> system freezes as soon as cpuidle kicks in, so we won't be going very
> far anyway. However the console is up when it happens.

cpu_idle_poll_ctrl(true) should solve that problem.

Kevin

> Maybe if there is a way to disable the kernel features TF is supposed
> to manage (SMP & cpuidle at the moment) when registration fails, the
> system could continue more gracefully (even if on one leg) and warn
> the user about this condition. Stephen, can I have your thoughts on
> this?
