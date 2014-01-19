From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Jan 2014 19:32:58 +0000
Subject: [RFC v3 10/13] ahci_imx: Adjust for ahci_platform managing the
 clocks
In-Reply-To: <52DC27DD.5030309@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-11-git-send-email-hdegoede@redhat.com>
 <20140119124134.GQ15937@n2100.arm.linux.org.uk> <52DC27DD.5030309@redhat.com>
Message-ID: <20140119193258.GT15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 08:30:37PM +0100, Hans de Goede wrote:
> Hi,
>
> On 01/19/2014 01:41 PM, Russell King - ARM Linux wrote:
>> On Sun, Jan 19, 2014 at 12:48:52AM +0100, Hans de Goede wrote:
>>> +enum {
>>> +	CLK_SATA,
>>> +	CLK_SATA_REF,
>>> +	CLK_AHB
>>> +};
>>
>> Err, so we now rely on the order that these clocks are specified in DT
>> rather than their name properties to provide the correct clock... that
>> sounds particularly fragile to me.
>
> Both in the ohci- / ehci-platform case, where the idea of purely addressing
> clocks by index comes from, as well as in the ahci-platform case, people
> have been asking me to make things more generic, so as to avoid having
> a gazillion almost but not quite the same ehci-foo platform drivers.
>
> This has already happened with ohci-foo.c drivers, and the hope is that
> with the new generalized ohci-plaform.c many of the existing ohci-foo
> drivers can go away over time.
>
> The downside of this generalized approach is that we cannot use clock-names
> since those tend to be implementation specific.
>
> In the specific case of the ahci-imx driver this means that certain clocks
> must be at a specific index, since it needs to know which one is the AHB
> clock, as documented in the bindings documentation. I don't see how mandating
> certain indices is different and/or more fragile then mandating certain names
> in the bindings document. I agree that is is slightly less clear to someone
> reading the dts, but that is the price we have to pay for this desire for
> things to be generic.

So what happens if we have the same IP block appearing, but the SATA_REF
or SATA clock isn't present - how do we still provide an AHB clock (for
argument sake)?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
