From: ccross@android.com (Colin Cross)
Date: Fri, 14 Nov 2014 14:06:59 -0800
Subject: [PATCH] ARM: b.L: fix unmet dependency for CPU_PM
In-Reply-To: <001401cfffd1$ae9df930$0bd9eb90$@samsung.com>
References: <1415857098-16928-1-git-send-email-pankaj.dubey@samsung.com>
 <alpine.LFD.2.11.1411131231060.11690@knanqh.ubzr>
 <20141113174837.GB4042@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1411131259330.11690@knanqh.ubzr>
 <001401cfffd1$ae9df930$0bd9eb90$@samsung.com>
Message-ID: <CAMbhsRT-H=6sXumPwhFHVufaDPNM=7rD=r_qQ0QGaF=zYseFiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:10 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> +CC: Colin Cross, James Hogan
>
> On Thursday, November 13, 2014 11:30 PM, Nicolas Pitre wrote:
>> To: Russell King - ARM Linux
>> Cc: Pankaj Dubey; linux-arm-kernel at lists.infradead.org; linux-
>> kernel at vger.kernel.org
>> Subject: Re: [PATCH] ARM: b.L: fix unmet dependency for CPU_PM
>>
>> On Thu, 13 Nov 2014, Russell King - ARM Linux wrote:
>>
>> > On Thu, Nov 13, 2014 at 12:44:22PM -0500, Nicolas Pitre wrote:
>> > > On Thu, 13 Nov 2014, Pankaj Dubey wrote:
>> > >
>> > > > If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
>> > > > we are getting following config warning.
>> > > >
>> > > > warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
>> > > > dependencies (SUSPEND || CPU_IDLE)
>> > > >
>> > > > So BL_SWITCHER should enable CPU_PM only if either of SUSPEND or
>> > > > CPU_IDLE is selected.
>> > > >
>> > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> > > > ---
>> > > >  arch/arm/Kconfig |    2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
>> > > > 9d580d0..fe3d969 100644
>> > > > --- a/arch/arm/Kconfig
>> > > > +++ b/arch/arm/Kconfig
>> > > > @@ -1417,7 +1417,7 @@ config BL_SWITCHER
>> > > >         bool "big.LITTLE switcher support"
>> > > >         depends on BIG_LITTLE && MCPM && HOTPLUG_CPU
>> > > >         select ARM_CPU_SUSPEND
>> > > > -       select CPU_PM
>> > > > +       select CPU_PM if (SUSPEND || CPU_IDLE)
>> > >
>> > > NAK.  You just broke the code by doing this. CPU_PM is a requirement
>> > > here.  The dependencies for CPU_PM is lacking.
>> >
>
> OK, got it. Even though compilation worked, but as you mentioned by doing
> this way
> bL_switcher functionality may broke.
>
>> > Is there any real technical reason that CPU_PM depends on SUSPEND ||
>> > CPU_IDLE ?  If not, those dependencies should be killed.
>>
>> Those dependencies look artificial to me.
>>
>
> For me also it looks like these dependencies are artificial.
> As far as I can see CONFIG_CPU_PM compiles following two files
> 1: kernel/cpu_pm.c - I can't see any dependency of SUSPEND or CPU_IDLE in
> this file.
> 2: arch/mips/kernel/pm.c: A quick look does not show any dependency of
> SUSPEND or
>    CPU_IDLE here too.
>
> So for me it looks like it is OK to kill these dependencies of CPU_PM.
> Still safer side I am CCing this to author of these files for confirmation.
>
> Thanks,
> Pankaj Dubey
>>
>> Nicolas
>

I agree, the dependencies in kernel/power/Kconfig should be removed.
