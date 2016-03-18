From: scott.wood@nxp.com (Scott Wood)
Date: Fri, 18 Mar 2016 18:28:05 +0000
Subject: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <DB5PR0401MB19286B2D23D07F5C60DB799D91880@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <20160317170101.GA21009@rob-hp-laptop> <3706958.XeRFmKM0K5@wuerfel>
Message-ID: <DB5PR0401MB1928DA88B03970E1EACFB1FF918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2016 12:06 PM, Arnd Bergmann wrote:
> On Thursday 17 March 2016 12:01:01 Rob Herring wrote:
>> On Mon, Mar 14, 2016 at 05:45:43PM +0000, Scott Wood wrote:
> 
>>>>> This makes the driver non-portable. Better identify the specific
>>>>> workarounds based on the compatible string for this device, or add a
>>>>> boolean DT property for the quirk.
>>>>>
>>>>>    Arnd
>>>>
>>>> [Lu Yangbo-B47093] Hi Arnd, we did have a discussion about using DTS in v1 before.
>>>> https://patchwork.kernel.org/patch/6834221/
>>>>
>>>> We don?t have a separate DTS file for each revision of an SOC and if we did, we'd constantly have people using the wrong one.
>>>> In addition, the device tree is stable ABI and errata are often discovered after device tree are deployed.
>>>> See the link for details.
>>>>
>>>> So we decide to read SVR from the device-config/guts MMIO block other than using DTS.
>>>> Thanks.
>>>
>>> Also note that this driver is already only for fsl-specific hardware,
>>> and it will still work even if fsl_guts doesn't find anything to bind to
>>> -- it just wouldn't be able to detect errata based on SVR in that case.
>>
>> IIRC, it is the same IP block as i.MX and Arnd's point is this won't 
>> even compile on !PPC. It is things like this that prevent sharing the 
>> driver.

The whole point of using the MMIO SVR instead of the PPC SPR is so that
it will work on ARM...  The guts driver should build on any platform as
long as OF is enabled, and if it doesn't find a node to bind to it will
return 0 for SVR, and the eSDHC driver will continue (after printing an
error that should be removed) without the ability to test for errata
based on SVR.

> I think the first four patches take care of building for ARM,
> but the problem remains if you want to enable COMPILE_TEST as
> we need for certain automated checking.

What specific problem is there with COMPILE_TEST?

>> Dealing with Si revs is a common problem. We should have a 
>> common solution. There is soc_device for this purpose.
> 
> Exactly. The last time this came up, I think we agreed to implement a
> helper using glob_match() on the soc_device strings. Unfortunately
> this hasn't happened then, but I'd still prefer that over yet another
> vendor-specific way of dealing with the generic issue.

soc_device would require encoding the SVR as a string and then decoding
the string, which is more complicated and error prone than having
platform-specific code test a platform-specific number.  And when would
it get registered on arm64, which doesn't have platform code?

-Scott
