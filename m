From: anfei.zhou@gmail.com (anfei)
Date: Mon, 18 Jan 2010 22:15:30 +0800
Subject: flush_dcache_page does too much?
In-Reply-To: <20100118140005.GD2695@n2100.arm.linux.org.uk>
References: <20100118131346.GA11589@desktop>
	<20100118133304.GA29645@n2100.arm.linux.org.uk>
	<20100118135431.GA12496@desktop>
	<20100118140005.GD2695@n2100.arm.linux.org.uk>
Message-ID: <20100118141530.GA13394@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 02:00:05PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 18, 2010 at 09:54:31PM +0800, anfei wrote:
> > Do you mean this implementation can ensure the coherence between write
> > and shared mmapings?  But it's easy to reproduce the alias problem by
> > this simple testcase (w/o error handler) on omap2430 with VIPT cache:
> 
> Your program doesn't do anything to identify any problem.  You don't
> even say _what_ problem you see with this program.
> 
Sorry for that.

> If you have a specific case which fails, please show the problem, please
> describe exactly the behaviour that you see, and what you expect to see.

The steps as these:
$ dd if=/dev/zero of=abc bs=4k count=1
$ ./a.out		# this program
$ xxd abc | head -1	# check the result

I want to see it's always 0x11111111 0x77777777 at the beginning of file
"abc",  but the result is not (the log is not at hand currently), but I
remember it like this after several runs:

0x11111111 0x77777777
0x44444444 0x77777777
0x11111111 0x77777777
0x44444444 0x77777777
0x44444444 0x77777777

If I add munmap()/msync() before write(), I can see it always as
expected (0x11111111 0x77777777).
