From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Thu, 10 Oct 2013 16:44:50 +0300
Subject: [RFC PATCH] ARM: kexec: Assemble relocate code in ARM mode
In-Reply-To: <20131010090205.GA3817@mudshark.cambridge.arm.com>
References: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
 <20131010090205.GA3817@mudshark.cambridge.arm.com>
Message-ID: <CAArO44uatC-4nFH+aFGezUUe1FUzdqzJJ-kTkDwBUNa8Aydecw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2013 12:02, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Oct 09, 2013 at 09:57:03PM +0100, Taras Kondratiuk wrote:
>> In Thumb2 kernel (CONFIG_THUMB2_KERNEL) kexec's relocate code is assembled
>> in Thumb2 mode, but cpu_v7_reset() jumps to this code in ARM state,
>> because its address is page aligned and has 0 in LSB.
>
> This used to work, but Dave broken it when he fixed the reset code in
> 153cd8e839b5 ("ARM: 7553/1: proc-v7: Ensure correct instruction set after
> cpu_reset").
>
>> Assemble this code in ARM mode to fix the issue.
>
> In the interest of keeping kexec a possibility for v7m, it might be better
> to do something similar to head.S (i.e. switch back to thumb if we're a
> thumb-2 kernel).
>

Actually only v7 jumps here in ARM, so maybe it worth to wrap the patch with
CONFIG_CPU_V7? In this case v7m won't be touched.

I'll update patch with a stub that switches back to Thumb, but honestly
I don't see a bit sense of it here. Anyway at the end of this function
instruction set is switched again.

-- 
Regards,
Taras Kondratiuk
