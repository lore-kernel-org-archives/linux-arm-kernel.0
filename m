From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 13 Jun 2016 13:15:19 +0100
Subject: [PATCH 1/2] arm64: fix dump_instr when PAN and UAO are in use
In-Reply-To: <1465812915-19801-2-git-send-email-mark.rutland@arm.com>
References: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
 <1465812915-19801-2-git-send-email-mark.rutland@arm.com>
Message-ID: <575EA3D7.8040001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/16 11:15, Mark Rutland wrote:
> If the kernel is set to show unhandled signals, and a user task does not
> handle a SIGILL as a result of an instruction abort, we will attempt to
> log the offending instruction with dump_instr before killing the task.
> 
> We use dump_instr to log the encoding of the offending userspace
> instruction. However, dump_instr is also used to dump instructions from
> kernel space, and internally always switches to KERNEL_DS before dumping
> the instruction with get_user. When both PAN and UAO are in use, reading
> a user instruction via get_user while in KERNEL_DS will result in a
> permission fault, which leads to an Oops.
> 
> As we have regs corresponding to the context of the original instruction
> abort, we can inspect this and only flip to KERNEL_DS if the original
> abort was taken from the kernel, avoiding this issue. At the same time,
> remove the redundant (and incorrect) comments regarding the order
> dump_mem and dump_instr are called in.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 57f4959bad0a154a ("arm64: kernel: Add support for User Access Override")

FWIW:

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

with

$ echo 0 > /proc/sys/abi/swp

Removed swp emulation handler

$. /swp_test

$ cat swp_test.c

int main(void)
{
        unsigned long ret, x = 42, y = 24;

        asm volatile("swp     %0, %1, [%2]"
                     : "=&r" (ret)
                     : "r" (x), "r" (&y)
                     : "memory");

        return ret;
}

Thanks
Vladimir
