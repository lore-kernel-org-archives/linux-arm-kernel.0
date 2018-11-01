From: keescook@chromium.org (Kees Cook)
Date: Thu, 1 Nov 2018 13:53:35 -0700
Subject: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
In-Reply-To: <20181101234102.5fd16894fefffe18fccd6999@kernel.org>
References: <20181022093023.GA8920@beast>
 <cbeccaf1-33ec-0e54-0cfa-8cff81bbc1cd@redhat.com>
 <20181101234102.5fd16894fefffe18fccd6999@kernel.org>
Message-ID: <CAGXu5jJ-LQeFw+=5QoVW581TsUx2axCv6OCduWff69V2Fcp7Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 7:41 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Tue, 30 Oct 2018 13:40:27 -0400
> William Cohen <wcohen@redhat.com> wrote:
>
>> On 10/22/18 5:30 AM, Kees Cook wrote:
>> > The arm compiler internally interprets an inline assembly label
>> > as an unsigned long value, not a pointer. As a result, under
>> > CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
>> > of a label is 4 bytes, which was tripping the runtime checks. Instead,
>> > we can just cast the label (as done with the size calculations earlier)
>> > to avoid the problem.
>> >
>> > Reported-by: William Cohen <wcohen@redhat.com>
>> > Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
>> > Cc: stable at vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> >  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
>> > index b2aa9b32bff2..2c118a6ab358 100644
>> > --- a/arch/arm/probes/kprobes/opt-arm.c
>> > +++ b/arch/arm/probes/kprobes/opt-arm.c
>> > @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>> >     }
>> >
>> >     /* Copy arch-dep-instance from template. */
>> > -   memcpy(code, &optprobe_template_entry,
>> > +   memcpy(code, (unsigned char *)optprobe_template_entry,
>> >                     TMPL_END_IDX * sizeof(kprobe_opcode_t));
>> >
>> >     /* Adjust buffer according to instruction. */
>> >
>>
>> The patch fixes the issue for kretprobes.  It looks good to me.
>
> This looks good to me too. Thank you for finding and fixing it :)
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> Thanks!

Thanks for acks and testing. I've tossed this at the arm patch tracker:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8806/1

-- 
Kees Cook
