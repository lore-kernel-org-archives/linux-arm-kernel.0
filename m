From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Mon, 16 Oct 2017 11:25:18 +0530
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
In-Reply-To: <20171013184646.cy5gmpwrxbacje3m@ninjato>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
Message-ID: <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sat, Oct 14, 2017 at 12:16 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Sat, Oct 07, 2017 at 04:32:29PM +1100, Andrew Worsley wrote:
>> > Thank you for the bug report. I don't know the hardware in detail, but I
>> > am a bit confused...
>> >
>> >> ---
>> >>   This bug reliably caused a stack corruption when the hardware provided more data than
>> >> asked for in the i2c request. The hardware (a tpm) very occasionally appends a burst of
>> >> 0xff to the end of the data requested and the i2c interrupt handler mindlessly copies all
>> >> the data right past the end of the buffer and in my case across the stack. :-(
>> >
>> > ... because you as the master should have control over how many bytes
>> > you want to have. If you are done, send NAK+STOP and the message is
>> > over. Is it really the device (which one is it BTW?)? Or is the FIFO
>> > handling of the master driver buggy?
>> >
>> > Michal, S?ren?
>>
>> Just a quick comment - as I don't have time at the moment to look
>> deeply into the driver at the moment.
>>
>> I was just looking at Ch 20 of the TRM on the i2c under Read Transfer
>> and it says step 4 write the number of requested bytes to the Transfer
>> Size Register.
>>
>> But in the code it talks about a work around for large receive operation.
>>
>> Looking at the change log: commit  9fae82e1acda
>>
>> Explains for transfers > 252 bytes that
>>
>>      "the transfer size register has to be maintained at a value >= 1
>>
>> So my guess is the code is trying to keep this transfer size non-zero
>> and so just keeps pulling more bytes our of the slave i2c device. I
>> find it is hard to follow the complex code though.
>>
>> My buggy condition was a transfer of 128 bytes so it is not hit this
>> condition except in that the slave supplies way more bytes than was in
>> the original i2c_transfer request.
>
> So, let's add Harini Katakam to CC who implemented this. But I'd be
> happy for anyone from Xilinx to respond...

The workaround you are referring to is implemented under
"if (cdns_is_holdquirk(id, hold_quirk)) {"
and should not apply to your case of 128 byte transfer at all.

The specific place you have problem is under the loop
where RX data valid is being checked and ideally, that
buffer should never be written with more data than requested -
because no. of bytes requested is written to transfer size register,
the same is the amount the controller (master) fetches and
RX data valid remains set only for that duration.

Are you using Zynq?
I'm not working on this anymore but we could take a look at
your error if we are able to reproduce it.
Could you please provide more details of your application and
setup?

Regards,
Harini
