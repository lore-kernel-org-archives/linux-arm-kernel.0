From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 21 Apr 2011 17:02:25 -0400 (EDT)
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110421201455.GA18083@redhat.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191655.13133.arnd@arndb.de>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
	<201104191801.19348.arnd@arndb.de>
	<20110419160545.GJ1765@opensource.wolfsonmicro.com>
	<20110421201455.GA18083@redhat.com>
Message-ID: <alpine.LFD.2.00.1104211629300.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Dave Jones wrote:

> On Tue, Apr 19, 2011 at 05:05:46PM +0100, Mark Brown wrote:
>  > On Tue, Apr 19, 2011 at 06:01:19PM +0200, Arnd Bergmann wrote:
>  > 
>  > > I think it would be good to have the out of the individual
>  > > platforms, in particular in order to get better reviews of
>  > > new cpufreq drivers by people that are interested in them.
>  > 
>  > FWIW when I pushed the S3C64x0 cpufreq driver into mainline I posted the
>  > driver to the cpufreq list and maintainers but never got any response
>  > from them.
> 
> Like I said in another mail, the platform-specific nature of cpufreq drivers
> means that the only people who can really review them are people familiar
> with the architecture. (modulo the cpufreq api bits, but it's usually
> either no-brainer stuff, or bugs that aren't immediately obvious from review,
> like some of the locking mistakes we've historically seen)

So what? Lots of drivers in drivers/ are used and even usable only on 
one architecture already.  Moving the cpufreq drivers from arch/* into 
drivers/cpufreq/ won't change the fact that only the people familiar 
with the target hardware will be able to properly review the details.  
This is no different for most kind of drivers.

> This is why I don't believe that moving this code from arch/ to drivers/
> will change anything.

That at least would have the property of gathering drivers together 
according to their _purpose_, irrespective of their implementation 
details.  That's the case for all the other class of drivers already. 
Why would cpufreq drivers be different?

> if there's commonality between some of the ARM arch drivers, why can't
> there be a arch/arm/cpufreq/ dir for the shared code, and do everything there ?

Because usually there isn't.  "ARM" is just a CPU architecture, not a 
system architecture.  Everything around the core is different from one 
vendor to the next.  And when commonality exists it is much easier to 
deal with if it is close together.

According to your argument, we would have to create arch/arm/net, 
arch/arm/alsa, arch/arm/video, etc, which no one would agree with.  Yet 
almost all those ARM related drivers are highly platform-specific.

The criteria for sorting out driver location is normally the driver's 
purpose, not the platform where it is used. Why would cpufreq have to be 
different?

> Right now "move it out of the arm tree into the cpufreq tree" just seems
> like a cop-out to hide the problem.

No, there is nothing to hide.  If there is a code duplication problem, 
it will be even more visible if that code is moved to a common place, 
and therefore any needed consolidation would happen more naturally.  I 
doubt anyone would try to copy a driver just to perform slight 
modifications on it if it is to land in the same directory as the 
original.


Nicolas
