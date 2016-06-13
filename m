From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 13 Jun 2016 15:00:11 +0800
Subject: [RFC PATCH 1/4] STM Ftrace: Adding generic buffer interface driver
In-Reply-To: <87k2hzvpxe.fsf@ashishki-desk.ger.corp.intel.com>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
 <1464779939-24986-2-git-send-email-zhang.chunyan@linaro.org>
 <87fuspqosa.fsf@ashishki-desk.ger.corp.intel.com>
 <CAG2=9p9iOoWooUg_zkMVY4i70rUQOv4ZSDsjngAfLAweV+b=Qg@mail.gmail.com>
 <87k2hzvpxe.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CAG2=9p_OdOsmHbOgCFEguMJy42WZ9Uxzw4n6hKiC9D1S6HXLZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2016 at 8:13 PM, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>
>> On Tue, Jun 7, 2016 at 6:25 PM, Alexander Shishkin
>> <alexander.shishkin@linux.intel.com> wrote:
>>> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>>>
>>>> This patch adds a driver that models itself as an stm_source and
>>>> who's sole purpose is to export an interface to the rest of the
>>>> kernel.  Once the stm and stm_source have been linked via sysfs,
>>>> everything that is passed to the interface will endup in the STM
>>>> trace engine.
>>>
>>> STM core already provides this exact interface to the rest of the
>>
>> Can you point out 'this exact interface' to me?
>
> Well, you're saying that this stm_source exports an interface to send
> data to STM for the rest of the kernel. Whereas, stm_source already is
> that interface.

Ok, got it now.  I'll revise this change log in the next version.

>
>>>> +config STM_FTRACE
>>>> +     tristate "Redirect/copy the output from kernel Ftrace to STM engine"
>>>> +     help
>>>> +       This option can be used to redirect or copy the output from kernel Ftrace
>>>> +       to STM engine. Enabling this option will introduce a slight timing effect.
>>>
>>> This creates an impression that STM_FTRACE will somehow make events
>>> bypass the normal ftrace ring buffer.
>>
>> Ok, this name can be adjusted, do you have a better one for me :)
>
> What I mean is: from the description it sounds like there is an option
> to bypass ftrace ring buffer, but I don't think that's the case at the
> moment. I'm also not sure if it's practical at all to do.
>
>>>> +/**
>>>> + * stm_ftrace_write() - write data to STM via 'stm_ftrace' source
>>>> + * @buf:     buffer containing the data packet
>>>> + * @len:     length of the data packet
>>>> + * @chan:    offset above the start channel number allocated to 'stm_ftrace'
>>>> + */
>>>> +void notrace stm_ftrace_write(const char *buf, unsigned int len,
>>>> +                           unsigned int chan)
>>>> +{
>>>> +     stm_source_write(&stm_ftrace_data, chan, buf, len);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(stm_ftrace_write);
>>>
>>> An extra wrapper around stm_source_write().
>>
>> Yes, I think it's not good to expose the stm_source to ftrace_stm_func().
>
> I understand, but wrapping it into an intermediary function doesn't
> really solve it either.
>
>>> So basically when ftrace is compiled in, it will pull in stm core
>>> through this.
>>
>> Sorry I cannot get you here.  Could you please explain you concern further?
>
> Well, if you plug the stm_source driver into the ftrace core (via a
> wrapper or directly), you will end up with a link dependency. In other
> words, stm_source and by association stm_core will have to be statically
> linked.
>
> Look at the way stm_console is done, for example: it registers with both
> stm_source class and the console layer dynamically, so that it can be
> dynamically loaded/unloaded.

Yes, I just looked at stm_console implementation, it is an good
example. I may finally got your point.
Declaring stm_ftrace as a struct, then Ftrace only needs an instance
of stm_ftrace from its own side.  That way, ftrace subsystem and
stm_ftrace are more independent of each other, and stm_ftrace can be
dynamically loaded/unloaded like you suggested.

I will revise this patchset.

Thanks for your comments,
Chunyan

>
> Regards,
> --
> Alex
