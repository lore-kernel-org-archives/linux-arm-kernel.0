From: js@sig21.net (Johannes Stezenbach)
Date: Mon, 5 Nov 2012 14:43:26 +0100
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121105130255.GD2005@linaro.org>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net>
 <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
 <20121105130255.GD2005@linaro.org>
Message-ID: <20121105134326.GA1040@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 01:02:55PM +0000, Dave Martin wrote:
> On Mon, Nov 05, 2012 at 11:13:46AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 05, 2012 at 10:48:50AM +0000, Dave Martin wrote:
> > > For v7, we should definitely use -munaligned-access where available
> > > (unless it's the default?)
> > 
> > No such option on my compiler - according to the manual I have, the only
> > option there is starting -munaligned is on SPARC for -munaligned-doubles.
> 
> OK, I guess that's something backported into the Linaro toolchain I'm
> currently using then.  But it seems a good idea to use this if available,
> because it allows the compiler to generate better code in some situations,
> especially for packed struct access.
>  
> > However, I believe GCC does believe that unaligned accesses are fine on
> > V6 and above.
> 
> Possibly, but I've never seen it use them deliberately, prior to the
> -munaligned-access support.

http://gcc.gnu.org/gcc-4.7/changes.html says -munaligned-access is
enabled by default.

I haven't had a chance to try gcc-4.7 yet, but gcc-4.6+linaro
has the option but fails to generate the expected code for ARMv6
while it works for ARMv7.  However it does

#define __ARM_FEATURE_UNALIGNED 1

and

        .eabi_attribute 34, 1

This seems to be the commit which introduced unaligned support in gcc:
http://repo.or.cz/w/official-gcc.git/commitdiff/eb04cafba3a6f1eddbdb5ec031d8a7074930d5b9
I cannot figure out why this works for v7 but not for v6.

(I used gcc-4.6.4 20121001 (prerelease) toolchain built with crosstool-NG.)


Johannes
