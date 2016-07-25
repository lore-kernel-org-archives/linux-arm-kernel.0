From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jul 2016 17:34:16 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <44b2703e-a417-eb3e-b154-6919dc6618d7@nvidia.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <20160725113034.GD21170@ulmo.ba.sec>
 <CALw8SCWEFVu__8Gyr5q995h+=oMQEz1VUNB=Ne7MRb0O-tZXqg@mail.gmail.com>
 <20160725141544.GN21170@ulmo.ba.sec>
 <CALw8SCWouYF+CY7n67mFxyL2CFbY4k1oB7oySTU9WkSMqosFUA@mail.gmail.com>
 <44b2703e-a417-eb3e-b154-6919dc6618d7@nvidia.com>
Message-ID: <20160725153416.GT21170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 04:01:49PM +0100, Jon Hunter wrote:
> 
> On 25/07/16 15:38, Mirza Krak wrote:
> > 2016-07-25 16:15 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> >> On Mon, Jul 25, 2016 at 03:16:28PM +0200, Mirza Krak wrote:
> >>> 2016-07-25 13:30 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> >> [...]
> >>>> The above suggests that one of the CAN controllers gets mapped to an
> >>>> address 0x48000000 and the other gets mapped to 0x48040000. But why do
> >>>> we even need a chip-select at all in that case? If both chips don't use
> >>>> any overlapping memory region, what good does the chip-select do?
> >>>
> >>> If we take a look on similar controllers found on others SOCs they
> >>> usually define an address range / chip-select.
> >>>
> >>> Example (weim):
> >>> ranges = <
> >>> 0 0 0x10000000 0x02000000
> >>> 1 0 0x12000000 0x01000000
> >>> 2 0 0x13000000 0x01000000
> >>> 3 0 0x14000000 0x01000000
> >>> 4 0 0x15000000 0x01000000
> >>> 5 0 0x16000000 0x01000000
> >>>> ;
> >>>
> >>> Which means that you all ready have an address mapped to PIN function.
> >>>
> >>> But Tegra GMI controller is a first for me, where you do not have this
> >>> kind of setup in hardware. Usually you also have a timing register /
> >>> chip-select so that you can connect different chip types.
> >>>
> >>> The lack of hardware support do decode an address to a chip-select PIN
> >>> function, we have implemented this our self externally.
> >>>
> >>> We actually have 6 different chips connected to the GMI bus and the
> >>> "ranges" would be:
> >>>   ranges = <
> >>>    0 0 0x48000000 0x00000100
> >>>    1 0 0x48040000 0x00000100
> >>>    2 0 0x48080000 0x00000100
> >>>    3 0 0x480A0000 0x00000100
> >>>    4 0 0x480C0000 0x00000100
> >>>    5 0 0x480E0000 0x00000100
> >>>   >;
> >>>
> >>> And this not nothing complicated, small number of AND gates and that is it.
> >>>
> >>> The chip-select signal is necessary for the access characteristics, so
> >>> we need to translate an address to an chip-select so that the chip
> >>> knows the host CPU wants to talk to it.
> >>>
> >>> Do not know if I made anything more clear here :).
> >>
> >> Yes, that clarifies many things. The presence of an external, address-
> >> based chip-select is essential information in order to describe this
> >> setup properly.
> >>
> >> Given that the external chip select is entirely invisible to software, I
> >> think a more accurate description of your setup would be:
> >>
> >>         gmi at 70090000 {
> >>                 ...
> >>
> >>                 /* for the chip select */
> >>                 #address-cells = <1>;
> >>                 #size-cells = <0>;
> >>
> >>                 /*
> >>                  * Technically this could be used to translate the range from
> >>                  * 0x48000000 to 0x4fffffff into a different range, but that
> >>                  * no longer works because of the #address-cells. Does this
> >>                  * matter?
> >>                  */
> >>                 ranges;
> >>
> >>                 bus at 0 {
> >>                         compatible = "simple-bus";
> >>                         reg = <0>;
> >>
> >>                         #address-cells = <1>;
> >>                         #size-cells = <1>;
> >>
> >>                         can at 48000000 {
> >>                                 reg = <0x48000000 0x100>;
> >>                                 ...
> >>                         };
> >>
> >>                         can at 48040000 {
> >>                                 reg = <0x48040000 0x100>;
> >>                                 ...
> >>                         };
> >>                 };
> >>         };
> >>
> >> That omits any reference to the external chip select, which I think
> >> makes sense because it's something that software is completely unaware
> >> of.
> >>
> >> Perhaps one important question: does your setup use the GMI's CS lines
> >> in any way? Or does it simply get ignored?
> > 
> > Yes, we use the GMI`s CS line. It is important that is present because
> > it is ANDED with address lines and NOT ALE line. Especially since we
> > run the GMI controller in AD_MUX mode, which means that we use same
> > pins for address and data and the access happens in two phases, one
> > address latch phase where CS is not asserted but ALE is, second
> > read/write phase where CS must be asserted. In this case we need the
> > GMI`s CS line to determine which phase we are in.
> 
> Even though the CS is used, we could still implement the driver such
> that if only 1 CS is defined in the binding, we then statically program
> the configuration at probe. For now, if there is more than one, we can
> return an error from probe as it is not supported or default to the
> first CS defined and warn?

I think either would work. Possibly better to do the latter because at
least some devices will work that way.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/eabe4ac1/attachment.sig>
