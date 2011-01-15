From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 17:08:29 +0000
Subject: [PATCH v2] ARM: pxa: PalmZ72: Add OV9640 camera support
In-Reply-To: <AANLkTimK=g3gbc913sz-nGV+gmJZsU3ESPWFP_7kQBMf@mail.gmail.com>
References: <1295054277-7879-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTimK=g3gbc913sz-nGV+gmJZsU3ESPWFP_7kQBMf@mail.gmail.com>
Message-ID: <20110115170829.GL15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 05:37:08PM +0100, Bj?rn Forsman wrote:
> Hi,
> 
> On 15 January 2011 02:17, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Rework of patch from 2009:
> > PalmZ72: Add support for OV9640 camera sensor
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> > v2: Use gpio_request_array()/gpio_free_array() array
> >
> > ?arch/arm/mach-pxa/include/mach/palmz72.h | ? ?5 +
> > ?arch/arm/mach-pxa/palmz72.c ? ? ? ? ? ? ?| ?127 ++++++++++++++++++++++++++++++
> > ?2 files changed, 132 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h b/arch/arm/mach-pxa/include/mach/palmz72.h
> > index 2bbcf70..0d4700a 100644
> > --- a/arch/arm/mach-pxa/include/mach/palmz72.h
> > +++ b/arch/arm/mach-pxa/include/mach/palmz72.h
> 
> [snip]
> 
> > +static int palmz72_camera_power(struct device *dev, int power)
> > +{
> > + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_PWDN, !power);
> > + ? ? ? mdelay(50);
> > + ? ? ? return 0;
> > +}
> > +
> > +static int palmz72_camera_reset(struct device *dev)
> > +{
> > + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 1);
> > + ? ? ? mdelay(50);
> > + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 0);
> > + ? ? ? mdelay(50);
> > + ? ? ? return 0;
> > +}
> 
> (Sorry if these are stupid newbie-questions.)
> 
> Is the entire kernel blocked during the above mdelay()s or
> just some kernel thread? (Or: will this add like 100ms or 150ms
> to boot time?)
> 
> Can mdelay() be replaced with something non-blocking?

mdelay() is a spinning delay - it doesn't voluntarily relinquish the
CPU to another task.

If you have preempt enabled and the region is preemptable, you can be
preempted in the middle of the delay (in which case it becomes delay
time + time away from the thread.)

msleep() can be used for places where you can sleep, but is limited to
the jiffy granularity for !HIRES kernels.
