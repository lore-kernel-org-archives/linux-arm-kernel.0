From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Nov 2017 21:31:29 +0000
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <20171120212941.051d11c4@delmar.localdomain>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-17-samitolvanen@google.com>
 <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
 <20171120212941.051d11c4@delmar.localdomain>
Message-ID: <CAKv+Gu9gThj2ZHDBjm2drEjnu8CZAWwR96k8XFFfMkXRmfEgaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2017 at 21:29, Alex Matveev <alxmtvv@gmail.com> wrote:
> On Mon, 20 Nov 2017 15:20:14 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
>
>> On Wed, Nov 15, 2017 at 01:34:26PM -0800, Sami Tolvanen wrote:
>> > CONFIG_LTO_CLANG requires the use of clang's integrated assembler,
>> > which doesn't understand the inline assembly in aes-ce-cipher.c.
>> > Disable LTO for the file to work around the issue.
>>
>> Could you elaborate on what the integrated asembler doesn't like?
>>
>> It's not entirely clear at a glance, as the asm in that file doesn't
>> seem to do anything that obscure.
>>
>> Is it a bug?
>
> Turns out, integrated assembler doesn't like this instruction in
> aes_sub():
>         umov    %w[out], v0.4s[0]
>
> Specifically, it barks at "v0.4s[0]" part. And the way I read the spec,
> it's quite correct in not accepting this argument. From UMOV
> description:
>
> UMOV <Wd>, <Vn>.<Ts>[<index>]
>
> ...
>
> <Ts> For the 32-bit variant: is an element size specifier, encoded in
> the "imm5" field. It can have the following values:
>         B       when imm5 = xxxx1
>         H       when imm5 = xxx10
>         S       when imm5 = xx100
>
>
> With "v0.s[0]" it builds fine.
>
> Ard, since this is your code, can you comment? Feels like a typo.
>

Yep.
