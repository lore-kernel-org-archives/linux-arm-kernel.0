From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 29 Nov 2017 12:41:05 +0100
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <20171129112628.7ij3ce62vq65yiwa@lakrids.cambridge.arm.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
 <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
 <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
 <CACT4Y+YTeLeUPRF=nsJFn-1wXux+yWCcbjmdcVQQFhXHXdY9YQ@mail.gmail.com>
 <20171129112628.7ij3ce62vq65yiwa@lakrids.cambridge.arm.com>
Message-ID: <CACT4Y+Zs9g7KDqz7cp9A_5jCNkRc0dfoXfupFLFfn73p3X3=vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 12:26 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 28, 2017 at 06:52:32PM +0100, Dmitry Vyukov wrote:
>> On Tue, Nov 28, 2017 at 4:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>
>> >> ... it looks suspiciously like something is setting up non-zero shadow
>> >> bytes, but not zeroing them upon return.
>> >
>> > It looks like this is the case.
>> >
>> > The hack below detects leftover poison on an exception return *before*
>> > the false-positive warning (example splat at the end of the email). With
>> > scripts/Makefile.kasan hacked to not pass
>> > -fsanitize-address-use-after-scope, I see no leftover poison.
>> >
>> > Unfortunately, there's not enough information left to say where exactly
>> > that happened.
>
>> ASAN stack instrumentation actually contains information about frames.
>> I just never got around to using it in KASAN. But user-space ASAN
>> prints the following on stack bugs:
>>
>> Address 0x7ffdb1c75140 is located in stack of thread T0 at offset 64 in frame
>>     #0 0x527fff  in main test.c:5
>>
>>   This frame has 2 object(s):
>>     [32, 40) 'p'
>>     [64, 68) 'x' <== Memory access@offset 64 is inside this variable
>>
>> Function prologue contains code similar to this:
>>
>>   528062:       48 ba f0 7f 52 00 00    movabs $0x527ff0,%rdx
>>   52806c:       48 be 9c e5 53 00 00    movabs $0x53e59c,%rsi
>>   528076:       48 89 c7                mov    %rax,%rdi
>>   528079:       48 83 c7 20             add    $0x20,%rdi
>>   52807d:       49 89 c0                mov    %rax,%r8
>>   528080:       49 83 c0 40             add    $0x40,%r8
>>   528084:       48 c7 00 b3 8a b5 41    movq   $0x41b58ab3,(%rax)
>>   52808b:       48 89 70 08             mov    %rsi,0x8(%rax)
>>   52808f:       48 89 50 10             mov    %rdx,0x10(%rax)
>>
>> Here 0x41b58ab3 is marker of frame start, and after it 0x527ff0 and
>> 0x53e59c should be pointers to globals that contain function name and
>> other aux information. Note that's on stack itself, not in shadow.
>> If you can find any of 0x41b58ab3 in the corrupted part of stack, you
>> can figure out what function has left garbage.
>
> Thanks for the info! I'll try to give this a go, but I'm probably not
> going to have the chance to investigate much this week.
>
> I'm afraid I'm not that good at reading x86 assembly. IIUC there are
> records on the stack something like:
>
> struct record {
>         u64 magic; /* 0x41b58ab3 */
>         char *func_name;
>         struct aux *data;
> };
>
> ... is that correct?
>
> Is there any documentation on this that I can refer to?


I am not aware of any documentation other than code. I think the
simplest is AsanThread::GetStackFrameAccessByAddr() here:
http://llvm.org/viewvc/llvm-project/compiler-rt/trunk/lib/asan/asan_thread.cc?revision=310432&view=markup
It finds the struct with description from the bad access address.
Looking at the code, yes, there is magic, then char* frame
descriptions, and then PC where the frame was allocated (usually
function prologue, but I think can also point to an alloca).
