From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Jun 2012 09:41:26 -0600
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <4FE1DE53.4070202@gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
 <4FD8C4DB.4020908@gmail.com>
 <20120614013343.GD29684@b20223-02.ap.freescale.net>
 <4FE1DE53.4070202@gmail.com>
Message-ID: <4FE1EF26.9080401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 08:29 AM, Rob Herring wrote:
> On 06/13/2012 08:33 PM, Richard Zhao wrote:
>> On Wed, Jun 13, 2012 at 11:50:35AM -0500, Rob Herring wrote:
>>> On 06/13/2012 10:28 AM, Richard Zhao wrote:
>>>> On Wed, Jun 13, 2012 at 10:09:54AM -0500, Rob Herring wrote:
>>>>> On 06/13/2012 07:34 AM, Richard Zhao wrote:
>>>>>> Sometimes, boards have gpios that don't own by any driver or owner
>>>>>> by a generic driver that don't like hacks. Such gpios is normally
>>>>>> output and need setup once on boot. So I introduce the config-on-boot
>>>>>> gpios.
...
>>>>>> diff --git a/Documentation/devicetree/bindings/arm/config-on-boot.txt b/Documentation/devicetree/bindings/arm/config-on-boot.txt
...
>>>>>> +Node name: config-on-boot
>>>>>> +  It must be in root node. config-on-boot means to describe settings that needs
>>>>>> +  to be set one time on boot but aren't owned by any driver, or the owned driver
>>>>>> +  is too generic to handle such settings. For example, usb hub uses generic
>>>>>> +  driver in usb core code, a on-board usb may need deassert reset pin.
>>>>>
>>>>> NAK. This is not a h/w description
...
>>> You need to describe that you have a hub on the usb bus and add the gpio
>>> line to that node. Just like PCI is probe-able, you still need DT nodes
>>> sometimes for cases like this.
>>
>> PCI has dev id and may add quirks. But for embedded, I don't know how
>> to connect a of node to a hub device enumerated by usb core code. And
>> it may also pollute the usb core code.
> 
> USB also uses device and manufacturer ids. One of the main reasons for
> putting pci devices into dts is to describe out of band signals just
> like this.
> 
> Creating a binding and support code for full usb bus topology would be a
> lot of work which is why I propose a simpler approach below.
> 
>>> A simpler approach would be to just add
>>> the gpio to the ehci controller node, but that's not exactly correct.
>> That's exactly why this patch comes out.
> 
> I mean just something like "fsl,hub-reset-gpios" in the ehci device
> node. It's at least under a usb node. Whether the ehci driver handles
> this or you just have a separate piece of code to find this property and
> setup the gpio is up to you.

I haven't been following the thread, but just noticed it. Very similar
things (DT nodes for probed devices) are coming up quite a bit recently,
for example:

Re: Where to power on the wifi device before loading the driver.
http://www.spinics.net/lists/arm-kernel/msg180368.html

dt: rfkill-gpio: add bindings documentation
http://www.spinics.net/lists/linux-tegra/msg03977.html

I wonder if there's any kind of infra-structure or standardized bindings
that would be useful here?
