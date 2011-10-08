From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 13:14:06 +0200
Subject: Question about "Inconsistent kallsyms data"
In-Reply-To: <CAMPhdO80ua0WphKnx3nyBLN7LsUDnDKPX1QbzWEjjfO5t3Uz5Q@mail.gmail.com>
References: <02ae01cc4d91$aed71670$0c854350$%kim@samsung.com>
	<4E382602.6050308@grupopie.com>
	<CAMPhdO80ua0WphKnx3nyBLN7LsUDnDKPX1QbzWEjjfO5t3Uz5Q@mail.gmail.com>
Message-ID: <8197014.WsynFjtK5s@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 October 2011 18:17:49 Eric Miao wrote:
> >
> > To check inconsistencies, the Makefile compares ".tmp_System.map" and
> > "System.map" for differences.
> >
> > On a normal build they should be identical, but if this fails with
> > "Inconsistent kallsyms data" you could try comparing the two files to
> > check which symbols are causing trouble.
> 
> I met this issue today as well. Didn't have a chance to compare the
> files, as I did a 'rm -fr ../build' and reconfigured/re-built everything,
> and 'make O=../build clean' didn't work for me.

I can easily reproduce it here, but it's extremely hard to nail
down what is actually going on.

For all I know, this depends on the specific configuration, source
version and gcc version. If you change any of these in any meaningful
way, the problem can go away or reappear. In one case, I've been
able to get to the point where inserting a single 'nop' instruction
in one (any) source file triggered the problem. This happens to be
the point when one of the linker sections grows beyond some power-of-two
boundary.

If anyone wants to reproduce it, I can recommend taking a fast machine
and the for-next+randconfig branch of git://git.linaro.org/people/arnd/arm-soc.git
There is a script called randconfig.sh in it. Remove the KALLSYMS_EXTRA_PASS=1
line from it and run it for some time. After a few hours you will get
multiple configurations for your compiler that show the problem.

I've had one case where even with KALLSYMS_EXTRA_PASS=1 I was still getting
inconsistent kallsyms data. Manually changing the Makefile to do a fourth
run fixed it.

	Arnd
