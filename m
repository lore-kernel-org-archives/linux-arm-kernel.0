From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 17 Dec 2013 19:03:01 -0800
Subject: [PATCH 1/3]: Support cpu frequency scaling and power management
 for iMX6SL
In-Reply-To: <20131218023808.GZ6691@S2101-09.ap.freescale.net>
References: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
 <CACUGKYN_b0x4xg_Me3TXQGKEvz61SDZk4CFk5YHFnVCWT_6GPg@mail.gmail.com>
 <52B09856.5050609@tqsc.de>
 <20131218023808.GZ6691@S2101-09.ap.freescale.net>
Message-ID: <CACUGKYP3u-nu8O2K6op_oSRKHn4ugLuaD2n5cBBJW5473tYVTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think that's the right way to do it. Follow the Freescale kernel to
set the operating-points.

On Tue, Dec 17, 2013 at 6:38 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 17, 2013 at 07:30:46PM +0100, Markus Niebel wrote:
>> >> @@ -38,6 +38,19 @@
>> >>                         device_type = "cpu";
>> >>                         reg = <0x0>;
>> >>                         next-level-cache = <&L2>;
>> >> +                       operating-points = <
>> >> +                               /* kHz    uV */
>> >> +                               1000000 1275000
>> >> +                               792000  1150000
>>
>> according to the CPU documentation the following operation points are suggested (at least AFAIK):
>>                                996000  1250000 /* for consumer grade only */
>>                                792000  1150000
>>                                396000  1050000
>> note: AFAIK there is no way to detect at runtime if we  running on industrial / automotive variant
>> so there is a risk to run at too high frequency ...
>
> I can only find IMX6SLCEC - i.MX 6SoloLite Applications Processors for
> Consumer Products on freescale website.
>
>  http://cache.freescale.com/files/32bit/doc/data_sheet/IMX6SLCEC.pdf?fpsp=1
>
> In that document, I can see the following in Table 9. Operating Ranges.
>
>  LDO output set at 1.250V minimum for operation up to 996MHz
>  LDO output set at 1.150V minimum for operation up to 792MHz
>  LDO output set at 0.95V minimum for operation up to 396MHz
>
> However, if you access Freescale 3.10 kernel tree, you will see there
> are 25mV addition to each operating-point.
>
>         operating-points = <
>                 /* kHz   uV */
>                 996000  1275000
>                 792000  1175000
>                 396000  975000
>         >;
>
> From the commit log, it said this 25mV is added to compensate the output
> tolerance from external regulators.
>
> I suggest we follow Freescale kernel to set the operating-points.
>
> Shawn
>
