From: york.sun@nxp.com (York Sun)
Date: Mon, 15 Jan 2018 16:19:09 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
References: <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
 <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
Message-ID: <VI1PR04MB20786DE6AE24D4BB555E87C69AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2018 06:32 AM, Borislav Petkov wrote:
> On Mon, Jan 15, 2018 at 02:21:54PM +0000, Mark Rutland wrote:
>> I'm not sure it's possible to cover all potential EDAC implementations
>> behind the same driver.
>>
>> If we need these drivers, they should be <cpuname>_edac or <soc>_edac.
> 
> Yuck, I wanted to avoid that...
> 
> Oh well, can we at least share the barebones design and exchange
> registers/DT only or is it more complicated than that?
> 

I have different plan on the driver. Since I don't get interrupt on
correctable errors, my thinking is to use dynamic polling interval. With
more correctable errors, the polling interval is decreased to a
threshold, then further action needs to be taken (at least I would raise
an error message). The idea is uncorrectable error proceeds from
increasing correctable errors. I would use per CPU data structure so we
know which core has increasing errors. For embedded system, we may
shutdown the core(s) with error to protect the system from critical
failure. Similarly but differently, L2 cache is shared on the same
cluster. We may have to shutdown the whole cluster if we have excessive
correctable errors. For server, it may simply shutdown. Of course the
decision is not made by the driver, but by RAS or other monitoring policy.

Any comment is welcomed.

York
