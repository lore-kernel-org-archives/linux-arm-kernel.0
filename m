From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 5 Jul 2018 09:46:31 +0200
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <20180705073120.GU17271@n2100.armlinux.org.uk>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <CALeDE9MykqKyk5hJKn2OxZx2USW76ySm8Wxsw3eVgxa2g7PKXg@mail.gmail.com>
 <fe05405a-c06d-d8fe-07fa-5840e498bb13@iogearbox.net>
 <CALeDE9OJomWstG+AcftR543WBi5Bo8ANQj3T-pOW3BfBNzB=uw@mail.gmail.com>
 <20180704234154.GT17271@n2100.armlinux.org.uk>
 <20180705073120.GU17271@n2100.armlinux.org.uk>
Message-ID: <965d9f3e-cc24-9d7b-6416-f6596ced8e86@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2018 09:31 AM, Russell King - ARM Linux wrote:
> On Thu, Jul 05, 2018 at 12:41:54AM +0100, Russell King - ARM Linux wrote:
>> Subject says offlist, but this isn't...
>>
>> On Wed, Jul 04, 2018 at 08:33:20AM +0100, Peter Robinson wrote:
>>> Sorry for the delay on this from my end. I noticed there was some bpf
>>> bits land in the last net fixes pull request landed Monday so I built
>>> a kernel with the JIT reenabled. It seems it's improved in that the
>>> completely dead no output boot has gone but the original problem that
>>> arrived in the merge window still persists:
>>>
>>> [   17.564142] note: systemd-udevd[194] exited with preempt_count 1
>>> [   17.592739] Unable to handle kernel NULL pointer dereference at
>>> virtual address 0000000c
>>> [   17.601002] pgd = (ptrval)
>>> [   17.603819] [0000000c] *pgd=00000000
>>> [   17.607487] Internal error: Oops: 805 [#10] SMP ARM
>>> [   17.612396] Modules linked in:
>>> [   17.615484] CPU: 0 PID: 195 Comm: systemd-udevd Tainted: G      D
>>>         4.18.0-0.rc3.git1.1.bpf1.fc29.armv7hl #1
>>> [   17.626056] Hardware name: Generic AM33XX (Flattened Device Tree)
>>> [   17.632198] PC is at sk_filter_trim_cap+0x218/0x2fc
>>> [   17.637102] LR is at   (null)
>>> [   17.640086] pc : [<c0ab03b4>]    lr : [<00000000>]    psr: 60000013
>>> [   17.646384] sp : cfe1dd48  ip : 00000000  fp : 00000000
>>> [   17.651635] r10: d837e000  r9 : d833be00  r8 : 00000000
>>> [   17.656887] r7 : 00000001  r6 : e003d000  r5 : 00000000  r4 : 00000000
>>> [   17.663447] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
>>> [   17.670009] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>> [   17.677180] Control: 10c5387d  Table: 8fe20019  DAC: 00000051
>>> [   17.682956] Process systemd-udevd (pid: 195, stack limit = 0x(ptrval))
>>> [   17.689518] Stack: (0xcfe1dd48 to 0xcfe1e000)
>>
>> Can you provide a full disassembly of sk_filter_trim_cap from vmlinux
>> (iow, annotated with its linked address) for the above dump please -
>> alternatively a new dump with matching disassembly.  Thanks.
> 
> Also probably a good idea to have bpf_jit_enable set to 2 to get a
> dump of the bpf program being run, which I think for your problem,
> you'll have to hack the kernel source to do that.

Agree, that would be good as well. You could use something like the below
to bail out to interpreter after JIT did the dump.

Dump will then land in kernel log which you could paste here.

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f6a62ae..d6a7dfd 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1844,6 +1844,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		/* there are 2 passes here */
 		bpf_jit_dump(prog->len, image_size, 2, ctx.target);

+	/* Defer to interpreter after dump. */
+	if (1) {
+		bpf_jit_binary_free(header);
+		prog = orig_prog;
+		goto out_imms;
+	}
+
 	bpf_jit_binary_lock_ro(header);
 	prog->bpf_func = (void *)ctx.target;
 	prog->jited = 1;
