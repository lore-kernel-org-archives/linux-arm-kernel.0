From: olivier.schonken@gmail.com (Olivier Schonken)
Date: Mon, 4 Jul 2016 11:08:42 +0200
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2: add ETM, ETB and ETMCK node
In-Reply-To: <20160704110018.76288816@bbrezillon>
References: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
 <1467383831-6985-2-git-send-email-olivier.schonken@gmail.com>
 <20160701183248.GC2874@piout.net>
 <CALdGsk+KwPMVKXhKtcmoUFqfj6aQRvQSY74F31fSvZhV+QvjAA@mail.gmail.com>
 <20160702204608.257b8bc6@bbrezillon>
 <CALdGsk+RO_cxfcTLVyKHP3aVMkSTtzEzQXz2G4ARX7vqxRazSA@mail.gmail.com>
 <20160704110018.76288816@bbrezillon>
Message-ID: <CALdGsk+rSYukvo6-zqgqNTwJnf8QXu2bCSAdurpg1=BVtENZvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That is the dilemma I face with the structure.  What is the least
invasive option to include the coresight functionality, without
breaking the amba probe for other architectures that rely on it having
a clock to enable/disable, and not break the processor startup by
messing with stable clocks for the sake of giving the ETB/ETM a clock
it doesn't need.
That is why in the end I decided on a dummy clock driver.  To keep
with the convention of having a clock specific to the ETM, and leaving
the rest of the clocks as is.

Regards

Olivier

On 4 July 2016 at 11:00, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Mon, 4 Jul 2016 10:47:21 +0200
> Olivier Schonken <olivier.schonken@gmail.com> wrote:
>
>> Hi Boris
>>
>> The amba bus is probed after the PIT driver.
>
> So we clearly have a problem in there...
>
>> I have today found pck0 -
>> pck2 to work as well.  Would this be good enough to use?
>
> But why would we reference one of the programmable clock? AFAICT, the
> coresight-etb10 block does not depend on any of the programmable clock.
>
>>
>> Regards
>>
>> Olivier
>>
>> On 2 July 2016 at 20:46, Boris Brezillon <boris.brezillon@free-electrons.com
>> > wrote:
>>
>> > Hi Olivier,
>> >
>> > On Fri, 1 Jul 2016 22:07:53 +0200
>> > Olivier Schonken <olivier.schonken@gmail.com> wrote:
>> >
>> > > Hi Alexandre
>> > >
>> > > Resending this mail, the previous one was accidentally in html format,
>> > > thus rejected from the list.  My apologies.
>> > >
>> > > I did try a couple of options regarding the clock, mck included, but
>> > > it would then hang when probing occurs in drivers/amba/bus.c when the
>> > > clock gets disabled. The dummy clock solved this issue, but I'm open
>> > > to better suggestions.
>> >
>> > Hm, that's really weird. Is the AMBA bus driver probed before the PIT
>> > driver?
>> > Anyway, I agree that this dummy clock approach is not ideal. Could we
>> > make the apb_pclk clock optional in the AMBA bus driver?
>> >
>> > The other approach would be to have someone claim the mck clock before
>> > the AMBA bus driver, and keep it enabled.
>> >
>> > Regards,
>> >
>> > Boris
>> >
>
