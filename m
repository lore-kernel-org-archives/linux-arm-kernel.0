From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Jul 2015 16:03:16 -0700
Subject: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <20150727030239.GG19944@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976> <20150727030239.GG19944@linux>
Message-ID: <55B80A34.1010805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2015 08:02 PM, Viresh Kumar wrote:
> On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
>> Isn't using u32 for storing frequency (in Hz) too small by today's
>> standards?
>>
>> [ Please note that the old v1 binding uses kHz not Hz. ]
> I have thought about this a bit more and I am somewhat confused. Yes I
> agree that u32 isn't big enough for frequencies in Hz, i.e. Max value
> of 4294967295 ~ 4.29 GHz.
>
> But the bigger problem lies with the clk API that we have today. It
> declares clk-rate as a unsigned-long which is 32 bits on a 32 bit
> machine and 64 bits on a 64 bit machine. And every single piece of
> code reading "clock-frequency" DT property, reads it as a 32 bit value
> as we reserve only a single cell for it.
>
> Now, if we wanna change that, we need to start changing from the
> clk-API itself and that's not gonna be a small task and I would leave
> it to Mike/Stephen for obvious reasons :)
>
> So, I will keep this code in sync with rest of the kernel and lets see
> what Mike has to say.
>

There is talk about moving to 64 bits for the frequency in the clk API.
It's not actively being developed though and I'm not sure when we'll get
there. From a DT perspective though, I don't see why it would be bad to
have two cells instead of one cell for the frequency here. It would
allow up to 64 bits of frequency so that when we change the clk API we
won't need to do anything in the OPP bindings to handle it. Just because
we have problems in the kernel doesn't mean we should put the same
problems into DT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
