From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 02 Sep 2014 14:49:44 +0100
Subject: [PATCH v5 3/3] kprobes: arm: enable OPTPROBES for ARM 32
In-Reply-To: <1409144552-12751-4-git-send-email-wangnan0@huawei.com>
References: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>
 <1409144552-12751-4-git-send-email-wangnan0@huawei.com>
Message-ID: <1409665784.2873.49.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I gave the patches a quick test and in doing so found a bug which stops
any probes actually being optimised, and the same bug should affect X86,
see comment below...

On Wed, 2014-08-27 at 21:02 +0800, Wang Nan wrote:
[...]
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	u8 *buf;
> +	unsigned long rel_chk;
> +	unsigned long val;
> +
> +	if (!can_optimize(op))
> +		return -EILSEQ;
> +
> +	op->optinsn.insn = get_optinsn_slot();
> +	if (!op->optinsn.insn)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Verify if the address gap is in 32MiB range, because this uses
> +	 * a relative jump.
> +	 *
> +	 * kprobe opt use a 'b' instruction to branch to optinsn.insn.
> +	 * According to ARM manual, branch instruction is:
> +	 *
> +	 *   31  28 27           24 23             0
> +	 *  +------+---+---+---+---+----------------+
> +	 *  | cond | 1 | 0 | 1 | 0 |      imm24     |
> +	 *  +------+---+---+---+---+----------------+
> +	 *
> +	 * imm24 is a signed 24 bits integer. The real branch offset is computed
> +	 * by: imm32 = SignExtend(imm24:'00', 32);
> +	 *
> +	 * So the maximum forward branch should be:
> +	 *   (0x007fffff << 2) = 0x01fffffc =  0x1fffffc
> +	 * The maximum backword branch should be:
> +	 *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
> +	 *
> +	 * We can simply check (rel & 0xfe000003):
> +	 *  if rel is positive, (rel & 0xfe000000) shoule be 0
> +	 *  if rel is negitive, (rel & 0xfe000000) should be 0xfe000000
> +	 *  the last '3' is used for alignment checking.
> +	 */
> +	rel_chk = (unsigned long)((long)op->optinsn.insn -
> +			(long)op->kp.addr + 8) & 0xfe000003;

This check always fails because op->kp.addr is zero. Debugging this I
found that this function is called from alloc_aggr_kprobe() and that
copies the real kprobe into op->kp using copy_kprobe(), which doesn't
actually copy the 'addr' value...

        static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
        {
        	memcpy(&p->opcode, &ap->opcode, sizeof(kprobe_opcode_t));
        	memcpy(&p->ainsn, &ap->ainsn, sizeof(struct arch_specific_insn));
        }

Thing is, the new ARM code is a close copy of the existing X86 version
so that would also suffer the same problem of kp.addr always being zero.
So either I've miss understood something or this is fundamental bug no
one has noticed before.

Throwing in 'p->addr = ap->addr' into the copy_kprobe function fixed the
behaviour arch_prepare_optimized_kprobe.

I was testing this by running the kprobes tests
(CONFIG_ARM_KPROBES_TEST=y) and putting a few printk's in strategic
places in kprobes-opt.c to check to see what code paths got executed,
which is how I discovered the problem.

Two things to note when running kprobes tests...

1. On SMP systems it's very slow because of kprobe's use of stop_machine
for applying and removing probes, this forces the system to idle and
wait for the next scheduler tick for each probe change.

2. It's a good idea to enable VERBOSE in kprobes-test.h to get output
for each test case instruction, this reassures you things are
progressing and if things explode lets you know what instruction type
triggered it.

-- 
Tixy
