From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 30 Jan 2014 15:27:16 -0800
Subject: [PATCH v3 0/2] Qualcomm Universal Peripheral (QUP) I2C controller
In-Reply-To: <1391095811.3275.17.camel@iivanov-dev>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1390983246.28998.24.camel@iivanov-dev.int.mm-sol.com>
 <CAJAp7Oj_D1QvG9nBWTVrW1QVEpqi2cTTc9c6Um25DDzidCjW1w@mail.gmail.com>
 <1391095811.3275.17.camel@iivanov-dev>
Message-ID: <CAJAp7OgEttDsM=FH2n3yvVwQ8X1__F3jLF=snF6Kr7EiE5w9oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 7:30 AM, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
>
> Hi Bjorn,
>
> On Wed, 2014-01-29 at 08:32 -0800, Bjorn Andersson wrote:
>> On Wed, Jan 29, 2014 at 12:14 AM, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
>> >
>> > Hi Bjorn,
>> >
>> > On Fri, 2014-01-17 at 15:03 -0800, Bjorn Andersson wrote:
>> >> Continuing on Ivans i2c-qup series.
>> >>
>> >
>> > Do you plan to send v4 of this driver? I would like to address
>> > the remaining errors and suggestions and send a new version.
>> >
>> Hi Ivan,
>>
>> Yes I'm planning to send out a new revision of the patch set.
>>
>> I've incorporated fixes from the review comments here and my colleague
>> concluded through some testing that block read did not work, so we've
>> fixed that as well.
>
> Busted. I have not test it.

No worries, I'm glad you did the major cleanup from codeaurora!

>
>>
>> What have been holding me from submitting a new patchset is the 3
>> functions that does polling of state and status updates;
>> * qup_i2c_poll_state() reads the state register up to 1000 times,
>> hoping we reach the expected state, will delay 100uS and then continue
>> with 1000 more retries.
>>   According to the data sheet a state transition is supposed to take
>> up to 2 bus cycles. Only time I can see that this would take longer
>> time are all error states, but the data sheet is not very clear
>> regarding this.
>>
>> * qup_i2c_wait_idle() reads the status register up to 1000 times,
>> hoping the fifo gets drained and the bus go idle, if that fails it
>> sleeps for the time we expect it to take to drain a full fifo and then
>> loops another 1000 times. This waits for the fifo to have drained and
>> the bus to go idle. On a read we get to this state if we issue the
>> write and then hit the error state, so we would reset the entire
>> block. On write we will only wait for the buffer not to be full before
>> returning.
>>
>> * qup_i2c_wait_clock_ready() waits up to 300 bus-clocks for the i2c
>> bus to go idle or forced low, I don't know why it retries 300 times.
>> This is called at the end of a write, possibly to wait for the fifo to
>> drain.
>>
>>
>> All three loops are in line with how it's been in codeaurora since the
>> beginning of time, but I at least need to figure out some good names
>> for those "magic numbers".
>
>
> Sure. I have keep them this way, just because I don't have information
> for internal trickery of the block.

I'll continue to talk to the Qualcomm guys to see if we can figure out
anything regarding the expected timings of those operations and I'll
send out a new version when we have something saner.

Regards,
Bjorn
