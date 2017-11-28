From: dvyukov@google.com (Dmitry Vyukov)
Date: Tue, 28 Nov 2017 18:52:32 +0100
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
 <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
 <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
Message-ID: <CACT4Y+YTeLeUPRF=nsJFn-1wXux+yWCcbjmdcVQQFhXHXdY9YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 4:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > > As a heads-up, I'm seeing a number of what appear to be false-positive
>> > > use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
>> > > when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
>> > > without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
>> > >
>> > > The reports vary depending on configuration even with the same trigger. I'm not
>> > > sure if it's the reporting that's misleading, or whether the detection is going
>> > > wrong.
>
>> ... it looks suspiciously like something is setting up non-zero shadow
>> bytes, but not zeroing them upon return.
>
> It looks like this is the case.
>
> The hack below detects leftover poison on an exception return *before*
> the false-positive warning (example splat at the end of the email). With
> scripts/Makefile.kasan hacked to not pass
> -fsanitize-address-use-after-scope, I see no leftover poison.
>
> Unfortunately, there's not enough information left to say where exactly
> that happened.
>
> Given the report that Andrey linked to [1], it looks like the compiler
> is doing something wrong, and failing to clear some poison in some
> cases. Dennis noted [2] that this appears to be the case where inline
> functions are called in a loop.
>
> It sounds like this is a general GCC 7.x problem, on both x86_64 and
> arm64. As we don't have a smoking gun, it's still possible that
> something else is corrupting the shadow, but it seems unlikely.



We use gcc 7.1 extensively on x86_64 and have not seen any problems.

ASAN stack instrumentation actually contains information about frames.
I just never got around to using it in KASAN. But user-space ASAN
prints the following on stack bugs:

Address 0x7ffdb1c75140 is located in stack of thread T0 at offset 64 in frame
    #0 0x527fff  in main test.c:5

  This frame has 2 object(s):
    [32, 40) 'p'
    [64, 68) 'x' <== Memory access@offset 64 is inside this variable

Function prologue contains code similar to this:

  528062:       48 ba f0 7f 52 00 00    movabs $0x527ff0,%rdx
  52806c:       48 be 9c e5 53 00 00    movabs $0x53e59c,%rsi
  528076:       48 89 c7                mov    %rax,%rdi
  528079:       48 83 c7 20             add    $0x20,%rdi
  52807d:       49 89 c0                mov    %rax,%r8
  528080:       49 83 c0 40             add    $0x40,%r8
  528084:       48 c7 00 b3 8a b5 41    movq   $0x41b58ab3,(%rax)
  52808b:       48 89 70 08             mov    %rsi,0x8(%rax)
  52808f:       48 89 50 10             mov    %rdx,0x10(%rax)

Here 0x41b58ab3 is marker of frame start, and after it 0x527ff0 and
0x53e59c should be pointers to globals that contain function name and
other aux information. Note that's on stack itself, not in shadow.
If you can find any of 0x41b58ab3 in the corrupted part of stack, you
can figure out what function has left garbage.

Ideally, we check that stack does not contain garbage in the beginning
of each function _before_ new asan frame is created. That would
increase chances of finding 0x41b58ab3 marked and pin pointing the
offending function. Unfortunately, I can't think of any existing
hook... wait, __fentry__ seems to be in the perfect place.
One of these global pointers after the mark is probably points to
struct kasan_global. I don't remember what's the other one.
