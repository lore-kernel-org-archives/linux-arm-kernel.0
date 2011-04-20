From: mbohan@codeaurora.org (Michael Bohan)
Date: Tue, 19 Apr 2011 18:44:46 -0700
Subject: MT_HIGH_VECTOR mapping set read-only creating illegal access
In-Reply-To: <alpine.LFD.2.00.1104191956290.24613@xanadu.home>
References: <4DA4F170.4020009@codeaurora.org>
	<alpine.LFD.2.00.1104122308400.28032@xanadu.home>
	<4DAE0E07.9030806@codeaurora.org>
	<alpine.LFD.2.00.1104191956290.24613@xanadu.home>
Message-ID: <4DAE3A8E.1000903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2011 5:21 PM, Nicolas Pitre wrote:
> Are you saying that your user space libc was reading at 0xffff0ff0
> directly?  I hope not, because if you did so, you clearly abused the
> interface and the contract between user space and the kernel.  Here's
> what I wrote in the comment right above the related code:
>
>   * These are segment of kernel provided user code reachable from user space
>   * at a fixed address in kernel memory.  This is used to provide user space
>   * with some operations which require kernel help because of unimplemented
>   * native feature and/or instructions in many ARM CPUs. The idea is for
>   * this code to be executed directly in user mode for best efficiency but
>   * which is too intimate with the kernel counter part to be left to user
>   * libraries.  In fact this code might even differ from one CPU to another
>   * depending on the available  instruction set and restrictions like on
>   * SMP systems.  In other words, the kernel reserves the right to change
>   * this code as needed without warning. Only the entry points and their
>   * results are guaranteed to be stable.
>
> This has been there since April 29th 2005 i.e. 6 years ago.

Yes, unfortunately Android appears to do this as an 'optimization' in 
the case of dynamically linked execs. That is, it skips the helper code 
all together.

Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
