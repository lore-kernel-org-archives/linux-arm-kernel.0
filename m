From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 22 Apr 2013 19:08:36 +0100
Subject: [PATCH] ARM: make cpu_init() notrace
In-Reply-To: <20130422140711.GI14496@n2100.arm.linux.org.uk>
References: <1366302046.3388.8.camel@linaro1.home>
 <20130422140711.GI14496@n2100.arm.linux.org.uk>
Message-ID: <1366654116.3989.16.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-22 at 15:07 +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 18, 2013 at 05:20:46PM +0100, Jon Medhurst (Tixy) wrote:
> > On resume from CPU power down any trace hooks enabled in cpu_init()
> > will get called before that function has done set_my_cpu_offset(),
> > so any use of per-cpu variables by trace hook code will cause bad
> > things to happen. Prevent this by marking the function notrace.
> > 
> > This fixes lockups/crashes seen when enabling function tracer on TC2
> > with the not yet mainlined cpuidle driver.
> 
> Looks sane.  Needs to go to the patch system though.  Not sure if it'll
> make 3.9 given its proximity (we're on -rc8).

Added as patch 7700/1. Don't think there is a big rush as the problem
has probably been there since 3.8 when commit 14318efb (implement
optimized percpu variable access) started using TPIDRPRW; which is
presumably lost over CPU power down.

-- 
Tixy
