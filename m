From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 14 Jun 2012 13:58:44 -0500
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
 <4FD9E5AF.6010201@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
Message-ID: <4FDA3464.4040704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/14/2012 08:32 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Thu, Jun 14, 2012 at 18:52:55, Hunter, Jon wrote:
>> On 06/14/2012 02:03 AM, Mohammed, Afzal wrote:
>>> On Wed, Jun 13, 2012 at 20:21:50, Hunter, Jon wrote:
> 
>>>> If the clk handle for the gpmc is passed to the gpmc driver, then there
>>>> is no reason why the driver cannot do this.
>>>
>>> I believe passing clk details through platform data is an abuse of
>>> clock framework.
>>
>> Why? You currently have a global variable storing the clock handle. It
>> can be quite common for drivers to know the clock frequencies of their
>> functional clocks. How else can drivers calculate timings?
> 
> 
> Please see Russell King's comments,
> 
> [1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/27634
> [2] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg05365.html

Thanks. So I still think you need to get rid of the global variable for
storing the gpmc fclk, that is really my point.

So if you look at commit [1] mentioned by Russell in the above thread,
the appropriate thing to do would be to create a gpmc clock alias for
all OMAP2+ devices and then you could simply call the following from the
gpmc probe ...

	gpmc_fck = clk_get(&pdev->dev, "fck");

You could then store somewhere in one of the gpmc structures.

Cheers
Jon

[1] 39a80c7f379e1c1d3e63b204b8353b7381d0a3d5
