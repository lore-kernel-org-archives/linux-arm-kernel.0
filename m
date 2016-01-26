From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Jan 2016 11:03:59 +0000
Subject: Unhandled level 2 translation fault on A72 board.
In-Reply-To: <56A72246.4050105@huawei.com>
References: <56A72246.4050105@huawei.com>
Message-ID: <20160126110358.GA23579@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:37:42PM +0800, Ding Tianhong wrote:
> I met this problem when running the hackbench test on A72 chip board:
> 
> sh[4779]: unhandled level 2 translation fault (11) at 0x7f96be0c80, esr 0x83000006 
> pgd = ffffffc01a1f0000 
> [7f96be0c80] *pgd=0000000084a20003, *pud=0000000084a20003, *pmd=0000000000000000
> 
> CPU: 1 PID: 4779 Comm: sh Tainted: G O 4.1.15+ #21 
> Hardware name: Hisilicon PhosphorHi1382 EVB (DT) 
> task: ffffffc0163cc500 ti: ffffffc083abc000 task.ti: ffffffc083abc000 
> PC is at 0x7f96be0c80 
> LR is at 0x7fb2684eb4 
> pc : [<0000007f96be0c80>] lr : [<0000007fb2684eb4>] pstate: 60000000 

So here it's user space trying to execute from 0x7f96be0c80 (instruction
abort).

> sh[4963]: unhandled level 2 translation fault (11) at 0x00000000, esr 0x92000006
> pgd = ffffffc0180c6000 
> [00000000] *pgd=0000000015157003, *pud=0000000015157003, *pmd=0000000000000000 
> 
> CPU: 0 PID: 4963 Comm: sh Tainted: G O 4.1.15+ #21 
> Hardware name: Hisilicon PhosphorHi1382 EVB (DT) 
> task: ffffffc0163cb980 ti: ffffffc0840c8000 task.ti: ffffffc0840c8000 
> PC is at 0x42c0c8 
> LR is at 0x42c03c 
> pc : [<000000000042c0c8>] lr : [<000000000042c03c>] pstate: 80000000 

And here you have a null pointer dereference.

> if I run the benchmark only on the core which is in the same cluster,
> it looks fine and no error happened, but if I enable the core which in
> the different cluster, it will happened.
> 
> I remember that I met the same problem on the A57 and fix it by enable
> the [bit6] of the CPUECTLR_EL1 and enable MN, But this time, I enable
> the same setting and looks no effort, I have no idea about this
> problem, does A57 and A72 has so big difference on TLB?

I can't tell for sure it's a TLB issue. The kernel page table dump shows
*pmd being 0, so the fault is correctly called "level 2 translation
fault". It also seems that there is no vma at this address, hence the
kernel reports it as unhandled. It looks like data corruption which
could be caused by cache or TLB incoherence. Just make sure the
interconnect linking the two clusters is configured correctly by
_firmware_ before Linux starts.

-- 
Catalin
