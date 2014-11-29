From: wangnan0@huawei.com (Wang Nan)
Date: Sat, 29 Nov 2014 09:28:24 +0800
Subject: [PATCH v10 2/2] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1417099007.2041.6.camel@linaro.org>
References: <1416551751-50846-1-git-send-email-wangnan0@huawei.com>	
 <1416551751-50846-3-git-send-email-wangnan0@huawei.com>
 <1417099007.2041.6.camel@linaro.org>
Message-ID: <54792138.2060008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/27 22:36, Jon Medhurst (Tixy) wrote:
> On Fri, 2014-11-21 at 14:35 +0800, Wang Nan wrote:
>> This patch introduce kprobeopt for ARM 32.
> 
> If I've understood things correctly, this is a feature which inserts
> probes by using a branch instruction to some trampoline code rather than
> using an undefined instruction as a breakpoint. That way we avoid the
> overhead of processing the exception and it is this performance
> improvement which is the main/only reason for implementing it?
> 
> If so, I though it good to see what kind of improvement we get by
> running the micro benchmarks in the kprobes test code. On an A7/A15
> big.LITTLE vexpress board the approximate figures I get are 0.3us for
> optimised probe, 1us for un-optimised, so a three times performance
> improvement. This is with an empty probe pre-handler and no post
> handler, so with a more realistic usecase, the relative improvement we
> get from optimisation would be less.
> 
> I thought it good to see what sort of benefits this code achieves,
> especially as it could grow quite complex over time, and the cost of
> that versus the benefit should be considered.
> 
> 

Thanks for your comments and your comprehensive testing.

In fact I have got even worst performance result on my hardware platform.
However, by utilizing previous introduced checker code to check instructions
in detail, I believe we can eliminate most of the emulation/simulation works
so the cost can be reduced.

Futhermore, kprobeopt can avoid exceptions, which have at least 2 advantanges:

1. Make things simpler. Although exception processing is fast in real hardware,
   it still need more state changing and processing than a branch instruction,
   which may cause unexcepted problems.

2. Branch instructions can be used in more cases than exception. For example,
   at very early stage of kernel booting when exception vector is
   not installed, and at kernel panic processing.
