From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 27 Nov 2012 17:19:05 +0200
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <6982060.HfOokt4dIn@avalon>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <20121121114018.GA31576@avionic-0098.adnet.avionic-design.de>
 <50ACC341.3090204@ti.com> <6982060.HfOokt4dIn@avalon>
Message-ID: <50B4D9E9.8070607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-27 17:08, Laurent Pinchart wrote:
> Hi Tomi,
> 
> On Wednesday 21 November 2012 14:04:17 Tomi Valkeinen wrote:
>> On 2012-11-21 13:40, Thierry Reding wrote:
> 
> [snip]
> 
>>> One thing that's not very clear is how the backlight subsystem should be
>>> wired up with the display framework. I have a patch on top of the Tegra
>>> DRM driver which adds some ad-hoc display support using this power
>>> sequences series and the pwm-backlight.
>>
>> I think that's a separate issue: how to associate the lcd device and
>> backlight device together. I don't have a clear answer to this.
>>
>> There are many ways the backlight may be handled. In some cases the
>> panel and the backlight are truly independent, and you can use the other
>> without using the other (not very practical, though =).
> 
> From a control point of view that's always the case for DPI panels (as those 
> panels have no control bus, the backlight control bus is by definition 
> separate) and is the case for the two DBI panels I've seen (but I won't claim 
> that's a significative number of panels).

They may have a control bus, I2C, SPI, etc. In some cases that can be
used to control the backlight. But yes, it's separate from the video bus.

>> But then with some LCDs the backlight may be controlled by sending commands
>> to the panel, and in this case the two may be quite linked. Changing the
>> backlight requires the panel driver to be up and running, and sometimes the
>> sending the backlight commands may need to be (say, DSI display, with
>> backlight commands going over the DSI bus).
> 
> When you write "sending commands to the panel", do you mean on the same 
> control bus that the panel use ? Or would that also include for instance an 
> I2C backlight controller integrated inside a DSI panel module ? In the later 

I mean the same control bus that is used to control the panel, be it
shared with video bus like DSI, or separate like I2C.

> case there might still be dependencies between the panel controller and the 
> backlight controller (let's say for instance that the panel controller has a 
> DSI-controller GPIO wired to the backlight controller reset signal), but in 
> practice I don't know if that's ever the case.
> 
>> So my feeling is that the panel driver should know about the related
>> backlight device. In the first case the panel driver would just call
>> enable/disable in the backlight device when the panel is turned on.
> 
> That makes sense. Unless I'm mistaken a backlight is always associated with a 
> panel (it would be called a light if there was no panel in front of it). We 
> can thus expose backlight operations in the panel CDF (in-kernel) API. The 
> panel driver would need a way to retrieve a pointer to the associated 
> backlight device.

I agree.

>> In the second case of the DSI panel... I'm not sure. I've implemented it
>> so that the panel driver creates the backlight device, and implements
>> the backlight callbacks. It then sends the DSI commands from those
>> callbacks.
> 
> If we decide to make the panel expose backlight operations we could get rid of 
> the backlight device in this case.

Do you mean there would be a real backlight device only when there's a
totally independent backlight for the panel?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/0da60787/attachment-0001.sig>
