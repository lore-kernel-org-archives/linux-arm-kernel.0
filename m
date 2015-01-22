From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 22 Jan 2015 11:21:51 +0000
Subject: [PATCH 3.19-rc2 v14 0/7] arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <54BFAE3F.7000300@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>	<1421144818-14036-1-git-send-email-daniel.thompson@linaro.org>	<54BE2D15.9080606@linaro.org>	<54BEC04D.1050402@codeaurora.org>	<54BF83C9.5060300@linaro.org>
 <20150121080612.6569ab81@gandalf.local.home> <54BFAE3F.7000300@linaro.org>
Message-ID: <54C0DD4F.7030807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/01/15 13:48, Daniel Thompson wrote:
> On 21/01/15 13:06, Steven Rostedt wrote:
>> On Wed, 21 Jan 2015 10:47:37 +0000
>> Daniel Thompson <daniel.thompson@linaro.org> wrote:
>>
>>
>>>> With this patchset, is it possible to call sched_clock() from within NMI
>>>> context? I ask because the generic sched_clock() code is not NMI safe
>>
>> That's not good. Better not run function tracing, as that could trace
>> functions in NMI context (I depend on that it does), and it uses
>> sched_clock() as the default clock.
> 
> I think sched_clock is unsafe as in "may sometimes give the wrong value"
> rather than "can lock up arbitrarily".  Thus the impact is unlikely to
> be harmful enough to want to avoid tracing altogether.

Just to update the record...

The above paragraph is wrong in every possible way. It is a livelock
(and I'm working on it).



> It would require special care be taken when interpreting the timestamps
> however. Also since update_sched_clock() is a notrace function its very
> hard to figure out when timestamps are at risk.
> 
> Anyhow, the fix doesn't seem that hard. I can take a look.
> 
> 
> Daniel.
> 
