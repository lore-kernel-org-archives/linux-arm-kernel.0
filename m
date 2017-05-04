From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 4 May 2017 23:30:05 +0000
Subject: [PATCH v2] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
References: <1493508775.25397.26.camel@buserror.net>
 <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
 <1493932034.25397.37.camel@buserror.net>
Message-ID: <VI1PR04MB3216EC873ED7EB10F3D2CF9D86EA0@VI1PR04MB3216.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/4/2017 5:07 PM, Scott Wood wrote:
> On Thu, 2017-05-04 at 06:58 +0200, Karim Eshapa wrote:
>> +	stop = jiffies + 10000;
>> +	/*
>> +	 * if MR was full and h/w had other FQRNI entries to produce, we
>> +	 * need to allow it time to produce those entries once the
>> +	 * existing entries are consumed. A worst-case situation
>> +	 * (fully-loaded system) means h/w sequencers may have to do 3-4
>> +	 * other things before servicing the portal's MR pump, each of
>> +	 * which (if slow) may take ~50 qman cycles (which is ~200
>> +	 * processor cycles). So rounding up and then multiplying this
>> +	 * worst-case estimate by a factor of 10, just to be
>> +	 * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
>> +	 * one entry at a time, so h/w has an opportunity to produce new
>> +	 * entries well before the ring has been fully consumed, so
>> +	 * we're being *really* paranoid here.
>> +	 */
> OK, upon reading this more closely it seems the intent was to delay for 10,000
> *processor cycles* and somehow that got turned into 10,000 jiffies (which is
> 40 seconds at the default Hz!).  We could just replace this whole thing with
> msleep(1) and still be far more paranoid than was originally intended.
>
> Claudiu and Roy, any comments?
Yes the timing here is certainly off, the code changed a few times since
the comment was originally written.
An msleep(1) seems reasonable here to me.

Roy
>
> -Scott
>
>
