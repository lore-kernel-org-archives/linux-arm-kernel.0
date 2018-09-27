From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 27 Sep 2018 09:26:59 -0700
Subject: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
In-Reply-To: <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
 <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
 <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
 <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com>
 <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com>
 <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com>
Message-ID: <BB2CD8D5-E7FF-4D25-8C83-F64960253248@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Sep 27, 2018, at 8:19 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> Hey again Thomas,
> 
>> On Thu, Sep 27, 2018 at 3:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> 
>> Hi Thomas,
>> 
>> I'm trying to optimize this for crypto performance while still taking
>> into account preemption concerns. I'm having a bit of trouble figuring
>> out a way to determine numerically what the upper bounds for this
>> stuff looks like. I'm sure I could pick a pretty sane number that's
>> arguably okay -- and way under the limit -- but I still am interested
>> in determining what that limit actually is. I was hoping there'd be a
>> debugging option called, "warn if preemption is disabled for too
>> long", or something, but I couldn't find anything like that. I'm also
>> not quite sure what the latency limits are, to just compute this with
>> a formula. Essentially what I'm trying to determine is:
>> 
>> preempt_disable();
>> asm volatile(".fill N, 1, 0x90;");
>> preempt_enable();
>> 
>> What is the maximum value of N for which the above is okay? What
>> technique would you generally use in measuring this?
>> 
>> Thanks,
>> Jason
> 
> From talking to Peter (now CC'd) on IRC, it sounds like what you're
> mostly interested in is clocktime latency on reasonable hardware, with
> a goal of around ~20?s as a maximum upper bound? I don't expect to get
> anywhere near this value at all, but if you can confirm that's a
> decent ballpark, it would make for some interesting calculations.
> 
> 

I would add another consideration: if you can get better latency with negligible overhead (0.1%? 0.05%), then that might make sense too. For example, it seems plausible that checking need_resched() every few blocks adds basically no overhead, and the SIMD helpers could do this themselves or perhaps only ever do a block at a time.

need_resched() costs a cacheline access, but it?s usually a hot cacheline, and the actual check is just whether a certain bit in memory is set.
