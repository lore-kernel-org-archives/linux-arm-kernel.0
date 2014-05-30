From: chhotu.shiv@gmail.com (shiv prakash Agarwal)
Date: Fri, 30 May 2014 23:32:34 +0530
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <5388BE1D.7040504@intel.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <201405061718.54012.arnd@arndb.de>
 <1399389873.29530.3.camel@weser.hi.pengutronix.de>
 <4799695.pjGjqc80tj@wuerfel>
 <CAHH3p5+rNiSLBBeL-coYroa62rxQJ6wjxTdkCcUtXzvvcAQkXQ@mail.gmail.com>
 <5388BE1D.7040504@intel.com>
Message-ID: <CAHH3p5+cR+AQRjxxA=AZN-P2yNSk9Qb6W0BjhAuFa7WPp38=DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VDM = Venodor Defined Message

On Fri, May 30, 2014 at 10:51 PM, Alexander Duyck
<alexander.h.duyck@intel.com> wrote:
> On 05/30/2014 04:50 AM, shiv prakash Agarwal wrote:
>> Thanks all,
>>
>> Finally we see that this hang occurs because some VDM is sent by this I210 card.
>> Why this card sends VDM? and how can we disable it?
>
>
> I'm not sure what you mean by VDM?  Are you referring to the AER error
> message that is sent by the part?  If so I believe this is being sent
> because the I210 is either misconfigured or because the platform is
> violating PCIe spec in some way that is triggering the device to send an
> error message.  Remember the key bit in all of this is the status of the
> device before you load the driver:
>
>>         Capabilities: [100 v2] Advanced Error Reporting
>>                 UESta:  DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>
> That DLP+ indicates an error occurred and that the device will send an
> error message as soon as the bus mastering is enabled.
>
> One thing I would recommend trying is clearing the UEsta and UESvrt bits
> so that they all read as 0, or - in the lspci dump.  Then you might try
> resetting the part via the sysfs reset control and verify that those
> bits are still cleared.  However at this point it seems like this
> platform you are running the part in has some PCIe issues and that is
> beyond the scope of what we can really debug from the driver and OS
> stack.  To resolve it you would likely need a PCIe protocol analyzer so
> you could see what the DLP error actually was.
>
> Thanks,
>
> Alex
>
>
>
