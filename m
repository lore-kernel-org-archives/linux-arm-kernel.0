From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Sep 2015 18:17:57 +0100
Subject: [PATCH v4 0/9] Making the generic ACPI GSI layer irqdomain aware
In-Reply-To: <CAL_Jsq+b10aEREipSsrg69=S4gpv-xZWRYS+TVTvhbqdHGATsA@mail.gmail.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
 <CAL_Jsq+b10aEREipSsrg69=S4gpv-xZWRYS+TVTvhbqdHGATsA@mail.gmail.com>
Message-ID: <560AC7C5.1090201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/15 18:11, Rob Herring wrote:
> On Mon, Sep 28, 2015 at 11:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> The irqdomain code is not entierely ACPI friendly, as it has some
>> built-in knowledge of the device-tree. Nothing too harmful, but enough
>> to scare the ARM ACPI developpers which end up with their own version
>> of the square wheel.
>>
>> This small patch series adapts the irqdomain code to remove the
>> hurdles that prevent the full blown irqdomain subsystem to be used on
>> ACPI, creates an interface between the GSI layer and the irqdomain,
>> and as an example, convert the ARM GIC ACPI support to use irqdomains
>> as originally intended.
>>
>> Overall, this gives us a way to use irqdomains on both DT and ACPI
>> enabled platforms, having very little changes made to the actual
>> drivers (other than the probing infrastructure). Because we keep the
>> flow of information between the various layers identical between ACPI
>> and DT, we immediately benefit from the existing infrastructure. The
>> "convert the GSI information to be DT friendly" is admitedly not very
>> pretty, but I see it as a stepping stone towards unifying the two
>> structures.
> 
> Did I miss v1-v3 or did the DT change just show up? I probably tuned
> out with ACPI in the subject.

No, that's new. It was far worse before.

> Needing fake DT nodes for ACPI is just wrong. There's got to be
> another, better way.

Well, the alternative is to rewrite the whole of irqdomain and
everything that gets called from there in terms of fwnode_handle. Which
will trickle in the whole of OF as well.

Note that the fake DT node doesn't represent an ACPI object at all. It
is an identifier for an irqdomain, and that's where it stops.

	M.
-- 
Jazz is not dead. It just smells funny...
