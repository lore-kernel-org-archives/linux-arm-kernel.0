From: teawater@gmail.com (Hui Zhu)
Date: Tue, 5 Jan 2010 17:04:07 +0800
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <4B4273D6.2010306@kernel.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<4B411F14.1040302@kernel.org> <20100103150134.5bdab023@infradead.org>
	<4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org>
	<daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
	<4B4273D6.2010306@kernel.org>
Message-ID: <daef60381001050104u5d4adf11k16bec2406501fbd2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I agree with read the current stack message is better.

About the extending, I have some question with it:
1.  markup_oops.pl have itself idea, it try use dmesg| markup_oops.pl
show what happen to usr.  This is different with s2c.
I am not sure people like it have other function with it.  Too much
part of this file need to be change.  It need rewrite, just the oops
message parse part can be keep.

2.  I use perl to work in a long time before, I know it good at parse
the text, but I am not sure it good at handle struct like:
struct mips64_elf_prstatus
{
	struct s2c_elf_siginfo	pr_info;
	uint16_t		pr_cursig;
	uint64_t		pr_sigpend;
	uint64_t		pr_sighold;
	uint32_t		pr_pid;
	uint32_t		pr_ppid;
	uint32_t		pr_pgrp;
	uint32_t		pr_sid;
	struct s2c_timeval_64	pr_utime;
	struct s2c_timeval_64	pr_stime;
	struct s2c_timeval_64	pr_cutime;
	struct s2c_timeval_64	pr_cstime;

	uint64_t		pr_reg[45];

	uint32_t		pr_fpvalid;
} __attribute__ ((aligned(8)));
Even if what happen, I will keep a c s2c with myself.  :)

Best regards,
Hui

On Tue, Jan 5, 2010 at 07:03, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 01/05/2010 01:22 AM, Hui Zhu wrote:
>> For the s2c, user just "s2c < message >core" It did everything with itself.
>> After that, gdb vmlinux core.
>
> It is true that by making the kernel oops message more verbose, s2c
> can be made way simpler. ?However, dependence on standard object tools
> or perl is already assumed and avoiding it doesn't really buy
> anything. ?I really like the idea but unfortunately I'm doubtful that
> it will be able to go upstream in the current form. ?The suggested
> solution (extending markup_oops.pl) won't be too much work, most of
> functionality will remain the same and will have much higher chance of
> getting included.
>
> Thanks.
>
> --
> tejun
>
