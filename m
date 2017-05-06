From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Sun, 7 May 2017 01:57:48 +0530
Subject: arch: arm: bpf: Converting cBPF to eBPF for arm 32 bit
In-Reply-To: <20170506.143816.2259768618578706384.davem@davemloft.net>
References: <CAHgaXdJ1M4W3p9=B2hJmtxByPsA5-XHae8U6YtDH_2r_XMaR5A@mail.gmail.com>
 <58E639E0.1010700@iogearbox.net>
 <CAHgaXdK1XjDnhTqtk=nCq2crrigHiuCaLhF+1GupJt9bPThwZw@mail.gmail.com>
 <20170506.143816.2259768618578706384.davem@davemloft.net>
Message-ID: <CAHgaXd+2vF=d5zpWTg+a=vSnv2ZA+8LCR_MXT_MDKn4r2s8sig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks David.

Hi all,

I have two questions about the code at arch/arm64/net/bpf_jit_comp.c.

1. At line 708, " const u8 r1 = bpf2a64[BPF_REG_1]; /* r1: struct
sk_buff *skb */ ".
    Why is this code using BPF_REG_1 before saving it? As far as I
know, BPF_REG_1 has pointer to bpf program context and this code
clearly is overwriting that pointer which makes that pointer useless
for future usage. It clearly looks like a bug.

2. At line 256, " emit(A64_LDR64(prg, tmp, r3), ctx); ".
    This line of code is used to load an array( of pointers ) element,
where r3 is used as an index of that array. Shouldn't it be be
arithmetic left shifted by 3 or multiplied by 8 to get the right
address in that array of pointers ?

Apologies if any of the above question is stupid to ask.

Best,
Shubham
Best,
Shubham Bansal


On Sun, May 7, 2017 at 12:08 AM, David Miller <davem@davemloft.net> wrote:
> From: Shubham Bansal <illusionist.neo@gmail.com>
> Date: Sat, 6 May 2017 22:18:16 +0530
>
>> Hi Daniel,
>>
>> Thanks for the last reply about the testing of eBPF JIT.
>>
>> I have one issue though, I am not able to find what BPF_ABS and
>> BPF_IND instruction does exactly.
>
> They are not instructions, they are modifiers for the BPF_LD
> instruction which indicate an SKB load is to be performed.
>
> You never need to ask what a BPF instruction does, it is clear
> defined in the BPF interperter found in kernel/bpf/core.c
>
> Look for the case statement LD_ABS_W and friends in __bpf_prog_run().
