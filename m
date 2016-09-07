From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 07 Sep 2016 13:18:26 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160907093525.GK1041@n2100.armlinux.org.uk>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <20562703.Glp77l1PBf@wuerfel> <20160907074428.GB13903@b29397-desktop>
 <4780626.ofOZnpf19s@wuerfel> <20160907092901.GC13903@b29397-desktop>
 <20160907093525.GK1041@n2100.armlinux.org.uk>
Message-ID: <87lgz4ko7h.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> On Wed, Sep 07, 2016 at 05:29:01PM +0800, Peter Chen wrote:
>> On Wed, Sep 07, 2016 at 10:52:46AM +0200, Arnd Bergmann wrote:
>> > On Wednesday, September 7, 2016 3:44:28 PM CEST Peter Chen wrote:
>> > > 
>> > > The pre-condition of DT function at USB HCD core works is the host
>> > > controller device has of_node, since it is the root node for USB tree
>> > > described at DT. If the host controller device is not at DT, it needs
>> > > to try to get its of_node, the chipidea driver gets it through its
>> > > parent node [1]
>> > 
>> > > 
>> > > [1] https://lkml.org/lkml/2016/8/8/119
>> > > 
>> > 
>> > Ah, this is what I was referring to in the other mail.
>> > 
>> > However, the way you set the of_node might be dangerous too:
>> > We should generally not have two platform_device structures with
>> > the same of_node pointer, most importantly it may cause the
>> > child device to be bound to the same driver as the parent
>> > device since the probing is done by compatible string.
>> > 
>> > As you tested it successfully, it must work at the moment on your
>> > machine, but it could easily break depending on deferred probing
>> > or module load order.
>> > 
>> 
>> Currently, I work around above problems by setting core device of_node
>> as NULL at both probe error path and platform driver .remove routine.
>> 
>> I admit it is not a good way, but if we only have of_node at device's
>> life periods after probe, it seems ok currently. It is hard to create
>> of_node dynamically when create device, and keep some contents
>> of parent's of_node, and some are not.
>
> How about turning dwc3 into a library which can be used by a range of
> platform devices?  Wouldn't that solve all the current problems, and
> completely avoid the need to copy resources from one platform device
> to another?

This will break all existing DTs out there. Also, there are other
benefits from keeping current design, these have been discussed before
but here's a short summary:

. PM callbacks are kept simple
. We avoid abuse of internal dwc3 functions
. It's a lot less work to "port" dwc3 to "your SoC"
. We prevent another MUSB (drivers/usb/musb/)

And few others. Sure, they are rather subjective benefits, but it has
worked well so far. Also, breaking DT ABI is kind of a big deal.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/7405dd65/attachment.sig>
