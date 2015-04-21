From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 12:18:08 +0200
Subject: No subject
Message-ID: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2015 at 12:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 21, 2015 at 12:08:51PM +0200, Ard Biesheuvel wrote:
>> This updates the PROCINFO offset-to-setup-function fields of the
>> Thumb2 capable CPU definitions to include the Thumb bit when building
>> a Thumb2 kernel. This ensures that these function are always called
>> in the correct mode.
>
> I don't think this is necessary, in fact, I think this is positively
> regression causing.
>
> The symbol 'initfunc' is known to the assembler to be a thumb symbol.
> As we have seen already from the kernel dumps from the V7M kernel, when
> it calculates initfunc - name in a T2 kernel, the resulting value is an
> _odd_ number.
>

OK, so BSYM() uses '+ 1' rather than ' | 1'? I wasn't expecting that, sorry.

But looking at proc-v7.S again, the problem may just be the missing
ENDPROC() declarations for a couple of the setup() functions, which
explains why they are lacking the Thumb annotations.

> Using BSYM() here will increment it to be the next _even_ number, which
> is wrong as this will potentially point at either half way through a
> 32-bit T2 instruction, or the second 16-bit T2 instruction.
>

Agreed.
