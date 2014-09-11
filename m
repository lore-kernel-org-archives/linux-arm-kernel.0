From: zlim.lnx@gmail.com (Z Lim)
Date: Thu, 11 Sep 2014 07:59:03 -0700
Subject: [PATCH arm64-next] net: bpf: arm64: fix module memory leak when
 JIT image build fails
In-Reply-To: <20140911104513.GC6158@arm.com>
References: <1410428208-2446-1-git-send-email-dborkman@redhat.com>
 <20140911104513.GC6158@arm.com>
Message-ID: <CABg9mcsqyk5udznitb2=B-M4SjB=ptgV7Z+34zJXqEcP9ia4Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 3:45 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Sep 11, 2014 at 10:36:48AM +0100, Daniel Borkmann wrote:
>> On ARM64, when the BPF JIT compiler fills the JIT image body with
>> opcodes during translation of eBPF into ARM64 opcodes, we may fail
>> for several reasons during that phase: one being that we jump to
>> the notyet label for not yet supported eBPF instructions such as
>> BPF_ST. In that case we only free offsets, but not the actual
>> allocated target image where opcodes are being stored. Fix it by
>> calling module_free() on dismantle time in case of errors.
>>
>> Signed-off-by: Daniel Borkmann <dborkman@redhat.com>
>> Cc: Zi Shen Lim <zlim.lnx@gmail.com>
>> Cc: Alexei Starovoitov <ast@plumgrid.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  [ Compile-tested only. ]
>>
>>  arch/arm64/net/bpf_jit_comp.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 38c4296..7ae3354 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -651,8 +651,10 @@ void bpf_int_jit_compile(struct bpf_prog *prog)
>>       build_prologue(&ctx);
>>
>>       ctx.body_offset = ctx.idx;
>> -     if (build_body(&ctx))
>> +     if (build_body(&ctx)) {
>> +             module_free(NULL, ctx.image);
>>               goto out;
>> +     }
>>
>
> Looks good to me:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>

Same here:

    Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>

Thank you Daniel.

>
> Catalin, can you apply this on the for-next/core branch, please?
>
> Will
