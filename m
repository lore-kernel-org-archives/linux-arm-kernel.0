From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 16:48:21 -0600
Subject: [PATCH 03/15] ARM: provide runtime hook for ioremap
In-Reply-To: <20120213223051.GE25655@n2100.arm.linux.org.uk>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-4-git-send-email-robherring2@gmail.com>
 <20120213223051.GE25655@n2100.arm.linux.org.uk>
Message-ID: <4F399335.60908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2012 04:30 PM, Russell King - ARM Linux wrote:
> On Mon, Feb 13, 2012 at 03:43:16PM -0600, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> We have compile time over-ride of ioremap, but an run-time override is
>> needed for multi-platform builds.
> 
> Are you sure we need this after Nicolas' updates to ioremap() ?

Yes, because these are adjusting the memory type, not redirecting the
ioremap to a static mapping. There was some discussion among Nico, Arnd
and myself about using static mappings instead as you can set the memory
type. The imx case is all addresses below 0x8000000 except the interrupt
controller need adjustment. This would burn up a lot more virtual space
or be a long list of peripherals. I think my change is much simpler and
is just generalizing what imx is doing for everyone.

There's also a few other custom ioremaps I didn't convert: ebsa110,
iop13xx, and ixp4xx. These platforms already have multiple issues with
single kernel.

Rob
