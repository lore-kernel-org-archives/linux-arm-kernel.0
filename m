From: york.sun@nxp.com (York Sun)
Date: Tue, 16 Jan 2018 00:16:53 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
References: <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
 <VI1PR04MB20786DE6AE24D4BB555E87C69AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115232321.ojo3lfvces2q2qhm@pd.tnic>
 <VI1PR04MB207883AE86B7685B9D9DE3029AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115235248.snzpl5cajfkudluw@pd.tnic>
Message-ID: <HE1PR04MB2073A1B12356DFE0253E64939AEA0@HE1PR04MB2073.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2018 03:52 PM, Borislav Petkov wrote:
> On Mon, Jan 15, 2018 at 11:28:14PM +0000, York Sun wrote:
>> It is generic ARM64 thing. I believe only SError interrupt is available.
> 
> So if it is, then I'd suggest you hammer out a proper design with the
> ARM folks.
> 
>> But SError can be caused by many reasons. For L1/L2 only uncorrectable
>> errors trigger SError. My first step is to deal with correctable errors
>> and to raise a flag somehow (Haven't think that through yet) when
>> excessive errors are reported. Next step I will deal with the
>> uncorrectable errors with interrupt.
> 
> You need to think of the use cases first and where it makes *sense* to
> do recovery actions and what those actions will be. In general make the
> system more resilient. Simply reporting some error numbers just for the
> sake of it, doesn't mean a whole lot.

The correctable errors are corrected, so no further action is needed.
The uncorrectable errors cannot be corrected. It is too bad we have
them. But that doesn't mean we should sit there and wait for the system
to fail. Further comments below.

> 
> And once you have those, figure out what kind of error info you need
> from the hardware in order to do those recovery actions.
> 
> From your other mail:
>> I have different plan on the driver. Since I don't get interrupt on
>> correctable errors, my thinking is to use dynamic polling interval. With
>> more correctable errors, the polling interval is decreased to a
>> threshold, then further action needs to be taken (at least I would raise
>> an error message). The idea is uncorrectable error proceeds from
>> increasing correctable errors.
> > Is that always the case? I wouldn't be so sure.

I don't have first hand experience. I was told some research showed the
uncorrectable errors happen after excessive correctable errors, while
the hardware degrades. If we are interested in preventing the
uncorrectable errors from happening, the only indicator we may have is
the trend of errors.

> 
>> I would use per CPU data structure so we know which core has
>> increasing errors. For embedded system, we may shutdown the core(s)
>> with error to protect the system from critical failure. Similarly but
>> differently, L2 cache is shared on the same cluster.
> 
> All this implies is that the cores are the most prone to generate
> errors. I wouldn't be so sure. This is almost never the case on x86, for
> example. The main "fun" there is DRAM. The cores almost never.

We already have DRAM EDAC driver. I believe CPU cache is unlikely to
have errors. But when the error happens, it's better to know. I am doing
this L1/L2 cache EDAC driver because we have customer showing interest.
Honestly neither we nor our customer know what can be done at this moment.

> 
> So think about first which hw component really needs RAS protection and
> why exactly.
> 
>> We may have to shutdown the whole cluster if we have excessive
>> correctable errors.
> 
> Why?

L2 cache is shared by all cores on the same cluster. I don't think it is
a good idea to turn off cache on the affected cores. Powering off those
cores (consequently powering off the cluster) may run the system longer
until a replacement can be deployed.

> 
> Correctable errors are normally corrected by hardware and they don't
> have any effect on system state. Why shut down?

If we see increasing correctable errors, it may be a sign that
uncorrectable errors is just around the corner. Again, it is based on
the same theory above.

> 
> You probably want to slow down operation or do some other actions to
> improve the situation first. Immediately shutting down is not really
> RAS.
> 
>> For server, it may simply shutdown.
> 
> This is not really gracefully handling of errors.
> 
> You need to gradually diminish system performance to alleviate error
> levels and if that doesn't work, then warn and shutdown.

Like I said, the decision shouldn't be made by the EDAC driver. It only
reports the errors. Further action can be taken by monitoring software.

> 
>> Of course the decision is not made by the driver, but by RAS or other
>> monitoring policy.
> 
> Just read up on RAS strategies and policies to get a better idea what
> others are doing before implementing something which might not bring a
> whole lot.
> 

Agree. I am new on this topic even I am not new to Linux driver.

York
