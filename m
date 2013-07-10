From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 Jul 2013 13:42:17 -0700
Subject: [PATCH] kexec: return error of machine_kexec() fails
In-Reply-To: <51DDB159.2080003@wwwdotorg.org> (Stephen Warren's message of
 "Wed, 10 Jul 2013 13:09:13 -0600")
References: <1373421296-6112-1-git-send-email-horms@verge.net.au>
 <87obaaiiry.fsf@xmission.com> <51DDB159.2080003@wwwdotorg.org>
Message-ID: <87txk2cfkm.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 07/10/2013 08:36 AM, Eric W. Biederman wrote:
>> Simon Horman <horms@verge.net.au> writes:
>> 
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> Prior to commit 3ab8352 "kexec jump", if machine_kexec() returned,
>>> sys_reboot() would return -EINVAL. This patch restores this behaviour
>>> for the non-KEXEC_JUMP case, where machine_kexec() is not expected to
>>> return.
>>>
>>> This situation can occur on ARM, where kexec requires disabling all but
>>> one CPU using CPU hotplug. However, if hotplug isn't supported by the
>>> particular HW the kernel is running on, then kexec cannot succeed.
>> 
>> Ugh. This reasoning is nonsense.  Prior to the kexec jump work
>> machine_kexec could never return and so could never return -EINVAL.
>
> Well, any function /can/ return. Perhaps there was some undocumented
> requirement that machine_kexec() was not allowed to return?

I think the name and the lack of an error code is in general a strong
indication that machine_kexec should not return.  As returning is
semantically wrong (baring kexec_jump).  There is the additional fact
that machine_kexec does not return.

> I did test
> it, and everything appears to work fine if it does return, aside from
> the error code.

My point was really that semantically you are failing in the wrong
location.


>> It is not ok to have an image loaded that we can not kexec.  kexec_load
>> should fail not machine_shutdown or machine_kexec.
>
> Hmm. I suppose one option is to enhance ARM's machine_kexec_prepare(),
> which is called from kexec_load(), and have that fail unless either the
> current HW is non-SMP, or full CPU HW/driver hotplug/PM support is
> available, so that it's guaranteed that machine_shutdown() will be able
> to fully disable all but one CPU.
>
> Would that be acceptable?

Yes.  Failing in kexec_load via ARMS's machine_kexec_prepare seems much
more appropriate, and it is where userspace will expect and be prepared
to deal with a failure.

> Other alternatives would be:
>
> a) Force the user to disable (hot unplug) the CPUs themselves before
> calling kexec_load(). This seems rather onerous, and could be defeated
> by replugging them between kexec_load() and kernel_kexec().
>
> b) Actually modifying kexec_load() to disable the CPUs, at the point
> where it's legal for it to fail. However, I suspect some use-cases call
> kexec_load() a long time before kernel_kexec(), so this would end up
> disabling SMP way too early.
>
>> ARM needs to get it's act together and stop modifying the generic code
>> to deal with it's broken multi-cpu architecture.
>
> A standardized in-CPU mechanism for disabling CPUs as part of the ARM
> architecture would be nice. However, even if that appears today, it's
> not going to help all the already extant systems that don't have it.

I meant code not hardware architecture.  We keep having code thrown in
the the shutdown paths because ARM only supports cpu shutdown via cpu
hotunplug and cpu hotunplug is not universally available.

That is a software architecture BUG with the ARM kernels.

I admit that using cpu hotunplug for everything sounds good on paper but
in practice cpu hotunplug is a nasty heavy weight monster that is much
harder to support than other cpu shutdown schemes.

Eric
