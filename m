From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 Mar 2011 13:29:14 -0800
Subject: [PATCH 2/4] msm: scm: Fix improper register assignment
In-Reply-To: <1298975837.7828.9.camel@e102144-lin.cambridge.arm.com>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>	
	<1298573085-23217-3-git-send-email-sboyd@codeaurora.org>	
	<1298640219.958.74.camel@e102144-lin.cambridge.arm.com>	
	<4D688AF1.1090607@codeaurora.org>	
	<20110226084736.GB3640@n2100.arm.linux.org.uk>	
	<8yazkpi3cfa.fsf@huya.qualcomm.com>	
	<alpine.LFD.2.00.1102261452340.22034@xanadu.home>
	<1298975837.7828.9.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4D6D652A.5050502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2011 02:37 AM, Will Deacon wrote:
> Hi Nicolas,
>
> On Sat, 2011-02-26 at 20:04 +0000, Nicolas Pitre wrote:
>> Right.  A minimal test case may look like this if someone feels like
>> filling a gcc bug report:
>>
>> extern int foo(int x);
>>
>> int bar(int x)
>> {
>>          register int a asm("r0") = 1;
>>          x = foo(x);
>>          asm ("add %0, %1, %2" : "=r" (x) : "r" (a), "r" (x));
>>          return x;
>> }
>>
>> And the produced code is:
>>
>> bar:
>>          stmfd   sp!, {r3, lr}
>>          bl      foo
>> #APP
>>          add r0, r0, r0
>>          ldmfd   sp!, {r3, pc}
>>
>> So this is clearly bogus.
>>
>
> I agree that this is wrong, but the compiler people may try and argue
> the other way. I'll ask some of the compiler guys at ARM and see what
> they think.

Nicolas and Will,

Thanks for the sample bug code and thanks for checking with the compiler 
guys and validating (in another thread) that this is indeed a bug in 
GCC. Glad to know we weren't doing something stupid.

>>> In any case, fortunately it works with the fix.
>>
>> Please add a comment in your patch to explain the issue.
>>
>
> Perhaps a more robust fix would be to remove the register int
> declarations and handle the parameter marshalling in the same asm block
> that contains the smc?

I was thinking the same, but the opposing idea I heard was that not 
doing it inside the asm block would allow GCC to be make better use of 
the registers. Didn't have a strong opinion either way, so we went with 
the implementation that was sent out.

Thanks,
Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
