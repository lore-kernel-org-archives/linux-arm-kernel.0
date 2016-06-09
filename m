From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 09 Jun 2016 11:54:59 +0300
Subject: [RFC PATCH 2/4] trace: Introduce an output interface from ftrace
 to STM
In-Reply-To: <CAG2=9p8uiYjrev90f2sEKTAC-+sm2373D9nKp9kBYNuoFYOJCQ@mail.gmail.com>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
 <1464779939-24986-3-git-send-email-zhang.chunyan@linaro.org>
 <87inxlqpqe.fsf@ashishki-desk.ger.corp.intel.com>
 <CAG2=9p8uiYjrev90f2sEKTAC-+sm2373D9nKp9kBYNuoFYOJCQ@mail.gmail.com>
Message-ID: <87h9d2vj18.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> On Tue, Jun 7, 2016 at 6:04 PM, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>>
>>> This patch is introducing a new function to print Ftrace messages
>>> to STM buffer when the traces happen.  In order to reduce the
>>> effect on timing overhead as much as possible, only the current
>>> function and its parent ip address will be recorded into STM in
>>> this patch.  This idea was first introduced by Philippe Langlais
>>> at ST-Microelectronics a long time ago[1].
>>
>> So why is this useful? The value of trace points is in their payload.
>
> Sorry, didn't get you, what did you mean by "The value of trace points" here?

I suggest that you read about ftrace usage and in particular the types
of records that end up in its ring buffer.

>
>>
>>> +#define STM_FTRACE_CHAN 0
>>
>> This is why we have the stm master/channel allocation policy, which
>> should already assign a channel to your stm_source device when it is
>> linked to an stm device.
>
> If I understand correctly, STM core can assign many channels for one
> stm_source, the number we want to be allocated is specified by
> 'stm_source_data.nr_chans', for this patchset it's 1 for the time
> being, STM_FTRACE_CHAN is the index in the range of channels allocated
> to this stm_source by STM core.

Yes, I misread the code, apologies.

>> Also, why is this a separate compilation unit from the stm_ftrace.o?
>
> My idea was stm_ftrace.c is part of STM driver, this patch is a
> process of traces from Ftrace subsystem.  These two parts are small so
> far, since this serial only added function trace exporting to STM, but
> I want to add more functionalities to export more kinds of traces
> which Ftrace subsystem supports to STM in the feature, my thought is
> dividing into two parts like this serial did is convenient to add
> other feature to each part.

Leaving aside the question of different ftrace functionalities for a
moment, what is the benefit of splitting stm_ftrace like this? The only
purpose of stm_ftrace is to take data from ftrace and send it down to an
stm device, using necessary intefaces on both ends and performing
additional framing if required.

If would make sense if the ftrace part gets a notion of "output" or
"sink" interface, which stm_ftrace can declare itself to be an
implementation of.

Regards,
--
Alex
