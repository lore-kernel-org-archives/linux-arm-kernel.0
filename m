From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 03 Mar 2015 16:47:32 -0500
Subject: [PATCH v2 2/8] arm64: Convert hcalls to use ISS field
In-Reply-To: <1425338536.9265.2.camel@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <1422660828.21823.40.camel@infradead.org> <20150219205714.GC24460@cbox>
 <1424902170.17282.9.camel@infradead.org> <20150302221355.GA12902@lvm>
 <1425338536.9265.2.camel@infradead.org>
Message-ID: <54F62BF4.1070306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 03/02/2015 06:22 PM, Geoff Levand wrote:
> Hi Christoffer,
> 
> On Mon, 2015-03-02 at 14:13 -0800, Christoffer Dall wrote:
>> On Wed, Feb 25, 2015 at 02:09:30PM -0800, Geoff Levand wrote:
>>> The current hyp-stub vector implementation, which uses x0, is limited
>>> to two hyper calls; __hyp_get_vectors and __hyp_set_vectors.  To
>>> support cpu_soft_restart() we need a third hyper call, one which
>>> allows for code to be executed at EL2.  My proposed use of the
>>> immediate value of the hvc instruction will allow for 2^16 distinct
>>> hyper calls.  
>>
>> right, but using x0 allows for 2^64 distinct hypercalls.  Just to be
>> clear, I'm fine with using immediate field if there are no good reasons
>> not to, I was just curious as to what direct benefit it has.  After
>> thinking about it a bit, from my point of view, the benefit would be the
>> clarity that x0 is first argument like a normal procedure call, so no
>> need to shift things around.  Is this part of the equation or am I
>> missing the overall purpose here?
> 
> Yes, in general it will make marshaling of args, etc. easier.  Also,
> to me, if we are going to change the implementation it seems to be
> the most natural way.

>From reading the architecture documentation, I too expected the hypervisor
call instruction's immediate and the instruction specific syndrome to be used.
However I vaguely recall someone pointing out that reading the exception
syndrome register and extracting the instruction specific syndrome is bound to
take longer than simply using a general purpose register.

One might also consider alignment with the SMC Calling Convention document
[1], which while originally written for SMC, is also used for HVC by PSCI [2].

1. http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0028a/index.html
2. http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0022c/index.html

Chris

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
