From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jan 2014 15:17:49 +0000
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <3140612.0s75qS6VKb@wuerfel>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <52DCE790.6080809@linaro.org>
 <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
 <3140612.0s75qS6VKb@wuerfel>
Message-ID: <20140122151749.GA1519@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 02:56:05PM +0000, Arnd Bergmann wrote:
> On Wednesday 22 January 2014 11:46:16 Mark Rutland wrote:
> > On Mon, Jan 20, 2014 at 09:08:32AM +0000, Hanjun Guo wrote:
> > > On 2014-1-17 22:21, Arnd Bergmann wrote:
> > > > On Friday 17 January 2014, Hanjun Guo wrote:
> > > >>
> > > >> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > > >>
> > > >> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> > > >> name from the ACPI timer table is matched with all the registered
> > > >> timer controllers and matching initialisation routine is invoked.
> > > > 
> > > > I wouldn't anticipate this infrastructure to be required. Shouldn't all
> > > > ARMv8 machines have an architected timer?
> > > 
> > > I not sure of this, could anyone can give some guidance? if only arch
> > > timer is available for ARM64, this will make thing very simple.
> > 
> > All ARMv8 systems should have an architected timer.
> > 
> > However, they may also have other timers (e.g. global timers for use
> > when CPUs are in low power states and their local architected timers
> > aren't active).
> 
> But all other timers could be regular platform drivers I suppose. No
> need for special infrastructure for those.

Except for the fact that some timers / clocksources that we already have
in 32-bit land will likely be reused in 64-bit SoC designs. People will
want to use the same driver for both 32-bit and 64-bit kernels, and thus
we need CLOCKSOURCE_OF_DECLARE in 64-bit kernels.

Those platforms which will have ACPI will likely reuse existing timer IP
blocks, and will want to make minimal changes to the driver, which will
likely be using CLOCKSOURCE_OF_DECLARE. We can't change these to
platform drivers or we can break existing systems because the timers
will be registered too late.

I don't see how we can share drivers between 32-bit and 64-bit kernels
without sharing a common driver model, and I think it makes sense to
have some uniformity across drivers (i.e. always use
CLOCKSOURCE_*_DECLARE rather than sometimes using platform drivers).

Thanks,
Mark.
