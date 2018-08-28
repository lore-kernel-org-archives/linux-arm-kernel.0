From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Tue, 28 Aug 2018 18:47:33 +0530
Subject: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q}
 tracing support
In-Reply-To: <20180827121530.525299e3@gandalf.local.home>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
 <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
 <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
 <7b212c02-d7ce-4309-155f-22b36963e41c@codeaurora.org>
 <20180827121530.525299e3@gandalf.local.home>
Message-ID: <369f384b-c419-99d8-c0a4-3ed38f1dd0f4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/27/2018 9:45 PM, Steven Rostedt wrote:
> On Sat, 25 Aug 2018 12:54:07 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
> 
>> Ftrace does not trace __raw{read,write}{b,l,w,q}() functions. I am not
>> sure why and how it is filtered out because I do not see any notrace
>> flag in those functions, maybe that whole directory is filtered out.
>> So adding this functionality to ftrace would mean removing the notrace
>> for these functions i.e., something like using
>> __raw{read,write}{b,l,w,q}() as the available filter functions. Also
>> pstore ftrace does not filter functions to trace I suppose?
> 
> It's not traced because it is inlined. Simply make the __raw_read
> function a normal function and it will be traced. And then you could
> use ftrace to read the function.
> 
> If this has to be per arch, you can register your callback with the
> REGS flags, and pt_regs will be passed to your callback function you
> attached to __raw_read*() as if you inserted a break point at that
> location, and you can get any reg data you want there.
> 
>

Thank you very much for the information Steven. Ok so we can get 
function parameters with pt_regs.

>>
>> Coming to the reason as to why it would be good to keep this separate
>> from ftrace would be:
>> * Ftrace can get ip and parent ip, but suppose we need extra data (field
>> data) as in above sample output we would not be able to get through ftrace.
> 
> As mentioned above, you can get regs (and ftrace is being expanded now
> to get parameters of functions).
> 
You mean there is another way to get parameters other than regs?

>>
>> * Although this patch is for tracing register read/write, we can easily
>> add more functionality since we have dynamic_rtb api which can be hooked
>> to functions and start tracing events(IRQ, Context ID) something similar
>> to tracepoints.
>> Initially thought of having tracepoints for logging register read/write
>> but I do not know if we can export tracepoint data to pstore since the
>> main usecase is to debug unknown resets and hangs.
> 
> I don't know why not? We have read/write tracepoints for
> read/write_msr() calls in x86.
> 
> Anything can add a hook to the callback of the tracepoints, and use
> that infrastructure instead of creating yet another dynamic code
> modification infrastructure.
> 
Thanks for pointing out to read/write_msr, I checked it and was able to 
implement something similar for arm64. But still can we export 
tracepoint data to pstore because we need to debug reset cases and for 
that pstore is of real importance?. If so then it would be great to have 
various events logged into pstore which can be a lot of help for debugging.

Also with the current dynamic filtering of read/write(PATCH 3/3), it is 
a lot easier to filter register read/write since we use dynamic debug 
framework which provides file, function and line level filtering 
capacity. Maybe if we can add something like this to trace events it 
would be better?

- Sai Prakash
