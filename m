From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 15:02:26 +0100
Subject: [PATCH 11/19] clk: samsung: exynos5433: Add clocks for
 CMU_BUS{0|1|2} domains
In-Reply-To: <CAGTfZH3KmwhJNFdmeWnujbbUbtLf5vSi6i2dbV62DeCtV7n4TQ@mail.gmail.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <2232281.fbydzq3GMs@wuerfel>
 <CAGTfZH3KmwhJNFdmeWnujbbUbtLf5vSi6i2dbV62DeCtV7n4TQ@mail.gmail.com>
Message-ID: <2120788.f3P3CC6nYQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 22:41:49 Chanwoo Choi wrote:
> 2014? 11? 27? ???, Arnd Bergmann<arnd@arndb.de>?? ??? ???:
> 
> > On Thursday 27 November 2014 21:58:53 Chanwoo Choi wrote:
> > > Dear Arnd,
> > >
> > > On 11/27/2014 09:35 PM, Arnd Bergmann wrote:
> > > > On Thursday 27 November 2014 13:12:08 Sylwester Nawrocki wrote:
> > > >> On 27/11/14 12:56, Chanwoo Choi wrote:
> > > >>> On 11/27/2014 08:41 PM, Arnd Bergmann wrote:
> > > >>>>> On Thursday 27 November 2014 16:35:08 Chanwoo Choi wrote:
> > > >>>>>>> +  - "samsung,exynos5433-cmu-bus0", "samsung,exynos5433-cmu-bus1"
> > > >>>>>>> +    and "samsung,exynos5433-cmu-bus2" - clock controller
> > compatible for CMU_BUS
> > > >>>>>>> +    which generates global data buses clock and global
> > peripheral buses clock.
> > > >>>>>>>
> > > >>>>>>>  - reg: physical base address of the controller and length of
> > memory mapped
> > > >>>>>>>    region.
> > > >>>>>>>
> > > >>>>>
> > > >>>>> This looks like you are duplicating the bindings and the code, but
> > > >>>>> it's really the same hardware multiple times with minor variations
> > > >>>>> that you should be able to describe properly here. Why not make
> > > >>>>> three nodes with the same compatible string and have them handled
> > > >>>>> by the same code?
> > > >>>
> > > >>> Each CMU_BUSx domain of Exynos5433 have different base address as
> > following:
> > > >>> - CMU_BUS0's base address and range : 0x1360_0000 ~ 0x1360_0b04
> > > >>> - CMU_BUS1's base address and range : 0x1480_0000 ~ 0x1480_0b04
> > > >>> - CMU_BUS2's base address and range : 0x1340_0000 ~ 0x1340_0b04
> > > >>>
> > > >>> So, I implement CMU_BUSx domain which has each compatible string.
> > > >
> > > > But the base address is in the reg property, not in the compatible
> > > > property. What I mean is to have multiple nodes like
> > >
> > > The merged clock driver in mainline have different compatible string
> > > if base addresss of clock domain is different. So, I implemented each
> > CMU_BUSx domain
> > > with different compatible string.
> >
> > Why?
> 
> 
> As I explained on below, each clock domain have different clocks.
> So, clocks have unique clock name.
> 
>  If clock driver use only one compatible for various clock domain, clock
> driver have to know the base address of each domain for distinction of
> clock domain. I think It is stong dependency between device and driver.

No, not at all. You can have lots of clock controllers with the same
compatible string defining different instances of the same IP block,
e.g. for compatible="fixed-clock".

> >
> > > >     clock-controller at 113600000 {
> > > >             reg = <0 0x113600000 0 0x1000>;
> > > >             compatible = "samsung,exynos5433-cmu";
> > > >             #clock-cells = <1>;
> > > >     };
> > > >
> > > >     clock-controller at 114800000 {
> > > >             reg = <0 0x114800000 0 0x1000>;
> > > >             compatible = "samsung,exynos5433-cmu";
> > > >             #clock-cells = <1>;
> > > >     };
> > > >
> > > > The code will just map the local registers for each instance and then
> > > > provide the clocks of the right instance when asked for it.
> > >
> > > Each clock domain has not the same mux/divider/clock. So, just one
> > compatible
> > > string could not support all of clock domains.
> >
> > What are the specific differences?
> 
> 
> 
> > I'm not sure that difference among clock domains because I think it is
> dependent on the opinion of architect of SoC.
> 
> cmu_bus0/1/2 are much similar. Just cmu_bus2 has one more mux/gate clock
> than cmu_bus0/1.

Yes, that's what I mean. You can simply model that extra mux/gate
in the driver, as long as nothing ever tries to access the clock.

	Arnd
