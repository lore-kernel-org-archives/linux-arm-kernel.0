From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Dec 2012 10:03:38 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121218025113.GA27029@obsidianresearch.com>
References: <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
Message-ID: <50D0A1EA.9090009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 07:51 PM, Jason Gunthorpe wrote:
> [trimmed the cc list]
> 
> On Mon, Dec 17, 2012 at 07:10:59PM -0700, Stephen Warren wrote:
> 
>>> What I'll do next is add some caching of written values, so that
>>> reading them back actually yields something correct. After that
>>> I'll post what I have so that others can look at it or even reuse
>>> it.
>>
>> Some internal discussion implies this shouldn't be required; here's
>> what they said:
> 
> Looking at the driver, it says:
> 
> + * 0x80000000 - 0x80003fff - PCI controller registers
> + * 0x80004000 - 0x80103fff - PCI configuration space
> + * 0x80104000 - 0x80203fff - PCI extended configuration space
> 
> And the bridge config regions are at:
> 
> +#define RP0_OFFSET     0x0000
> +#define RP1_OFFSET     0x1000
> 
> And from the first checkin, config space accesses have been split into
> three designations:
>  bridge #0 - 0x80000000 + 0
>  bridge #1 - 0x80000000 + 0x1000
>  Every other bus - 0x80104000 + [equation]
> 
> And based on Thierry's results it looks like once the bridge
> subordinate bus numbers are setup (via their lower mappings) then the
> 'every other bus' mapping starts working as expected.
> 
> So.. is there a register to be set that lets the bridge configuration
> be accessed through the [0x80004000 - 0x80103fff] region as bus 0?
> Presumably a non-PCI device number register?

It looks like some PCI host controller registers do need to be set up
(so far the information is related to "type 0" vs. "type 1"
configuration accesses, although I'm not familiar with what that means).

Jay will continue to drive this with our HW folks and try and get this
working.
