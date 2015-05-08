From: xi.wang@gmail.com (Xi Wang)
Date: Fri, 8 May 2015 01:45:59 -0700
Subject: [PATCH] arm64: bpf: fix signedness bug in loading 64-bit immediate
In-Reply-To: <20150508083856.GA2125@arm.com>
References: <1431063591-16668-1-git-send-email-xi.wang@gmail.com>
 <20150508083856.GA2125@arm.com>
Message-ID: <CAKU6vybvWvoF2Om0D-tPp0N-_4Oj3o44hnbmrnEtyNN8XeBAHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 8, 2015 at 1:38 AM, Will Deacon <will.deacon@arm.com> wrote:
>> -             imm64 = (u64)insn1.imm << 32 | imm;
>> +             imm64 = ((u64)(u32)insn1.imm) << 32 | (u64)(u32)imm;
>
> This seems a bit convoluted to me. Don't you just need to add a (u32)
> cast to imm and that's it? The (u64)(u32) looks redundant.

You're right -  the second (u64) is redundant; the hope was to make
the code easier to understand.  It's from the interpreter code in
kernel/core/bpf.c, which uses (u64)(u32) as well.

>> -                     BPF_ALU64_IMM(BPF_MOV, R0, 1),
>> +                     BPF_LD_IMM64(R0, 0x1ffffffffLL),
>> +                     BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
>>                       BPF_EXIT_INSN(),
>
> This hunk should probably be a separate patch, unless you get Alexei's ack
> for me to take it via the arm64 tree too.

I would be happy to split this into a separate patch if that works
better, or simply drop this part.

- xi
