From: amworsley@gmail.com (Andrew Worsley)
Date: Mon, 16 Oct 2017 20:18:37 +1100
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
In-Reply-To: <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
Message-ID: <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks I think I know understand how this transfer register is set up.
I will add some diagnostic printk's to track down exactly how it is
failing and get back to you.

 Yes it is zynq. The test case is large (128 byte) transfers from a
tpm to fill an rng driver. I just pull large amounts of data via dd.

It may depend on the i2c slave being willing to just respond to
requests that read arbitrary amounts of data. In this case the TPM
appeared to generate FF when requested for more data than was in the
TPM_RANDOM request.



On 16 October 2017 at 16:55, Harini Katakam
<harinikatakamlinux@gmail.com> wrote:
> Hi Andrew,
>
> On Sat, Oct 14, 2017 at 12:16 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
.....
>>
>> So, let's add Harini Katakam to CC who implemented this. But I'd be
>> happy for anyone from Xilinx to respond...
>
> The workaround you are referring to is implemented under
> "if (cdns_is_holdquirk(id, hold_quirk)) {"
> and should not apply to your case of 128 byte transfer at all.

Ah I can see the logic now. If the transfer is small (< 250 or so
bytes) it will just write it into the transfer register. Yes my
transfers are only 128 + some TPM related headers ( not big I expect).
....


>
> The specific place you have problem is under the loop
> where RX data valid is being checked and ideally, that
> buffer should never be written with more data than requested -
> because no. of bytes requested is written to transfer size register,
> the same is the amount the controller (master) fetches and
> RX data valid remains set only for that duration.

If the transfer register was set with the
>
> Are you using Zynq?
> I'm not working on this anymore but we could take a look at
> your error if we are able to reproduce it.
> Could you please provide more details of your application and
> setup?
>
> Regards,
> Harini

Yes - I will get back to you with more details and further debugging
around exactly how it is failing.

Assuming it is not obvious how to fix it - perhaps I can try setting
the transfer register to zero when it hits the end of the transfer?
(if recv_count == 0).

Thanks very much Harini  - that was just the pointer I needed to
follow the code.

Andrew
