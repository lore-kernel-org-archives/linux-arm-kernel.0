From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 12 May 2010 20:23:21 +0200
Subject: OTG implementation with external transceiver on PXA270
In-Reply-To: <AANLkTikw_VJog3nxH6lcJT4mRJbBcEju-2u6HFpdH3cv@mail.gmail.com>
	(Eric Miao's message of "Tue, 11 May 2010 14:04:22 +0800")
References: <AANLkTim7lTbhu97hy3tiSXVpkQKr5X6YpU8zSUiVarca@mail.gmail.com>
	<AANLkTikw_VJog3nxH6lcJT4mRJbBcEju-2u6HFpdH3cv@mail.gmail.com>
Message-ID: <87mxw5yo6e.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao <eric.y.miao@gmail.com> writes:

> On Mon, May 10, 2010 at 9:33 AM, Sergey Lapin <slapinid@gmail.com> wrote:
>> Hi, all!
>>
>> I try to implement external OTG transceiver on PXA270.
...
>>
>> * make chip-specific data struct global (like it is in isp1301_omap.c and
>> make exported function in OTG driver, enable handling of OTG interrupts in
>> pxa27x_udc and call that function from there.

Namespace expansion will be going on with every hardware, your second option is
far better IMO.

>> * add API function like otg_handle_interrupt, enable handling of OTG
>> interrupts in pxa27x_udc and call it from there. Which seems to be less
>> messy.

That seems a good idea.
If you expand it further, you could design the full OTG framework :
 - extend otg.c, add the OTG state machine
 - extend otg.h and otg.c with new calls :
   - otg_set_state()
   - otg_get_state()
   - otg_signal_udc()
 - extend otg.h, with callbacks like :
   - otg_handle_interrupt()

Separate the isp1301 driver from pxa270. The link will be done through the OTG
framework. Remember the pxa270 has taken the udc IO space, so no access can be
done from the isp1301 side (it should not actually for clean separation).

But that could be more or less what you were thinking about.

>> Any other suggestions? If that work is really being done somewhere,
>> I'd like to help with testing.
No, nobody fiddled yet with OTG on pxa270 :)

> The problem with isp1301_omap.c is that it's not separating the components
> into otg controller and otg transciever, which means at the moment the quickest
> way is to write something similar as isp1301_pxa27x.c, but apparently, the
> optimal way in my POV is to have a good abstraction, so the OTG transceiver
> and controller code can be re-used.
Exactly my thinking.

And you should ask David Brownell or Alan Stern, they have sharp ideas on the
usb framework.

Cheers.

--
Robert
