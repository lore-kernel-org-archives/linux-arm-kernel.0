From: robert.walker@arm.com (Robert Walker)
Date: Wed, 2 May 2018 09:25:38 +0100
Subject: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
In-Reply-To: <20180501225503.a55fb963795afb40163f3763@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
 <20180501225503.a55fb963795afb40163f3763@arm.com>
Message-ID: <019a4703-f51a-b402-7e92-c5045a17361a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/18 04:55, Kim Phillips wrote:
> On Tue, 1 May 2018 10:10:51 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>> Convert component enable/disable messages from dev_info to dev_dbg.
>> This is required to prevent LOCKDEP splats when operating in perf
>> mode where we could be called with locks held to enable a coresight
> Can we see the splats?  Doesn't lockdep turn itself off if it starts
> triggering too many splats?
>
>> path. If someone wants to really see the messages, they can always
>> enable it at runtime via dynamic_debug.
> Won't the splats still occur when the messages are enabled with
> dynamic_debug?
>
> So in effect this patch only tries to mitigate the splats, all the
> while making things harder for regular users that now have to recompile
> their kernels, in exchange for a very small convenience for kernel
> developers that happen to see a splat or two with DEBUG_LOCKDEP set?
>
> Not the greatest choice...How about moving the dev_infos outside of the
> locks instead?
>
> Thanks,
>
> Kim
The other reason for making these dev_dbg is performance - a message is 
output each time a source / link / sink is enabled or disabled, so we 
can get 20+ messages on each process switch when tracing with perf.? 
This has a significant effect on the runtime of the application being 
traced.

Regards

Rob
