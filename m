From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 May 2015 12:35:03 -0600
Subject: How to encode being an I2C slave in DT?
In-Reply-To: <20150506174757.GZ25193@pengutronix.de>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150505105513.GA1841@katana> <20150506065928.GP25193@pengutronix.de>
 <3394114.re5da8pjTi@fb07-iapwap2> <20150506080951.GS25193@pengutronix.de>
 <554A39F1.9060507@wwwdotorg.org> <20150506174757.GZ25193@pengutronix.de>
Message-ID: <554A5ED7.8080808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2015 11:47 AM, Uwe Kleine-K?nig wrote:
> Hello Stephen,
>
> On Wed, May 06, 2015 at 09:57:37AM -0600, Stephen Warren wrote:
>> On 05/06/2015 02:09 AM, Uwe Kleine-K?nig wrote:
>>> On Wed, May 06, 2015 at 09:53:55AM +0200, Marc Dietrich wrote:
>>>> Am Mittwoch, 6. Mai 2015, 08:59:28 schrieb Uwe Kleine-K?nig:
>>>>> On Tue, May 05, 2015 at 12:55:13PM +0200, Wolfram Sang wrote:
>>>>>> So what about adding a new property "i2c-slave-reg"? This does not only
>>>>>> prevent the confusion above, but also makes it very clear that this node
>>>>>> is an I2C slave without the need to encode that somehow in the
>>>>>> compatible property (although it probably should be described there as
>>>>>> well, still).
>>>>>
>>>>> I admit I didn't follow the discussions referenced in the footnotes, but
>>>>> I wonder if the slave part should be added to the device tree at all.
>>>>> AFAICT it could (and so should) be completely userspace-defined which
>>>>> slave driver is used on which address. I imagine that for most
>>>>> controllers the bus addresses to use can be chosen more or less freely.
>>>>> So what am I missing?
>>>>
>>>> if you had read the footnotes you would know :-) Our usecase is connect an
>>>> embeedded controller via i2c to the host soc, similar to cros-ec, but here the
>>>> ec is the i2c master. The ec connects keyboard, mouse, pwrmngt, and other
>>>> stuff, for which the drivers are best implemented in kernel code AFAIK.
>>>
>>> Right, the driver might sensibly be implemented in kernel space. But I'd
>>> vote that you still need to do the binding of these drivers to your
>>> slave controller from userspace. Then there is no need to specify
>>> anything in your dtb.
>>
>> I think the set of I2C slave devices that are implemented by the
>> Linux system can reasonably be considered part of the HW definition.
>> Most DT content to date has been a definition of the HW that's
>> available to SW, but at least in this case, this I2C slave device is
>> something that must be implemented (admittedly in conjunction with
>> SW) using the I2C slave HW on the main SoC, in order for the overall
>> HW to work as intended.
 >
> I'm not convinced. Why must it be implemented?

The other HW in the system expects the I2C slave device to exist. I 
believe that makes it a HW level description, and hence suitable to 
represent in DT.

Representing this in DT saves user-space from requiring board-specific 
knowledge. The kernel should be abstracting HW as best it can, so that 
user-space can be entirely generic, supporting classes of devices, not 
enumeration/instantiation of devices. Assuming a system didn't store its 
root filesystem on a particular SD card or USB controller, we could 
instantiate those controllers from user-space too (or an initrd even if 
the root fs was there). However, we choose not to do that...

In the specific case of nvec (the I2C slave device that triggered this 
thread) and I dare say other devices too, there is more to the device 
than just the I2C slave device. There's also a GPIO that serves to 
provide synchronization between the SoC and external device.

 > And is it too late if the setup is done by userspace?

The primary purpose of nvec is to provide keyboard and mouse (touchpad) 
input, so enabling this once user space was booted would probably work. 
However, the device should likely be enabled by the initrd not the root 
filesystem (if such a split exists in a given distro) so that the user 
can actually interact with any initrd shell if the boot fails. That 
would bloat the initrd. System power management (power off at least) 
goes through the same device, so deferring that might not be great, but 
I suppose there likely wouldn't be a "turn power off" event requested 
until user-space was booted.

> The devicetree description of a flash chip doesn't include the rootfs
> content either, although a working rootfs is critical for most operating
> systems. The devicetree description of an ethernet adapter doesn't
> include its network setup although an ethernet adapter hardly makes any
> sense without an IP.
>
>> BTW, I believe devicetree-spec at vger.kernel.org was created to
>> address subsystem-level DT schema questions like this. It's much
>> lower volume, so perhaps the thread would get noticed by the DT
>> maintainers if posted there (or perhaps just CC them)?
 >
> I added them to Cc.
