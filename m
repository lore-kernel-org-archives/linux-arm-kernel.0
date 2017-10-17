From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Oct 2017 10:23:00 +0100
Subject: A issue about ptrace/SINGLESTEP on arm64
In-Reply-To: <d8b5e71d-f8db-bee0-dadf-c57724a68daa@huawei.com>
References: <8ad32f6b-e04d-98f8-d944-7ec3582fbdf4@huawei.com>
 <20171016153055.GD10500@arm.com>
 <d8b5e71d-f8db-bee0-dadf-c57724a68daa@huawei.com>
Message-ID: <20171017092259.GA21398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 10:04:00AM +0800, chengjian (D) wrote:
> On 2017/10/16 23:30, Will Deacon wrote:
> >Can you jump the PC once the child appears to be "stuck"?
> >
> >IIRC, GDB has special heuristics to step through LDXR/STXR critical
> >sections.
> The function can be returned, But the number of instructions looks too much
> We use objdump to count the assembly code length of the program
> 
> #=======
> #trace
> #=======
> ptrace/2-arm64-loop # objdump -d ./nop | wc -l
>     115885
> 
> 
> ptrace/2-arm64-loop # ./ptrace_singlestep ./nop
> 
>     ./nop : nop
>     Please wait
>     Number of machine instructions : 186688022
> 
> 
> /ptrace/2-arm64-loop # ./ptrace_singlestep ./nop
> 
>     ./nop : nop
>     Please wait
>     Number of machine instructions : 103670668
> 
> 
> The number of instructions executed twice is not the same

What is "nop"? What does perf stat say? Does is "ptrace_singlestep"
reporting the number of instructions? Is it a periodic dump, or does it
actually wait for program termination?

> #=======
> #trace ls
> #=======
> 
> ptrace/2-arm64-loop # objdump -d /bin/ls | wc -l
>     18095
> 
> ptrace/2-arm64-loop # ./ptrace_singlestep /bin/ls
>     /bin/ls : ls
>     Please wait
>     Number of machine instructions : 7718122167

I don't really know where to start here. The dynamic execution of a binary
includes branches, loops, libraries etc so of course the dynamic instruction
count is different to the static count of the binary.

> It seems that the child has also been tracked by the parent process
> when it goes into the kernel space.

Ptrace single-step shouldn't step into the kernel.

> Is this what your 'stuck' mean?
> Does all the instructions been tracked in kernel space, or only the
> LDXR/STXR?

Sorry, I don't understand what you're asking here.

Will
