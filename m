From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 14 Mar 2014 13:55:07 +0900
Subject: [PATCH v6 6/7] arm64: ftrace: Add CALLER_ADDRx macros
In-Reply-To: <1394734070.26600.6.camel@pippen.local.home>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>	
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>	
 <1394705630-12384-7-git-send-email-takahiro.akashi@linaro.org>	
 <20140313155415.GB25472@mudshark.cambridge.arm.com>
 <1394734070.26600.6.camel@pippen.local.home>
Message-ID: <53228BAB.7080005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2014 03:07 AM, Steven Rostedt wrote:
> On Thu, 2014-03-13 at 15:54 +0000, Will Deacon wrote:
>> On Thu, Mar 13, 2014 at 10:13:49AM +0000, AKASHI Takahiro wrote:
>>> CALLER_ADDRx returns caller's address at specified level in call stacks.
>>> They are used for several tracers like irqsoff and preemptoff.
>>> Strange to say, however, they are refered even without FTRACE.
>>>
>>> Please note that this implementation assumes that we have frame pointers.
>>> (which means kernel should be compiled with -fno-omit-frame-pointer.)
>>
>> How do you ensure that -fno-omit-frame-pointer is passed?
>
> Perhaps -pg does the same thing?
>
>>> +#define HAVE_ARCH_CALLER_ADDR
>>> +
>>> +#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
>>> +#define CALLER_ADDR1 ((unsigned long)return_address(1))
>>> +#define CALLER_ADDR2 ((unsigned long)return_address(2))
>>> +#define CALLER_ADDR3 ((unsigned long)return_address(3))
>>> +#define CALLER_ADDR4 ((unsigned long)return_address(4))
>>> +#define CALLER_ADDR5 ((unsigned long)return_address(5))
>>> +#define CALLER_ADDR6 ((unsigned long)return_address(6))
>>
>> Could we change the core definitions of these macros (in linux/ftrace.h) to
>> use return_address, then provide an overridable version of return_address
>> that defaults to __builtin_return_address, instead of copy-pasting this
>> sequence?
>
> We could add a new macro:
>
> /* All archs should have this, but we define it for consistency */
> #ifndef ftrace_return_address0
> # define ftrace_return_address0  __builtin_return_address(0)
> #endif
> /* Archs may use other ways for ADDR1 and beyond */
> #ifndef ftrace_return_address
> # define ftrace_return_address(n) __builtin_return_address(n)
> #endif
>
> And then have:
>
> #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
> #define CALLER_ADDR1 ((unsigned long)ftrace_return_address(1))
> [...]
>
> And then you would only need to redefine ftrace_return_address.

I'm going to create a separate RFC, including fixes for other archs.

-Takahiro AKASHI

> -- Steve
>
>
