From: zonque@gmail.com (Daniel Mack)
Date: Tue, 30 Jul 2013 15:37:38 +0200
Subject: [RFC PATCH 0/2] impedance-matcher generic improvements
In-Reply-To: <20130730131725.GC5882@titan.lakedaemon.net>
References: <51F2A014.7000209@gmail.com>
 <cover.1375131816.git.jason@lakedaemon.net> <51F76FE3.1080302@gmail.com>
 <20130730131725.GC5882@titan.lakedaemon.net>
Message-ID: <51F7C1A2.5010208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 30.07.2013 15:17, Jason Cooper wrote:
> On Tue, Jul 30, 2013 at 09:48:51AM +0200, Daniel Mack wrote:
>> On 29.07.2013 23:23, Jason Cooper wrote:
>>> Basic idea is to replace a device's stock kernel with this impedance-matcher.
>>> Load the kernel and/or the devicetree blob to desired addresses.  Add
>>> 'loadaddrs=0xXXXXXXXX,0xYYYYYYYY' to the kernel's command line.  Or, if you are
>>> appending, 'loadaddrs=appended,0xYYYYYYYY'.  First address is the location of
>>> the kernel, second is the location of the dtb.
>>
>> Nice to see that idea implemented! For me though, changing any of the
>> U-Boot variables is out of the question, and I need the matcher just the
>> way I implemented it, including the LED blink pattern to let the user
>> know if things go wrong.
> 
> Understandable.  After thinking about it a bit, I think I'm going to
> rework this patch to allow appending both kernels and dtbs (as you had),
> and abstract out the led blink so that your code would become a compile
> time option.

And how would you match machids and system_rev values to the dtb files?
This is how I identify my boards at least. But as Stephen Warren said in
the thread that started this discussion, there might be totally
different ways of detection. For instance, other boards could read GPIO
lines, or even have a pseudo driver that initializes the I2C controller
in order to talk to an EEPROM or such. Reading from an ADC is another
option.

And the more I think about it, I believe Nicolas was right in saying
that such a thing does not need to be very generic (as much as I like
generic solutions in principle).

If at all, I think we should start thinking of that code base as
something like a framework, consisting of a merely empty main() function
body, a lds linker script and some objcopy magic in the Makefile. And
then have a menuconfig which allows to select one out of many hardware
types, which then uses its specific way of board detection, LED
signaling and so on. The two lines of vectoring to the actual kernel can
be generic then. But again, I really don't know if it's worth the hassle.

> hrmmm, I don't like forking on general principle.  Let me do the above
> rework and see if that works for you, while adding the capabilities I
> need.
> 
> When I'm done, you should just be able to do:
> 
>   $ make APPEND_KERNEL=input/zImage APPEND_DTBS=input/*.dtb uImage

Out of curiosity, I'd like to see how you dynamically create the symbol
definitions for the binary blobs :)

> In the meantime, would you mind adding a license to your code?  If you
> have no preference, I like GPLv2-only, but it's your code, so whatever
> you like.

Done, GPLv2 it is.


Thanks,
Daniel
