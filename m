From: Ramana.Radhakrishnan@arm.com (Ramana Radhakrishnan)
Date: Tue, 20 Nov 2018 17:02:19 +0000
Subject: compiler code model for the kernel
In-Reply-To: <CAKv+Gu-Aahpi1c4G9sntc23NaWXr0hta-aN6_vwyQf5cynTTwQ@mail.gmail.com>
References: <CAKv+Gu8LchCWB-b+cDmStwrNf5qDs6ZMQ4drv2HMk-8OyjbzNQ@mail.gmail.com>
 <20181120132331.GB25884@arm.com>
 <CAKv+Gu-Aahpi1c4G9sntc23NaWXr0hta-aN6_vwyQf5cynTTwQ@mail.gmail.com>
Message-ID: <321a0885-2169-2fae-a093-ad78d83b7133@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2018 13:49, Ard Biesheuvel wrote:
>>
>> It would be great if we could disable idiom recognition by the compiler as
>> part of this option, since this ends up with us failing to inline code
>> because the compiler ends up wanting to use vector registers but can't, so
>> replaces the idiom with a call to a libgcc function which we're forced to
>> implement out-of-line.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=200671
>>

I think idiom recognition is fine. Is this still an issue, I thought the 
commit on 13th November "fixed" it ?

We shouldn't look to turn off every single optimization feature, these 
are put into the compiler and we should look to make this work better 
between the kernel and the toolchain in general and not just punt 
always. Case in point, see the work that's being attempted with the ipa 
optimizations and live patching.

I don't like the idea of pushing in such things into a -mcmodel option 
as it is really not sustainable. I think those sort of errors should be 
fixed generically and not really as part of this backend option.

> 
> This is another thing that we may have been getting away with by
> accident: currently, we don't include libgcc at all, and since we
> build the kernel with -mgeneral-regs-only, there is no way we could
> without rebuilding it (unless libgcc is somehow guaranteed not to use
> FP registers)
> 
> So I think idiom recognition is fine in general: I guess this is also
> the thing that replaces memset() calls with stp xzr,xzr,[]
> instructions? It is the unanticipated libgcc dependency that is a
> problem, and I guess this may trigger in other parts of the compiler
> as well.

> 
> Note that we do provide the 'intrinsic' memcpy() and memset()
> routines, simply because they have the same name in the kernel (and
> they are libc not libgcc).
> 
> 
>> Another desirable feature would be having a way to force the assembler
>> to accept arbitrary instructions, rather than have to use .arch_extension
>> all over the place.
>>
> 
> IIRC this is a recent change in GCC where it repeats the .arch/.cpu
> directive for each function?
> 

That is required IIRC for LTO and target function attributes to work 
reliably. You could have different functions compiled at different 
architecture levels with __attribute__((target (arch=)) .

And part of it is due to the static checking that gas gives you with 
respect to the architecture.

The .arch_extension is really an arm  (AArch32) feature, on AArch64 
architectural features should really get added to the .arch string 
separated by a `+'.

Ramana
