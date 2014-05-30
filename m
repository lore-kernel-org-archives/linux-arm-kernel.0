From: chhotu.shiv@gmail.com (shiv prakash Agarwal)
Date: Fri, 30 May 2014 17:20:49 +0530
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <4799695.pjGjqc80tj@wuerfel>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <201405061718.54012.arnd@arndb.de>
 <1399389873.29530.3.camel@weser.hi.pengutronix.de>
 <4799695.pjGjqc80tj@wuerfel>
Message-ID: <CAHH3p5+rNiSLBBeL-coYroa62rxQJ6wjxTdkCcUtXzvvcAQkXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks all,

Finally we see that this hang occurs because some VDM is sent by this I210 card.
Why this card sends VDM? and how can we disable it?

On Tue, May 6, 2014 at 9:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 06 May 2014 17:24:33 Lucas Stach wrote:
>> Am Dienstag, den 06.05.2014, 17:18 +0200 schrieb Arnd Bergmann:
>> > On Monday 05 May 2014, Alexander Duyck wrote:
>> > > Glad to hear that this is working on your ARM platform as expected.
>> > >
>> > > I believe the issue Shiv is having is due to a problem with the specific
>> > > platform as the IGB device is reporting a Data Link Protocol error via
>> > > AER and I believe this is what is causing his platform issues.  On
>> > > enabling BME the device is likely signalling a Fatal Error message in
>> > > response to the DLP error.  The original error he was seeing was:
>> > >
>> > > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> >
>> > This isn't too uncommon. There are a couple of traditional PCI host drivers
>> > that register an imprecise external abort handler to catch this and
>> > then look at the host controller registers.
>> >
>> > Out of the pcie hosts, only drivers/pci/host/pci-imx6.c catches
>> > this error, but it then goes on to ignore it, not even printing
>> > a message about it.
>> >
>> I think this handler is mostly there to handle the imprecise external
>> abort happening on DW pcie IP if the bus scan tries to access an
>> non-existent device. That's why it silently ignores this error.
>
> That sounds rather dangerous, the driver should probably check for
> the particular condition it tries to avoid and print a debug message
> in that case, or halt the machine if finds any unknown error, to
> prevent propagation of incorrect data.
>
>         Arnd
