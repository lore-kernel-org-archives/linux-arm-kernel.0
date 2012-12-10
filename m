From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Dec 2012 11:16:04 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121210190552.74acbe5a@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com> <50C62161.9080708@wwwdotorg.org>
 <20121210190552.74acbe5a@skate>
Message-ID: <50C626E4.1010808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2012 11:05 AM, Thomas Petazzoni wrote:
> Dear Stephen Warren,
> 
> On Mon, 10 Dec 2012 10:52:33 -0700, Stephen Warren wrote:
> 
>> Mainly as background:
>>
>> I /think/ Tegra has a similar HW setup (but perhaps not identical)
>> (based on a very brief reading of your emails and brief knowledge of
>> this aspect of the Tegra HW).
>>
>> On Tegra, there is a 1GB physical address window that the PCIe
>> controller serves. The controller has 2 or 3 ports, each a separate PCIe
>> domain I believe. There are registers in the PCIe controller which route
>> accessed made to the 1GB physical window to the various child ports and
>> transaction types.
> 
> On Marvell SoCs, this is even more flexible: you have 20 configurable
> address decoding windows. For each of them, you can configure the base
> address, size, and target device (i.e PCIe port x.y, NAND, or some
> other devices). And since we have up to 10 PCIe interfaces, we really
> don't want to over-allocate hundreds of MB of physical address space for
> each device, since most of them need only a few dozens of KB.

OK, that all makes sense.

One question though: When you say "device" in the line above, I assume
the device you're referring to is the PCIe host device, and not the
individual PCIe devices themselves; with 20 address decoding windows and
10 PCIe ports, and those windows apparently being used for on-SoC
devices too (e.g. you mention NAND above), I assume you'd want to limit
the number of windows you use per PCIe bus/port to just 1, rather than 1
per enumerated PCIe device?
