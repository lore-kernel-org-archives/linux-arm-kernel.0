From: cj.chengjian@huawei.com (chengjian (D))
Date: Tue, 17 Oct 2017 10:04:00 +0800
Subject: A issue about ptrace/SINGLESTEP on arm64
In-Reply-To: <20171016153055.GD10500@arm.com>
References: <8ad32f6b-e04d-98f8-d944-7ec3582fbdf4@huawei.com>
 <20171016153055.GD10500@arm.com>
Message-ID: <d8b5e71d-f8db-bee0-dadf-c57724a68daa@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/10/16 23:30, Will Deacon wrote:
> Can you jump the PC once the child appears to be "stuck"?
>
> IIRC, GDB has special heuristics to step through LDXR/STXR critical
> sections.
The function can be returned, But the number of instructions looks too much
We use objdump to count the assembly code length of the program

#=======
#trace
#=======
ptrace/2-arm64-loop # objdump -d ./nop | wc -l
     115885


ptrace/2-arm64-loop # ./ptrace_singlestep ./nop

     ./nop : nop
     Please wait
     Number of machine instructions : 186688022


/ptrace/2-arm64-loop # ./ptrace_singlestep ./nop

     ./nop : nop
     Please wait
     Number of machine instructions : 103670668


The number of instructions executed twice is not the same

#=======
#trace ls
#=======

ptrace/2-arm64-loop # objdump -d /bin/ls | wc -l
     18095

ptrace/2-arm64-loop # ./ptrace_singlestep /bin/ls
     /bin/ls : ls
     Please wait
     Number of machine instructions : 7718122167


It seems that the child has also been tracked by the parent process
when it goes into the kernel space.

Is this what your 'stuck' mean?
Does all the instructions been tracked in kernel space, or only the 
LDXR/STXR?
