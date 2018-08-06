From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Aug 2018 12:31:04 +0200
Subject: [RFC/PoC PATCH 0/3] arm64: basic ROP mitigation
In-Reply-To: <fef98ede-efe4-eaf2-f314-07b623e9800e@redhat.com>
References: <20180802132133.23999-1-ard.biesheuvel@linaro.org>
 <fef98ede-efe4-eaf2-f314-07b623e9800e@redhat.com>
Message-ID: <CAKv+Gu9p59qXHFa_dOAxExc-TdPUGf3Py07jxYaVYfY4ugQNJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2018 at 12:07, Florian Weimer <fweimer@redhat.com> wrote:
> On 08/02/2018 03:21 PM, Ard Biesheuvel wrote:
>>
>> The idea is that we can significantly limit the kernel's attack surface
>> for ROP based attacks by clearing the stack pointer's sign bit before
>> returning from a function, and setting it again right after proceeding
>> from the [expected] return address. This should make it much more
>> difficult
>> to return to arbitrary gadgets, given that they rely on being chained to
>> the next via a return address popped off the stack, and this is difficult
>> when the stack pointer is invalid.
>
>
> Doesn't this break stack unwinding?
>

Any exception that is taken between clearing and setting the SP bit
will first reset the bit. Since arm64 does not rely on hardware to
preserve the exception context, we can do this in code before
preserving the registers (which is why we need the 'little dance' in
the last patch)

So any time the stack unwinding code runs, the stack pointer should be valid.
