From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 29 Aug 2014 11:23:57 -0700
Subject: [PATCH 3/3] ARM: zynq: DT: Add Ethernet phys
In-Reply-To: <20140829173102.GA30917@obsidianresearch.com>
References: <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
 <5a7b6f57-b6c0-4fb3-af0d-d403277c0207@BN1AFFO11FD045.protection.gbl>
 <53F5D8D9.7040604@suse.de>
 <f166a186-301c-4288-97cf-71f8173c07e7@BN1AFFO11FD010.protection.gbl>
 <CAGVrzcYWN83tznwvw1M9V_mwWgobs2kwtRvEj4stqE=XGC10fg@mail.gmail.com>
 <20140825174610.GA13737@obsidianresearch.com> <53FB9AC4.8010704@gmail.com>
 <660fe929-1f16-4e22-8bd3-0388cd363978@BY2FFO11FD038.protection.gbl>
 <540099AF.4020005@suse.de>
 <e52ebd6c-2f0d-4ea9-a01f-882212956ace@BL2FFO11FD029.protection.gbl>
 <20140829173102.GA30917@obsidianresearch.com>
Message-ID: <5400C53D.70501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2014 10:31 AM, Jason Gunthorpe wrote:
> On Fri, Aug 29, 2014 at 08:35:36AM -0700, S?ren Brinkmann wrote:
> 
>> The compatible string is listed as optional property for PHYs. So, not
>> having one is an option, I guess. But, I'd also prefer to at least keep
>> the -c22 one, since I saw problems when I tried using -c45 (the Zed phy
>> should support it...).
> 
> -c45 and -c22 use a completely different MDIO protocol, Zed doesn't
> have a 10GE port, so it certainly doesn't use -c45.

Most recent 1GbE PHYs should also implement clause 45. It is a nice
improvement if you are using lot of transactions, otherwise clause 45
over clause 22 is suitable and supported by the PHY library (for EEE in
particular).

> 
> If there is no compatible string at all the defined default is to use
> -c22.

Absolutely, the current binding makes that property optional, but I
think we should make it mandatory instead.

> 
>> Also, so far, we haven't had any phy nodes in our Zynq dts files and
>> Ethernet worked, so the auto-detection there works pretty well
>> apparently. But it may be problematic if more than a single PHY is on
>> the MDIO bus, I'd assume.
> 
> Phy autodetection has always worked in some cases, but for DT ethernet
> bindings it is expected that there is an option to specify an explicit
> MDIO bus, and a phy-handle phandle to point to the phy. The phy should
> be explicitly called out with the fixed MDIO address specified to
> avoid sketchy MDIO address auto probing.
> 
> This provides the framework to specify interrupts and register
> overrides for the phy in the DT.

Absolutely, on the plus side, avoiding auto-detection also allows you to
have a shorter boot time (usually by a factor of few hundreds of msecs
depending on how the MDIO buses handle errors).
--
Florian
