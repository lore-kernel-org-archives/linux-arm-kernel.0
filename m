From: david.yangshuai@gmail.com (David Yang)
Date: Wed, 28 Jul 2010 18:06:46 +0800
Subject: Questions about FPU and NEON on Cortex-A9 with armv7
	instructions!
In-Reply-To: <4C4FF8FF.304@xenomai.org>
References: <AANLkTinA_ZNdNwx2R-6C9LBQ=4i8uMVpmVFCRaKkS=Xs@mail.gmail.com>
	<AANLkTi=EBvumJfRJmBwHVtHAW081ewBzjAR2d=2O2-Zd@mail.gmail.com>
	<AANLkTikHns6tdbVK-CDoiv10V-pHaYFf0AvB5s=ti9k5@mail.gmail.com>
	<4C4FF8FF.304@xenomai.org>
Message-ID: <AANLkTinoZ0GT5FFUFPmU5gQK1zVcZKYtSWpHDQ1Y4OXO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My God...

The job for the FPU is big enough.

But I am not sure the kernel itself won't use the FPU . And I just
want to use FPU in my driver other than the whole kernel.

If the other kernel code doesn't save and restore the FPU context,then
it's risky.

Can I use FPU just in one C file ?

On Wed, Jul 28, 2010 at 5:31 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> David Yang wrote:
>> Hi,Martin
>>
>> ? ? I see.
>>
>> ? ? But I will ?try to use FPU in kernel for testing. I hope kernel won't crash.
>
> You will not get FPU working in kernel-space without any effort. The
> kernel handles lazy switching of FPU context for user-space tasks, but
> not for the kernel itself. If you start using the FPU at any place in
> the kernel, the changes you made would clobber the FPU context of the
> user-space task currently running, which is probably not what you want.
>
> What you will have to do is what the x86 kernel does in the RAID code
> for instance (file drivers/md/raid6mmx.c), disable preemption, save the
> fpu context, do your computations, then restore the fpu context and
> re-enable preemption. For the operation to be worth it, the gain you
> obtain by using the FPU has to be greater than the time for an fpu
> context save and restore, and saving/restoring the fpu context is a
> pretty heavy operation. This means that if you want the FPU for a
> multiplication or a division, forget it, you will actually be loosing
> time, and soft-float will be more efficient.
>
> --
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Gilles.
>
