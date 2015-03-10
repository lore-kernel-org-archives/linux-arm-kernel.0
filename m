From: eliad@wizery.com (Eliad Peller)
Date: Tue, 10 Mar 2015 16:31:33 +0200
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <2223973.a64rBcZvaA@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <20150309224929.GL5264@atomide.com>
 <CAB3XZEdS+mK1MiB7OWiehFGRBnUzJ84s3rFrCy3-YFYhL-BNWw@mail.gmail.com>
 <2223973.a64rBcZvaA@wuerfel>
Message-ID: <CAB3XZEftjwUGS_Kj2dCxYY1m82C+a1_=akbnG3_hLETCr+Dddg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 4:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 10 March 2015 13:00:19 Eliad Peller wrote:
>> On Tue, Mar 10, 2015 at 12:49 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > I was expecting you to remove all calls to legacy_init_wl12xx from this file,
>> >> > including the ones for wl12xx aside from the wl18xx ones you removed, but
>> >> > if that's enough to clean out the platform_data handling from the wlcore
>> >> > driver, it's good enough as a start.
>> >> not sure i'm following - can you elaborate?
>> >>
>> >> i'll summarize the way i see it. please correct me if i'm wrong.
>> >>
>> >> both wl18xx and wl12xx use the platform data to get the irq number.
>> >> wl12xx (only) also needs some additional clock definitions to be
>> >> passed. there's currently some issue with specifying some the of clock
>> >> sources, so i preferred starting only with (the simpler) wl18xx
>> >> bindings.
>> >>
>> >> for platforms with wl18xx, we can remove the pdata-quirk, as all the
>> >> data (i.e. irq) can be passed by the new DT bindings.
>> >> however, for platforms with wl12xx, we still need to pass the clock
>> >> definitions (along with the irq), so we have to keep
>> >> legacy_init_wl12xx for the time being (and that's also why we have to
>> >> currently keep the platform_data handling in the wlcore driver)
>> >>
>> >> do you have something else in mind?
>> >
>> > I think what Arnd is saying is we've now removed all the wl12xx using
>> > legacy platforms, so all of them can boot with just data from dts.
>
> Right, that was my idea.
>
>> I don't think that's the case (unless i'm missing something).
>> e.g. there's still pdata-quirk for "compulab,omap3-sbc-t3730" which
>> initializes wl12xx device.
>
> This one is just like the igep0030, as Tony was saying: the board
> boots from device tree already, so now that we have a binding for
> it, we can remove the wl12xx_set_platform_data() for it.
>
i think the wl12xx_set_platform_data() name created some confusion -
it is used to pass platform data for both wl12xx and wl18xx devices.
(this confusion is all around the wlcore driver as well, due to the
code evolution)

the binding i added is for wl18xx only (there is no wl12xx binding yet).
the remaining boards, AFAICT, have wl12xx (rather than wl18xx) cards.
so i don't see how we can remove these wl12xx_set_platform_data()
calls before we have wl12xx bindings in-place as well.

> Unfortunately, there is still one machine that uses a board file
> in combination with this wl12xx: da850-evm calls
> wl12xx_set_platform_data() from a legacy board file without DT.
>
ditto.

Eliad.
