From: teawater@gmail.com (Hui Zhu)
Date: Mon, 4 Jan 2010 00:55:04 +0800
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <20100103164414.GB21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<20100103160313.GA21156@n2100.arm.linux.org.uk>
	<daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
	<20100103164414.GB21156@n2100.arm.linux.org.uk>
Message-ID: <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I didn't give the user raw oopses.
I give him core file. When the kernel die, do we can get a core file now?


(gdb) bt
#0  0xc0008470 in kernel_init (unused=<value optimized out>)
  at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/init/main.c:916
#1  0xc0042660 in sys_waitid (which=<value optimized out>, upid=<value
optimized out>, infop=0x0, options=0, ru=0x14)
  at /home/teawater/kernel/arm_versatile_926ejs.glibc_std.standard/build/linux/kernel/exit.c:1798
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

It show which line make kernel die.

Hui




On Mon, Jan 4, 2010 at 00:44, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 04, 2010 at 12:30:20AM +0800, Hui Zhu wrote:
>> This S2C: message just for program s2c.
>> s2c can convert it to a core file. ?Then gdb can do a clear analyse
>> with this file.
>> Then you can get more message than current we can get.
>
> I understand that. ?What I'm saying is that all the additional noise
> you're causing the kernel to create is just a pure duplication of
> what we already dump.
>
> Oops dumps are already noisy enough - especially if they cause a panic
> at the end (where you end up with two backtraces.) ?We do not need even
> more noise caused by needless duplication.
>
> You can get everything you need already from the kernel. ?On ARM, we
> already dump out all the registers and the _full_ stack. ?There is no
> need for you to implement your own register dumping code and full stack
> dump on top of that again.
>
> So, I'm not going to accept your patch for the ARM kernel. ?Please use
> what's already provided - it's more than adequate. ?By doing so, you
> don't penalise those of us who want to read the raw oopses.
>
> Talking about noisy oopses, I'm getting one with 2.6.33-rc2 on 'poweroff'
> shutdown. ?No idea what it is because most of it's scrolled off the top of
> the screen and I can't scroll back. ?Not bothered about it at the moment.
> What it does illustrate though is why making things too noisy when problems
> occur makes it _more_ difficult to find out what went wrong.
>
