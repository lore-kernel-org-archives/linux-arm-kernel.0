From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 5 Sep 2013 15:05:57 +0200
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <20130905124508.GE9696@mudshark.cambridge.arm.com>
References: <1378317854-25965-1-git-send-email-jean.pihet@linaro.org>
 <1378317854-25965-4-git-send-email-jean.pihet@linaro.org>
 <20130905124508.GE9696@mudshark.cambridge.arm.com>
Message-ID: <CAORVsuW-1koTMaSMgjagBz1aJ0AtvVRiM5gs3kwO2Fuvk+DhwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,


On Thu, Sep 5, 2013 at 2:45 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Jean,
>
> [adding Michael, since I know he was interested in this]
>
> On Wed, Sep 04, 2013 at 07:04:14PM +0100, Jean Pihet wrote:
>> On ARM the debug info is not present in the .eh_frame sections but
>> instead in .debug_frame.
>> Use libunwind to load and parse the debug info.
>
> How have you tested this? Regardless of whether or not I apply this patch, I
> get the same (broken/truncated) callchains for userspace in perf report.
Here are the commands I have been using:
 perf record -g dwarf -- <binary to profile>
 perf report --sort symbol --call-graph --stdio

>
> E.g. the following stupid program (built with -O0 -g):
>
> --->8
>
> void bar(void)
> {
>         int i;
>         for (i = 0; i < 1000000; ++i)
>                 asm volatile("nop" ::: "memory");
> }
>
> void foo(void)
> {
>         bar();
> }
>
>
> int main(void)
> {
>         foo();
>         return 0;
> }
>
> 8<---
>
> Gives me an incomplete callchain:
>
> # Overhead   Command      Shared Object                           Symbol
> # ........  ........  .................  ...............................
> #
>      0.00%  unwindme  unwindme           [.] bar
>             |
>             --- bar
I get the following with a simple stupid program with a long call chain:
     0.57%  stress_bt  stress_bt          [.] foo_115
            |
            --- foo_115
                foo_114
                foo_113
...
                foo_92
                bar
                doit
                main
                __libc_start_main

Things to check:
- compile the binaries and libraries with -g (-dbg flavor of libs are
usually ok),
- use -g dwarf in perf record


> This is the same with or without your patch.
>
> Will

Thanks for testing!
Jean

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
