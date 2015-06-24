From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 24 Jun 2015 14:18:48 +0200
Subject: [linux-sunxi] [PATCH 2/8] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
In-Reply-To: <20150613135055.GQ19653@lukather>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
 <CAGb2v652W+i6L1k5-CnHtXZXdJjFswkcyFGromhWSYaXtitW_w@mail.gmail.com>
 <5577EDD9.8020900@redhat.com> <20150613135055.GQ19653@lukather>
Message-ID: <CAOMqctS=-Go-ETa=G__4hpBc13GJ7M7D3c0EUnQxc-a_fyX1rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 13 June 2015 at 15:50, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jun 10, 2015 at 09:57:13AM +0200, Hans de Goede wrote:
>> >>@@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] = {
>> >>                 .resources              = axp20x_pek_resources,
>> >>         }, {
>> >>                 .name                   = "axp20x-regulator",
>> >>+       }, {
>> >>+               .name                   = "axp20x-usb-power-supply",
>> >
>> >Could we use either "vbus-power-supply" to match the AXP datasheets,
>> >or "otg-power-supply" which is slightly more obvious to board owners?
>>
>> I do not like the vbus name, since it does not indicate which bus
>> it is, OTOH you are right that is what it is called in the datasheet.
>>
>> As for using otg, I think that usb is better then.
>>
>> All in all I believe that the current usb name is best, but if others
>> disagree I'm open to renaming this.
>>
>> So anyone else have an opinion on what would be a good name for the
>> cell and the compatible ?
>
> I usually prefer to use the name mentionned in the datasheet, but if
> that doesn't make sense, feel free to use an alternative like this
> one.

The power source is known as USB power since the reference Allwinner
design connects this pin to the USB OTG connector and all known boards
that use the AXP copy the design.

If somebody gets creative with the vbus input or there is another
manufacturer using AXP with different design it might get problematic
naming it usb.

However, either name is pretty much arbitrary and there is no need for
the vbus to be connected to a bus connector. You could design a board
with two plain power jacks and the AXP would switch between those
according to its priority. If this priority is not configurable then I
think it would be most descriptive to name the inputs as primary and
secondary AC.

The most important part is adding proper documentation so whatever the
name the user can understand that this is the part that is called vbus
in datasheed and is typically wired to the usb otg port.

I only found very terse doc patch.
It adds a new file without a reference in the main axp20x file. IMHO
there should be a reference for the sub-nodes or they should be all in
one file. Spreading the text into multitude of files that contain 2
lines of explanation and an example seems counter-productive. The
examples can be combined in one.

Another nit is that the doc shows axp202-usb-power-supply compatible
while the usb power is available on all AXP regulators for which there
are drivers since axp152. IMHO this can be just
x-powers,usb-power-supply since it can only appear as subnode of the
axp, anyway.

Thanks

Michal
