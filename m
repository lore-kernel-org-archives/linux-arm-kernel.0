From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 1 Apr 2015 08:28:00 -0600
Subject: [PATCH 4/5] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <CANLsYkz5Ar9aY6_4foWBcj2AXr2ttOJEPS_rC9Z2t1L-ht-Pvg@mail.gmail.com>
References: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
 <1425078294-13059-5-git-send-email-mathieu.poirier@linaro.org>
 <87bnjad1jb.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkzK_LX4OQJOUtcr0EksRUKPueNOXrw2C+qTJWov0sQPFA@mail.gmail.com>
 <87384lcio3.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkz5Ar9aY6_4foWBcj2AXr2ttOJEPS_rC9Z2t1L-ht-Pvg@mail.gmail.com>
Message-ID: <CANLsYkxQka3B1iw6+seJdaR55ROvBXbZqnYA9WkSneD1H19Z4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Al Grant

On 1 April 2015 at 08:27, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> Adding Al Grant to the conversation - his knowledge on HW tracing for
> the ARM architecture is definitely an asset for this kind of planning.
> Please add him to future patchset as well.
>
> On 31 March 2015 at 09:04, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>>
>>> On 30 March 2015 at 08:04, Alexander Shishkin
>>> <alexander.shishkin@linux.intel.com> wrote:
>>>> As it looks from the above snippet, you're using a stream of DATA
>>>> packets for user's payload. I also noticed that you use an ioctl to
>>>> trigger timestamps.
>>>
>>> Right, the ioctl() conveys user space intentions on that channel.
>>> Options are kept and applied on every packet for as long as the
>>> channel is open.
>>
>> So this means that, for example, if you enable timestamps on a channel,
>> then every single data packet on that channel will be timestamped, which
>> is a lot of timestamps.
>
> That is how the original coresight-stm driver was implemented.  My
> initial goal was to upstream something that could be used as a
> conversation starter or a foundation to start building on.  I had
> planned to look into the protocol specification itself in later steps.
> But addressing the issue now is just as worthy.
>
>>Normally, you would only be interested in the
>> timestamp on the first data packet in the message (or frame or however
>> we decide to call it). This is one of the reasons why I'm suggesting a
>> common framing scheme or a "protocol".
>>
>>>> Now, in the STP protocol there are, for example, marked data packets
>>>> that can be used to mark beginning of a higher-level message,
>>>> timestamped data packets that can be used to mean the same thing and
>>>> FLAG packets to mark message boundaries.
>>>
>>> Same on my side, I simply haven't included them yet.  I'll do so in my
>>> next iteration.
>>>
>>>>
>>>> In my Intel TH code, I'm using D*TS packet for the beginning of a
>>>> message (or "frame") and FLAG packet for the the end of a message.
>
> By the way, are you following the OST specification of this is a
> scheme you came up with?
>
>>>>
>>>> So my question is, is there any specific STP framing pattern that you
>>>> use with Coresight STM or should we perhaps figure out a generic framing
>>>> pattern and make it part of the stm class as well?
>>>
>>> Now specific pattern... Sending a packet consists of MARK, DATA, FLAG.
>>
>> Is this pattern mandated by a decoder that you use or is there any other
>> reason why it's exactly that?
>
> The driver was following the OST specification, or something close to
> that.  I don't have access to the standard itself and as such not in a
> position to assert how accurate the implementation.  That is one of
> the reason I left it out of my patchset.
>
>>
>>>>
>>>> For example, we can replace stm's .write callback with something like
>>>>
>>>>     int (*packet)(struct stm_data *data,
>>>>                   unsigned int type,    /* data, flag, trig etc */
>>>>                   unsigned int options, /* timestamped, marked */
>>>>                   u64 payload);
>>>>
>>>> and let the stm core do the "framing", which, then, will be common and
>>>> consistent across different architectures/stm implementations.
>>>
>>> I think the framing should be left to individual drivers.  It's only a
>>> matter of time before we get a weird device that doesn't play well
>>> with others, forcing to carry the ugliness in the STM core rather than
>>> the driver.
>>
>> Not necessarily. If a device doesn't support one type of packet or the
>> other, it will be up to them to work around that in the above .packet
>> callback.
>>
>> As for the devices that don't play well, there's a question of how much
>> one can violate the spec and still call oneself compliant.
>
> I understand your point of view.  On my side I'm trying to avoid
> painting ourselves in the corner.
>
>>
>>> And isn't carrying "options" redundant?  Using "container_of" on the
>>> "data" field one can get back to the driver specific structure, which
>>> is definitely a better place to keep that information.  I think the
>>> general structure looks good right now, we simply need to find a way
>>> to get rid of the ioctls.
>>
>> No, what I mean by options here is a property of each individual packet,
>> not the whole channel. For example, if I want the underlying driver to
>> send a marked data packet, I do
>>
>>      stm_data->packet(stm_data, STP_PACKET_D8, STP_OPTION_MARKED, payload);
>>
>> or if I want to send a timestamped flag, I do
>>
>>      stm_data->packet(stm_data, STP_PACKET_FLAG, STP_OPTION_TS, 0);
>
> Ah!  It's getting clearer now.
>
>>
>> Like I said above, there seems little to be gained from enabling
>> timestamps for all packets in one channel.
>>
>>> Regarding the same "options", how did you plan on getting those from user space?
>>
>> Ideally, if we have a framing convension, we don't need to get it from
>> userspace at all, all userspace should care about is writing data to the
>> character device and we wrap it up and feed it to the underlying driver.
>
> What do you have in mind for "framing convention"?  As mentioned above
> codeAurora was using the OST specification but Al Grant tell me it
> isn't supported anymore.
>
> Thanks for the open dialogue,
> Mathieu
>
>>
>> Regards,
>> --
>> Alex
