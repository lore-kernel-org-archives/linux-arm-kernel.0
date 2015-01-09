From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 09 Jan 2015 13:06:52 -0800
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1420706948.6075.17.camel@collabora.co.uk> (Sjoerd Simons's
 message of "Thu, 08 Jan 2015 09:49:08 +0100")
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <54AA48E6.3040404@samsung.com>
 <1420470469.15910.134.camel@collabora.co.uk>
 <69242715.30115.1420655868687.JavaMail.yahoo@jws10659.mail.bf1.yahoo.com>
 <1420670333.6075.2.camel@collabora.co.uk>
 <6203C077F070A646AA0FCB4B5F1795D248114CA6@sisaex01sj>
 <1420706948.6075.17.camel@collabora.co.uk>
Message-ID: <7hmw5rvf2r.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sjoerd Simons <sjoerd.simons@collabora.co.uk> writes:

> On Wed, 2015-01-07 at 23:49 +0000, Jonathan Stone -SISA wrote:
>> 
>> On On Wed, 2015-01-07 at 18:37 +0000, Sjoerd Simons writes wrote:
>> >On Wed, 2015-01-07 at 18:37 +0000, Anand Moon wrote:>
>> [...]
>> 
>> >> Only 4 core cpu's are on my board. Also CpuFreq is not working.
>> > 
>> > Can you share some point on this.
>> 
>> >The defconfig is using the bL switcher, which pairs up big and
>> > little cores to make them appear as one core.. So for 8 real
>> > cores, you'll get
>> >4 "virtual cores".
>> 
>> That configuration is appropriate for the 5420, which allegedly has
>> a hardware bug in the cache-coherence between the Cortex-A7 block
>> and the Cortex-A15 block.
>> Newer Exynos 5 SoCs -- 5422/5800, 5620, etc -- don't have that
>> bug. The scheduler should configured to do HMP on all 8 (or 6)
>> cores.
>> I don't have a 5410, but I assume it has the same bug as the 5420.
>
> Yes the kernel/scheduler could be configured like that, but
> exynos_defconfig turns on bL rather then HMP. 
>
> Now it's not unthinkable to add code/dts properties to select the
> right/preferred scheduling strategy depending on the board (HMP vs. bL).
> But proper HMP scheduling is still a work in progress in mainline 

Yes, HMP scheduling is not yet ready for mainline, which is why the
switcher is enabled by default.  If you turn the switcher off, you will
indeed get all 8 cores, but you may get some rather strange and
sub-optimal results with performance since from the scheduler
perspective, it will balance tasks across all 8 CPUs as if they were
identical.

> and iirc specifically on the XU3 there are open issue wrt. MCPM and
> its secure firmware. I've added Kevin to the CC as he's been working
> on this topic so should know the status a lot better then i do.

The broken firmware issues don't affect scheduling directly, but affect
the low-power states that are available to the kernel.  Since the
firwmware doesn't allow proper access to CCI, low-power states that
require MCPM are not available, which, among other things, means the
clusters can not be powered down.

>> The XU3 kernel supplied by HardKernel shows all 8 cores, and does HMP scheduling across all 8.
>
> Yes, that's independant of the dts though as mentioned above. Also there
> are still opne issues to booting up all cores on an XU3 afaik. See 
>    http://www.spinics.net/lists/linux-samsung-soc/msg39523.html

I haven't looked closely at the hardkernel tree to see what HMP
scheduling patches they're using, but it must be something out of tree.

Kevin
