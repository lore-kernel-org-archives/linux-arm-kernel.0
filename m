From: luc.vanoostenryck@gmail.com (Van Oostenryck Luc)
Date: Tue, 7 Feb 2017 21:33:15 +0100
Subject: [RFC/PATCH] arm64: Rename macro arguments to silence sparse
In-Reply-To: <5f7a5bf1-1285-d9c3-b892-c8f9f8ee6d63@codeaurora.org>
References: <20170207010143.22371-1-sboyd@codeaurora.org>
 <d5bb9d5a-5b02-ffab-d404-bbda532b6c76@codeaurora.org>
 <20170207015047.4ffc3xzrqsuuzo54@macpro.local>
 <5f7a5bf1-1285-d9c3-b892-c8f9f8ee6d63@codeaurora.org>
Message-ID: <CAExDi1T5+odE6j2mFpUheN+3RQwabvgKmqKHHgWReE3L6oQAVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 9:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/06/2017 05:50 PM, Luc Van Oostenryck wrote:
>> On Mon, Feb 06, 2017 at 05:08:17PM -0800, Stephen Boyd wrote:
>>> On 02/06/2017 05:01 PM, Stephen Boyd wrote:
>>>> When I compile files with sparse, I get these sorts of warnings:
>>>>
>>>> arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
>>>> arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
>>>> arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'
>>>>
>>>> This is because sparse is trying to tokenize these files and sees
>>>> a line like this:
>>>>
>>>>  alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
>>>>
>>>> It gets past alternative_insn part and then sees the start of a
>>>> string with the double quote character. So sparse starts to parse
>>>> the string (eat_string() in the sparse code) but the string has
>>>> an escape character '\' in it. Sparse sees the escape character,
>>>> so it checks to see if it's an escape sequence, but '\l' isn't.
>>>> This causes sparse to spit out this warning of an unknown escape
>>>> sequence 'l'.
>>>>
>>>> In reality, sparse isn't going to use these macros anyway because
>>>> this whole thing is inside an __ASSEMBLER__ ifdef.
>> Yes, annoying. Conversion of escaped characters is supposed to be
>> done just after preprocessing. It's definitively a bug.
>
> Ok. Thanks for the fixes to sparse. My hack patch can be safely ignored.

Well, I don't know.
Maybe it's still useful for everyone using the official version of sparse
or an older one.

Luc Van Oostenryck
