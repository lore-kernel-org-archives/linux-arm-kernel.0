From: stsp@list.ru (Stas Sergeev)
Date: Tue, 10 Mar 2015 21:31:01 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150310173807.GU8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru> <20150310173807.GU8656@n2100.arm.linux.org.uk>
Message-ID: <54FF3865.8080301@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

10.03.2015 20:38, Russell King - ARM Linux ?????:
> On Tue, Mar 10, 2015 at 08:27:34PM +0300, Stas Sergeev wrote:
>> Please also find the same crash here:
>> http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003872.html
> Hmm, looks like from the exynos5420-arndale-octa failure in that, we
> don't dump the page table entries.  We should do.  Sorry about my
> previous mail.
>
> If you can reproduce this, please do so with this patch so that we
> can get the page table entries associated with the problem.  Thanks.
>
>  arch/arm/mm/fault.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index a982dc3190df..6333d9c17875 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -552,6 +552,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  
>  	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, fsr, addr);
> +	show_pte(current->mm, addr);
>  
>  	info.si_signo = inf->sig;
>  	info.si_errno = 0;
>
>
[    5.383283] Unhandled fault: external abort on non-linefetch (0x808)
at 0xf00d3018
[    5.390871] pgd = c0004000
[    5.393583] [f00d3018] *pgd=2d404811, *pte=efc1e65f, *ppte=efc1e45f
[    5.399901] Internal error: : 808 [#1] SMP ARM
[    5.404354] Modules linked in:
[    5.407427] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.0.0-rc2-00137-gb672c98-dirty #59
[    5.415536] Hardware name: Marvell Armada 370/XP (Device Tree)
[    5.421383] task: ed41e800 ti: ed43e000 task.ti: ed43e000
[    5.426798] PC is at _set_bit+0x28/0x50
[    5.430643] LR is at n_tty_set_termios+0x328/0x358
[    5.435446] pc : [<c01bc8f8>]    lr : [<c0207374>]    psr: 40000113
[    5.435446] sp : ed43fd00  ip : 00000000  fp : 00000000
[    5.446950] r10: 00000002  r9 : 00000000  r8 : ec975c00
[    5.452186] r7 : 00000000  r6 : f00d3018  r5 : f00d3000  r4 : ecd86200
[    5.458728] r3 : 00002000  r2 : 00002000  r1 : f00d3018  r0 : 00000000
[    5.465271] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[    5.472597] Control: 10c5387d  Table: 0000406a  DAC: 00000015
[    5.478355] Process swapper/0 (pid: 1, stack limit = 0xed43e220)
[    5.484376] Stack: (0xed43fd00 to 0xed440000)
[    5.488745] fd00: f00d3000 00000000 ecd86200 f00d5240 ec975c00
c0207448 c02073a4 ecd86200
[    5.496943] fd20: ecd8635c ec990dc0 00000000 c020b37c ecd86200
ec990dc0 ecd86200 c020bb40
[    5.505142] fd40: ed6dd400 ecd86200 00000000 ec975c00 00000000
c0205a28 ed022000 00000002
[    5.513341] fd60: 00000449 ecc89100 00000001 00500001 ed024590
c0205ff8 c00b81e4 ec975c00
[    5.521540] fd80: ed409c00 00000000 c06f0678 c04ee370 ed024590
ecc89100 c06f37cc 00000000
[    5.529739] fda0: ed022000 c06f37cc 00000000 c00b89dc ed43fe7c
00000000 ed43fe38 ecc89100
[    5.537938] fdc0: ed024590 ecc89108 c00b891c ed43fe7c 00000000
c00b2f40 00000000 ed43fec0
[    5.546137] fde0: ed43ff44 00000002 00000000 ed43fe7c 00000000
c00c0d88 ed679019 00766564
[    5.554336] fe00: 00000003 c00bea44 00000000 ecc89100 00000026
00000000 00000000 00000002
[    5.562535] fe20: 00000000 c004fa98 00000000 ed403f50 00000000
00000000 ed024590 ed0246d0
[    5.570734] fe40: 00000041 ecc89100 ed43fec0 ed43ff44 ed43fe7c
00000000 00000041 00000000
[    5.578932] fe60: 00000000 c00c1850 ed43fe8c 00000000 00000000
00000000 817b7a1a ed403f50
[    5.587131] fe80: ed022110 0000001a 00000013 00000000 00000007
ed43ff44 00000001 ed679000
[    5.595330] fea0: ffffff9c c0655588 c068f470 000000ab 00000000
c00c2780 00000041 00000000
[    5.603529] fec0: ed403f50 ed022110 0f4756ea 00000007 ed679019
00000000 00000000 ed0027f8
[    5.611727] fee0: ed024590 00000101 00000004 0000001e 00000000
00000000 00000000 00000002
[    5.619925] ff00: ed679000 00000fec 00000fec 00000001 00000002
00000002 ed679000 ffffff9c
[    5.628124] ff20: c06d0740 00000000 ed679000 ffffff9c c06d0740
c00b4050 00000000 00000000
[    5.636322] ff40: c05a7630 00000002 00000000 00000026 00000100
00000001 000000ab c06868a4
[    5.644521] ff60: 00000007 c0686884 c06d0740 c0655588 000000ab
c0655d68 00000007 00000007
[    5.652720] ff80: c0655588 beefdead 00000000 c04c6850 00000000
00000000 00000000 00000000
[    5.660918] ffa0: 00000000 c04c6858 00000000 c000e540 00000000
00000000 00000000 00000000
[    5.669117] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    5.677315] ffe0: 00000000 00000000 00000000 00000000 00000013
00000000 beefdead beefdead
[    5.685519] [<c01bc8f8>] (_set_bit) from [<c0207374>]
(n_tty_set_termios+0x328/0x358)
[    5.693371] [<c0207374>] (n_tty_set_termios) from [<c0207448>]
(n_tty_open+0xa4/0xcc)
[    5.701223] [<c0207448>] (n_tty_open) from [<c020b37c>]
(tty_ldisc_open+0x40/0x78)
[    5.708812] [<c020b37c>] (tty_ldisc_open) from [<c020bb40>]
(tty_ldisc_setup+0x18/0x58)
[    5.716838] [<c020bb40>] (tty_ldisc_setup) from [<c0205a28>]
(tty_init_dev+0x8c/0x17c)
[    5.724775] [<c0205a28>] (tty_init_dev) from [<c0205ff8>]
(tty_open+0x4e0/0x5f4)
[    5.732191] [<c0205ff8>] (tty_open) from [<c00b89dc>]
(chrdev_open+0xc0/0x17c)
[    5.739436] [<c00b89dc>] (chrdev_open) from [<c00b2f40>]
(do_dentry_open.isra.12+0xec/0x30c)
[    5.747899] [<c00b2f40>] (do_dentry_open.isra.12) from [<c00c0d88>]
(do_last.isra.37+0x128/0xb70)
[    5.756796] [<c00c0d88>] (do_last.isra.37) from [<c00c1850>]
(path_openat+0x80/0x578)
[    5.764647] [<c00c1850>] (path_openat) from [<c00c2780>]
(do_filp_open+0x2c/0x80)
[    5.772152] [<c00c2780>] (do_filp_open) from [<c00b4050>]
(do_sys_open+0x124/0x1d0)
[    5.779833] [<c00b4050>] (do_sys_open) from [<c0655d68>]
(kernel_init_freeable+0x134/0x1d4)
[    5.788209] [<c0655d68>] (kernel_init_freeable) from [<c04c6858>]
(kernel_init+0x8/0xe4)
[    5.796325] [<c04c6858>] (kernel_init) from [<c000e540>]
(ret_from_fork+0x14/0x34)
[    5.803915] Code: f591f000 e1a03312 e1912f9f e1822003 (e1810f92)
[    5.810023] ---[ end trace c74d97aefdd5e727 ]---
[    5.814696] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
