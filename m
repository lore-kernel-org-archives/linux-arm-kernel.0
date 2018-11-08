From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Nov 2018 18:14:01 +0100
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <63dfc72c-fa76-c3e9-b888-0e4cff6bf2fb@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu-jVTWyy61Q--HE_Hw+RZVxYcTypZmF+YUhmX1p_QkLKQ@mail.gmail.com>
 <8382cafd-9fb7-7121-0de2-5091ba079d31@arm.com>
 <CAKv+Gu_K9p5FvQGtvgzKmveiQvHQp1H1PxAzxqcFnJfDQt4huw@mail.gmail.com>
 <cdae83fa-dc71-e635-acda-be363695bf0c@arm.com>
 <20181108153032.GC3505@e103592.cambridge.arm.com>
 <312bdb62-4361-2475-da62-a42b9d22e8bb@arm.com>
 <20181108153916.GD3505@e103592.cambridge.arm.com>
 <CAKv+Gu_C=0mOcrR1_=8key1RNsvYm-TSFFTZQzir6fpTCmYS-w@mail.gmail.com>
 <63dfc72c-fa76-c3e9-b888-0e4cff6bf2fb@arm.com>
Message-ID: <CAKv+Gu_1Dk759VxNvmvPdxALttwLWW7xyC70v_aRbnFYqLmW=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2018 at 17:57, Ramana Radhakrishnan
<Ramana.Radhakrishnan@arm.com> wrote:
>
>>
>> Indeed.
>>
>> But my question remains how likely it is that the compiler we use for
>> generating the kernel code (so we are not talking about userland JITs
>> or other crazy stuff here) would play with SP like that, especially
>> since it is no longer a general purpose register. To me, it would make
>> sense to attempt to reach an agreement with the GCC folks that
>> compiler generated code does not muck about with SP like that.
>
>
> It falls out from the choice of instructions we use for this sort of
> thing and because frame sizes really get rounded up to 16 bytes.
>
> In the explanation below assume the stack is aligned to 16 bytes on
> entry. Frame sizes are always a multiple of 16.
>
> For frame sizes up to 240 bytes that's a stp fp, lr, [sp, #-<off>]!
>
> For frame sizes up to 4k bytes, that's a single sub instruction. Again
> all frame sizes are 16 byte aligned and therefore it's all ok.
>
> For frame sizes greater than this and up to 64k that's a mov to a
> temporary register with a 16 bit immediate followed by a single
> subtract, again not going to leave your stack frame misaligned.
>
>  From frame sizes above that we split this into a subtract with a
> multiple of 4k (again 16 byte aligned) and the rest.
>
> For frame size above 16MB we use a sequence of mov / movk's with a
> temporary register and then do a single subtract of SP and therefore
> that's also fine.
>

Thanks Ramana. In the kernel, stack frames are typically limited to ~1
KB in size, so most of these will never even be encountered in our
case.

> I think for the sake of this conversation with respect to compiling the
> kernel, I think we can safely say that GCC will end up leaving the stack
> 16 byte aligned even with the intermediate computations and that
> shouldn't be an issue from my reading of the AArch64 backend.
>
> So, probably move on but if you really want to be defensive you may want
> to carry this patch. However there's nothing that I will say about
> hand-written assembly (and I say that in the interest of completeness).
>

indeed, hand written assembly is an entirely different matter, but
that is a manageable quantity of code which is currenty clean in this
regard, as far as we know.
