From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Fri, 04 Sep 2015 08:43:24 +0200
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in host-only
 mode
In-Reply-To: <55C47041.3000603@schinagl.nl>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <55C31963.2010701@schinagl.nl> <55C3709C.4080609@redhat.com>
 <55C47041.3000603@schinagl.nl>
Message-ID: <55E93D8C.9020804@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Hans,

On 07-08-15 10:45, Olliver Schinagl wrote:
> <snip>
>> If you change the dr_mode to host then you _must_ also remove any 
>> id_det and vbus_det
>> gpio settings from the usb_phy node in the dts, as the sun4i phy code 
>> detects
>> host vs otg mode by checking for the presence of these.
> Yes, this fixes it and makes it work. Thanks.
>
I've been going back to this and am wondering if this is something I can 
look into to fix properly? E.g. if the dts sets dr_mode = host, can we 
simply ignore the pins and treat them as unset?

Reason why I'm asking, the board we are using, the Lime2 has all the 
stuff required for regular otg mode. The cables however that we connect 
to the miniusb however do not force host only mode via the id pin, which 
would have been the preferred way. We use a 'shield' for our lime with 
various connections and thus have a dts for this shield, which includes 
the lime2 dts. In the lime2 dts you want the otg pins enabled and set in 
the generic usbphy section.

In my overlay, I ideally don't want to unset the pins, but do want to 
set dr_mode (as i can't force it from userspace can I?). The logical 
thing in my mind, would be to then just ignore those pins even when set, 
right?

Olliver
